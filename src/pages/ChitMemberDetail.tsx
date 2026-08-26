import { useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Phone, MapPin, Users2, HandCoins, Coins, Printer } from 'lucide-react'
import { repo, collectChitDue } from '../data/repository'
import type { ChitLedgerRow } from '../data/types'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { AmountModal } from './ChitDetail'
import ReminderButton from '../components/ReminderButton'
import { inr, phone, fmtDate, num, mmYyyy } from '../lib/format'

// Full 360° view of one chit member — mirrors the customer/lender detail pages.
// Shows their profile, dues across every month, and any payouts when they took
// the chit. Reached by clicking a member's name on the chit screens.
export default function ChitMemberDetail() {
  const { memberId = '' } = useParams()
  const id = decodeURIComponent(memberId)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [tick, setTick] = useState(0)
  const [collect, setCollect] = useState<ChitLedgerRow | null>(null)

  const { member, chit, dues, takings, totals } = useMemo(() => {
    const member = repo.chitMember(id)
    const chit = member ? repo.chit(member.Chit_ID) : undefined
    const dues = repo.chitLedgerByMember(id)
    const takings = member ? repo.chitTakers(member.Chit_ID).filter(t => t.Member_ID === id) : []
    const totals = {
      due: dues.reduce((s, r) => s + num(r.Due_Amount), 0),
      recv: dues.reduce((s, r) => s + num(r.Received_Amount), 0),
      pend: dues.reduce((s, r) => s + num(r.Pending_Amount), 0),
      payout: takings.reduce((s, t) => s + num(t.Total_Amount_to_Member), 0),
      payoutGiven: takings.reduce((s, t) => s + num(t.Amount_Given_to_Member), 0),
      payoutPending: takings.reduce((s, t) => s + num(t.Pending_Amount), 0),
    }
    return { member, chit, dues, takings, totals }
  }, [id, tick])

  if (!member) return <EmptyState title="Chit member not found" />

  return (
    <div>
      <Link to={`/chit/${encodeURIComponent(member.Chit_ID)}`} className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Chit {chit?.Chit_Name ?? member.Chit_ID}</Link>
      <PageHeader
        title={member.Member_Name}
        subtitle={`${member.Member_ID} · Chit ${chit?.Chit_Name ?? member.Chit_ID} · ${member.Finance_Name}`}
        action={
          <div className="flex items-center gap-2">
            <Badge tone={member.Chit_Taken === 'Taken' ? 'green' : 'slate'}>{member.Chit_Taken === 'Taken' ? 'Taken' : 'Not taken'}</Badge>
            <ReminderButton
              header={`${chit?.Chit_Name ?? member.Chit_ID} - ${member.Member_Name}`}
              phone={member.Member_Phone_No}
              items={dues.map(r => ({ month: mmYyyy(r.Date_Auction) ?? `#${num(r.Month_Count)}`, amount: num(r.Due_Amount), pending: num(r.Pending_Amount) }))}
              totalLabel="Total Chit Due Pending"
              amountWord="Due"
            />
            <button className="btn-ghost !py-1.5" onClick={() => printMemberStatement({ member, chitName: chit?.Chit_Name, dues, takings, ...totals })}><Printer size={15} /> Print / PDF</button>
          </div>
        }
      />

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span className="flex items-center gap-1.5"><Phone size={14} /> {phone(member.Member_Phone_No)}</span>
        <span className="flex items-center gap-1.5"><Users2 size={14} /> Share {num(member.Member_Percentage)}</span>
        {member.Member_Commission !== undefined && member.Member_Commission !== null && (
          <span className="flex items-center gap-1.5">Commission {num(member.Member_Commission)}%</span>
        )}
        {member.Recommended_Partner && <span>Ref: {member.Recommended_Partner}</span>}
        {member.Member_Address && <span className="flex items-center gap-1.5"><MapPin size={14} /> {member.Member_Address}</span>}
      </div>

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Total due" value={inr(totals.due)} tone="blue" />
        <StatCard label="Paid" value={inr(totals.recv)} tone="green" />
        <StatCard label="Pending" value={inr(totals.pend)} tone="red" />
        <StatCard label="Payout taken" value={inr(totals.payoutGiven)} tone="amber" sub={totals.payoutPending ? `${inr(totals.payoutPending)} owed` : (totals.payout ? 'fully paid' : undefined)} />
      </div>

      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><Coins size={16} /> Monthly dues</h3>
      {dues.length === 0 ? <EmptyState title="No dues yet" hint="Run an auction to generate this member's dues." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Date</Th><Th right>Due</Th><Th right>Received</Th><Th right>Pending</Th><Th>Paid on</Th><Th>Status</Th>{editable && <Th>Action</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {dues.map(r => (
                  <tr key={r.ID} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">#{num(r.Month_Count)}</Td>
                    <Td className="text-slate-400">{fmtDate(r.Date_Auction)}</Td>
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
      )}

      {takings.length > 0 && (
        <>
          <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><HandCoins size={16} /> Chit taken — payouts</h3>
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Month</Th><Th>Date</Th><Th right>Share</Th><Th right>Payout</Th><Th right>Given</Th><Th right>Pending</Th><Th>Status</Th></tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {takings.map(t => (
                    <tr key={t.Chit_Taken_ID} className="hover:bg-slate-800/40">
                      <Td className="text-slate-300">#{num(t.Month_Count)}</Td>
                      <Td className="text-slate-400">{fmtDate(t.Date_Auction)}</Td>
                      <Td right className="text-slate-400">{num(t.Percentage_Need_to_Take)}</Td>
                      <Td right className="text-hd">{inr(num(t.Total_Amount_to_Member))}</Td>
                      <Td right className="text-emerald-400">{inr(num(t.Amount_Given_to_Member))}</Td>
                      <Td right className="text-rose-300">{num(t.Pending_Amount) ? inr(num(t.Pending_Amount)) : '—'}</Td>
                      <Td><Badge tone={statusTone(t.Status)}>{t.Status ?? '—'}</Badge></Td>
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
    </div>
  )
}

// Printable / PDF statement for a single member (self-contained HTML → print).
interface PrintData {
  member: import('../data/types').ChitMember
  chitName?: string
  dues: ChitLedgerRow[]
  takings: import('../data/types').ChitTakenMember[]
  due: number; recv: number; pend: number; payout: number; payoutGiven: number; payoutPending: number
}
function printMemberStatement(d: PrintData): void {
  const esc = (s: unknown) => String(s ?? '').replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string))
  const rup = (n: number) => `₹${Math.round(n).toLocaleString('en-IN')}`
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
  const dueRows = d.dues.map(r => `<tr>
    <td>#${num(r.Month_Count)} · ${esc(fmtDate(r.Date_Auction))}</td>
    <td class="r">${rup(num(r.Due_Amount))}</td>
    <td class="r">${rup(num(r.Received_Amount))}</td>
    <td class="r">${num(r.Pending_Amount) ? rup(num(r.Pending_Amount)) : '—'}</td>
    <td>${esc(r.Status)}</td></tr>`).join('')
  const payoutSection = d.takings.length ? `
    <h3>Chit taken — payout ${rup(d.payoutGiven)} of ${rup(d.payout)}</h3>
    <table><thead><tr><th>Month</th><th class="r">Share</th><th class="r">Payout</th><th class="r">Given</th><th class="r">Pending</th></tr></thead>
    <tbody>${d.takings.map(t => `<tr>
      <td>#${num(t.Month_Count)} · ${esc(fmtDate(t.Date_Auction))}</td>
      <td class="r">${num(t.Percentage_Need_to_Take)}</td>
      <td class="r">${rup(num(t.Total_Amount_to_Member))}</td>
      <td class="r">${rup(num(t.Amount_Given_to_Member))}</td>
      <td class="r">${num(t.Pending_Amount) ? rup(num(t.Pending_Amount)) : '—'}</td></tr>`).join('')}</tbody></table>` : ''
  const html = `<!doctype html><html><head><meta charset="utf-8"><title>Chit statement — ${esc(d.member.Member_Name)}</title>
  <style>
    *{box-sizing:border-box} body{font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#0f172a;margin:32px;font-size:13px}
    h1{font-size:20px;margin:0} h2{font-size:14px;color:#475569;margin:2px 0 16px} h3{font-size:13px;margin:20px 0 6px;text-transform:uppercase;letter-spacing:.04em;color:#475569}
    .meta{color:#475569;font-size:12px;margin-bottom:14px} .meta span{margin-right:14px}
    .cards{display:flex;gap:10px;margin:10px 0 4px} .cards div{flex:1;border:1px solid #e2e8f0;border-radius:8px;padding:8px 10px}
    .cards .k{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .cards .v{font-size:16px;font-weight:700}
    table{width:100%;border-collapse:collapse;margin-top:4px} th,td{border-bottom:1px solid #e2e8f0;padding:6px 8px;text-align:left}
    th{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .r{text-align:right;font-variant-numeric:tabular-nums}
    .foot{margin-top:24px;color:#94a3b8;font-size:11px} @media print{body{margin:12mm}}
  </style></head><body>
    <h1>Chit Statement</h1>
    <h2>${esc(d.member.Finance_Name)}${d.chitName ? ` · Chit ${esc(d.chitName)}` : ''}</h2>
    <div class="meta">
      <span><b>${esc(d.member.Member_Name)}</b></span>
      <span>${esc(d.member.Member_ID)}</span>
      <span>Share ${num(d.member.Member_Percentage)}</span>
      <span>${esc(d.member.Member_Phone_No ?? '')}</span>
      <span>Chit ${d.member.Chit_Taken === 'Taken' ? 'taken' : 'not taken'}</span>
    </div>
    <div class="cards">
      <div><div class="k">Total due</div><div class="v">${rup(d.due)}</div></div>
      <div><div class="k">Paid</div><div class="v">${rup(d.recv)}</div></div>
      <div><div class="k">Pending</div><div class="v">${rup(d.pend)}</div></div>
    </div>
    <h3>Monthly dues</h3>
    <table><thead><tr><th>Month</th><th class="r">Due</th><th class="r">Paid</th><th class="r">Pending</th><th>Status</th></tr></thead>
    <tbody>${dueRows || '<tr><td colspan="5">No dues yet.</td></tr>'}</tbody></table>
    ${payoutSection}
    <div class="foot">Generated ${today} · Arul Finance</div>
    <script>window.onload=function(){window.print()}</script>
  </body></html>`
  const w = window.open('', '_blank')
  if (!w) { alert('Allow pop-ups to print the statement.'); return }
  w.document.open(); w.document.write(html); w.document.close()
}
