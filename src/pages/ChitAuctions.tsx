import { useMemo, useState } from 'react'
import { Gavel, Plus } from 'lucide-react'
import { repo } from '../data/repository'
import type { ChitAuction } from '../data/types'
import { useApp, canEdit, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { RunAuctionModal, AssignTakerModal } from './ChitDetail'
import { inr, fmtDate, num } from '../lib/format'

type Modal = { kind: 'post' } | { kind: 'taker'; auction: ChitAuction } | null

export default function ChitAuctions() {
  const financeSel = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role) && financeSel !== 'ALL'  // combined view is read-only
  const finance = financeFilter(financeSel)
  const [tick, setTick] = useState(0)
  const [modal, setModal] = useState<Modal>(null)

  const chits = useMemo(() => repo.chits(finance), [finance, tick])
  const [fund, setFund] = useState<string>('')
  const activeFund = fund || chits[0]?.Chit_ID || ''
  const chit = repo.chit(activeFund)
  const auctions = useMemo(() => activeFund ? repo.chitAuctions(activeFund) : [], [activeFund, tick])
  const takenByAuction = useMemo(() => {
    const m = new Map<string, string[]>()
    for (const t of activeFund ? repo.chitTakers(activeFund) : []) {
      const arr = m.get(t.Chit_Auction_ID) ?? []; arr.push(t.Member_Name ?? t.Member_ID); m.set(t.Chit_Auction_ID, arr)
    }
    return m
  }, [activeFund, tick])

  const refresh = () => { setModal(null); setTick(t => t + 1) }

  return (
    <div>
      <PageHeader
        title="Chit auctions"
        subtitle="Post each month's auction and record who took the chit."
        action={
          <div className="flex items-center gap-2">
            {chits.length > 0 && (
              <select className="input !w-auto !py-1.5 text-sm" value={activeFund} onChange={e => setFund(e.target.value)}>
                {chits.map(c => <option key={c.Chit_ID} value={c.Chit_ID}>Chit {c.Chit_Name}</option>)}
              </select>
            )}
            {editable && activeFund && <button className="btn-primary !py-1.5" onClick={() => setModal({ kind: 'post' })}><Gavel size={15} /> Post auction</button>}
          </div>
        }
      />

      {!activeFund ? <EmptyState title="No chit funds yet" hint="Create a chit fund first." /> : (
        <>
          <div className="mb-4 grid grid-cols-3 gap-3">
            <StatCard label="Auctions posted" value={auctions.length} tone="blue" icon={<Gavel size={18} />} />
            <StatCard label="Months" value={`${num(chit?.No_Month_Completed)} / ${num(chit?.Total_Month)}`} tone="green" />
            <StatCard label="Awaiting taker" value={auctions.filter(a => (takenByAuction.get(a.Chit_Auction_ID) ?? []).length === 0).length} tone="amber" />
          </div>

          {auctions.length === 0 ? <EmptyState title="No auctions yet" hint={editable ? 'Use “Post auction” to run month 1.' : undefined} /> : (
            <Card className="!p-0 overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead className="border-b border-slate-800 bg-slate-900/60">
                    <tr><Th>Month</Th><Th>Date</Th><Th right>Bid pot</Th><Th right>Per share</Th><Th right>Payout</Th><Th>Taken by</Th><Th>Status</Th>{editable && <Th>Action</Th>}</tr>
                  </thead>
                  <tbody className="divide-y divide-slate-800">
                    {auctions.map(a => {
                      const tk = takenByAuction.get(a.Chit_Auction_ID) ?? []
                      return (
                        <tr key={a.Chit_Auction_ID} className="hover:bg-slate-800/40">
                          <Td className="font-medium text-slate-200">#{num(a.Month_Count)}</Td>
                          <Td className="text-slate-400">{fmtDate(a.Date_Auction)}</Td>
                          <Td right className="text-slate-300">{inr(num(a.Total_Auction_Amount))}</Td>
                          <Td right className="text-slate-300">{inr(num(a.Indivitual_Member_Amount))}</Td>
                          <Td right className="text-hd">{inr(num(a.Total_Auction_Amount_After_Commission))}</Td>
                          <Td className="text-slate-300">{tk.length ? tk.join(', ') : <span className="text-slate-500">—</span>}</Td>
                          <Td><Badge tone={statusTone(a.Auction_Status)}>{a.Auction_Status ?? '—'}</Badge></Td>
                          {editable && <Td>{tk.length === 0 && <button className="btn-ghost !py-1 !px-2 text-xs" onClick={() => setModal({ kind: 'taker', auction: a })}><Plus size={12} /> Assign taker</button>}</Td>}
                        </tr>
                      )
                    })}
                  </tbody>
                </table>
              </div>
            </Card>
          )}
        </>
      )}

      {modal?.kind === 'post' && <RunAuctionModal chitId={activeFund} onClose={() => setModal(null)} onSaved={refresh} />}
      {modal?.kind === 'taker' && <AssignTakerModal chitId={activeFund} auction={modal.auction} onClose={() => setModal(null)} onSaved={refresh} />}
    </div>
  )
}
