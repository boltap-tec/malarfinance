import { useMemo, useState, type ReactNode } from 'react'
import { Link } from 'react-router-dom'
import { Coins, HandCoins } from 'lucide-react'
import { repo, collectChitDue } from '../data/repository'
import type { ChitLedgerRow } from '../data/types'
import { useApp, canEdit, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal } from '../components/ui'
import { AmountModal } from './ChitDetail'
import { inr, fmtDate, num } from '../lib/format'

export default function ChitTransactions() {
  const financeSel = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const finance = financeFilter(financeSel)
  const [tick, setTick] = useState(0)
  const [collect, setCollect] = useState<ChitLedgerRow | null>(null)
  const [detail, setDetail] = useState<ChitLedgerRow | null>(null)

  const chits = useMemo(() => repo.chits(finance), [finance, tick])
  const [fund, setFund] = useState<string>('')
  const activeFund = fund || chits[0]?.Chit_ID || ''
  const auctions = useMemo(() => activeFund ? repo.chitAuctions(activeFund) : [], [activeFund, tick])
  const [month, setMonth] = useState<number | null>(null)
  const latest = auctions.length ? num(auctions[auctions.length - 1].Month_Count) : null
  const shownMonth = month ?? latest
  const auction = auctions.find(a => num(a.Month_Count) === shownMonth)
  const rows = useMemo(() => auction ? repo.chitLedgerByAuction(auction.Chit_Auction_ID) : [], [auction, tick])

  const due = rows.reduce((s, r) => s + num(r.Due_Amount), 0)
  const recv = rows.reduce((s, r) => s + num(r.Received_Amount), 0)

  return (
    <div>
      <PageHeader
        title="Chit transactions"
        subtitle="Each member's monthly contribution — due, received and pending."
        action={
          <div className="flex items-center gap-2">
            {chits.length > 0 && (
              <select className="input !w-auto !py-1.5 text-sm" value={activeFund} onChange={e => { setFund(e.target.value); setMonth(null) }}>
                {chits.map(c => <option key={c.Chit_ID} value={c.Chit_ID}>Chit {c.Chit_Name}</option>)}
              </select>
            )}
            {auctions.length > 0 && (
              <select className="input !w-auto !py-1.5 text-sm" value={shownMonth ?? ''} onChange={e => setMonth(Number(e.target.value))}>
                {auctions.map(a => <option key={a.Chit_Auction_ID} value={num(a.Month_Count)}>Month {num(a.Month_Count)}</option>)}
              </select>
            )}
          </div>
        }
      />

      {!auction ? <EmptyState title="No auctions yet" hint="Post an auction to generate dues." /> : (
        <>
          <div className="mb-4 grid grid-cols-3 gap-3">
            <StatCard label="Due this month" value={inr(due)} tone="blue" icon={<Coins size={18} />} />
            <StatCard label="Collected" value={inr(recv)} tone="green" />
            <StatCard label="Pending" value={inr(due - recv)} tone="red" />
          </div>

          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Member</Th><Th right>Share</Th><Th right>Due</Th><Th right>Received</Th><Th right>Pending</Th><Th>Paid on</Th><Th>Status</Th>{editable && <Th>Action</Th>}</tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {rows.map(r => (
                    <tr key={r.ID} className="hover:bg-slate-800/40">
                      <Td><button className="text-left font-medium text-brand-300 hover:underline" onClick={() => setDetail(r)}>{r.Member_Name}</button></Td>
                      <Td right className="text-slate-400">{num(r.Member_Percentage)}</Td>
                      <Td right className="text-slate-300">{inr(num(r.Due_Amount))}</Td>
                      <Td right className="text-emerald-400">{inr(num(r.Received_Amount))}</Td>
                      <Td right className="text-rose-300">{num(r.Pending_Amount) ? inr(num(r.Pending_Amount)) : '—'}</Td>
                      <Td className="text-slate-400">{num(r.Received_Amount) ? fmtDate(r.Paid_Date) : '—'}</Td>
                      <Td><Badge tone={statusTone(r.Status)}>{r.Status ?? '—'}</Badge></Td>
                      {editable && <Td>{num(r.Pending_Amount) > 0 && <button className="btn-ghost !py-1 !px-2 text-xs text-emerald-300" onClick={() => setCollect(r)}><HandCoins size={12} /> Collect</button>}</Td>}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </>
      )}

      {collect && (
        <AmountModal
          title={`Collect due — ${collect.Member_Name}`}
          max={num(collect.Pending_Amount)}
          onClose={() => setCollect(null)}
          onSave={(amt, date, pt, remarks) => collectChitDue(collect.ID, amt, date, pt, remarks).then(() => { setCollect(null); setTick(t => t + 1) })}
        />
      )}

      {detail && <TransactionDetailModal row={detail} onClose={() => setDetail(null)} />}
    </div>
  )
}

// Full detail for one chit transaction (ledger row), opened by clicking the member.
function TransactionDetailModal({ row, onClose }: { row: ChitLedgerRow; onClose: () => void }) {
  const auction = repo.chitAuction(row.Chit_Auction_ID)
  const Item = ({ k, v }: { k: string; v: ReactNode }) => (
    <div className="flex justify-between gap-4 border-b border-slate-800 py-1.5 text-sm last:border-0">
      <span className="text-slate-400">{k}</span><span className="text-right text-slate-200">{v}</span>
    </div>
  )
  return (
    <Modal title={`${row.Member_Name} · Month #${num(row.Month_Count)}`} onClose={onClose} footer={<button className="btn-primary" onClick={onClose}>Close</button>}>
      <div className="rounded-lg bg-slate-800/40 px-3 py-1">
        <Item k="Transaction ID" v={row.ID} />
        <Item k="Member" v={<Link to={`/chit/member/${encodeURIComponent(row.Member_ID)}`} className="text-brand-300 hover:underline">{row.Member_Name}</Link>} />
        <Item k="Chit" v={`${row.Chit_Name ?? row.Chit_ID}`} />
        <Item k="Month" v={`#${num(row.Month_Count)} · ${fmtDate(row.Date_Auction)}`} />
        <Item k="Auction ID" v={row.Chit_Auction_ID} />
        {auction && <Item k="Auction bid pot" v={inr(num(auction.Total_Auction_Amount))} />}
        <Item k="Share" v={num(row.Member_Percentage)} />
        <Item k="One share amount" v={inr(num(row.One_Share_Amount))} />
        <Item k="Due" v={inr(num(row.Due_Amount))} />
        <Item k="Received" v={<span className="text-emerald-400">{inr(num(row.Received_Amount))}</span>} />
        <Item k="Pending" v={<span className="text-rose-300">{inr(num(row.Pending_Amount))}</span>} />
        <Item k="Payment type" v={row.Payment_Type ?? '—'} />
        <Item k="Paid on" v={num(row.Received_Amount) ? fmtDate(row.Paid_Date) : '—'} />
        <Item k="Status" v={<Badge tone={statusTone(row.Status)}>{row.Status ?? '—'}</Badge>} />
        {row.Recommended_Partner && <Item k="Recommended partner" v={row.Recommended_Partner} />}
        {row.Remarks && <Item k="Remarks" v={row.Remarks} />}
      </div>
      <p className="mt-3 text-xs text-slate-500">Open the member to see their full dues and payout history.</p>
    </Modal>
  )
}
