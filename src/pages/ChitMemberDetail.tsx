import { useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Phone, MapPin, Users2, HandCoins, Coins, Printer, Plus, Pencil } from 'lucide-react'
import { repo, collectChitDue, payChitTaker, editChitTakerPayment, deleteChitTakerPayment, getSettings } from '../data/repository'
import type { ChitLedgerRow, ChitTakenMember, ChitTakenPayment } from '../data/types'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { AmountModal } from './ChitDetail'
import ReminderButton from '../components/ReminderButton'
import { buildChitMemberMessage } from '../lib/reminder'
import { inr, phone, fmtDate, num } from '../lib/format'

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
  const [payTaker, setPayTaker] = useState<ChitTakenMember | null>(null)
  const [editPay, setEditPay] = useState<ChitTakenPayment | null>(null)

  const { member, chit, dues, takings, payments, totals } = useMemo(() => {
    const member = repo.chitMember(id)
    const chit = member ? repo.chit(member.Chit_ID) : undefined
    const dues = repo.chitLedgerByMember(id)
    const takings = member ? repo.chitTakers(member.Chit_ID).filter(t => t.Member_ID === id) : []
    // Payout installments grouped by the taking they belong to.
    const payments: Record<string, ChitTakenPayment[]> = {}
    for (const t of takings) payments[t.Chit_Taken_ID] = repo.chitTakerPayments(t.Chit_Taken_ID)
    const totals = {
      due: dues.reduce((s, r) => s + num(r.Due_Amount), 0),
      recv: dues.reduce((s, r) => s + num(r.Received_Amount), 0),
      pend: dues.reduce((s, r) => s + num(r.Pending_Amount), 0),
      payout: takings.reduce((s, t) => s + num(t.Total_Amount_to_Member), 0),
      payoutGiven: takings.reduce((s, t) => s + num(t.Amount_Given_to_Member), 0),
      payoutPending: takings.reduce((s, t) => s + num(t.Pending_Amount), 0),
    }
    return { member, chit, dues, takings, payments, totals }
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
              header={member.Member_Name}
              phone={member.Member_Phone_No}
              message={buildChitMemberMessage({
                name: member.Member_Name,
                totalPending: totals.pend,
                months: dues
                  .filter(r => num(r.Pending_Amount) > 0)
                  .sort((a, b) => num(a.Month_Count) - num(b.Month_Count))
                  .map(r => ({ month: num(r.Month_Count), pending: num(r.Pending_Amount) })),
                status: member.Chit_Taken,
                completedMonth: dues.reduce((mx, r) => Math.max(mx, num(r.Month_Count)), 0),
                note: getSettings().paymentNote,
              })}
            />
            <button className="btn-ghost !py-1.5" onClick={() => printMemberStatement({ member, chitName: chit?.Chit_Name, dues, takings, payments, ...totals })}><Printer size={15} /> Statement</button>
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
          <div className="space-y-4">
            {takings.map(t => {
              const pays = payments[t.Chit_Taken_ID] ?? []
              const recorded = pays.reduce((s, p) => s + num(p.Amount), 0)
              // Payouts given before this history existed (legacy running total).
              const earlier = Math.max(0, num(t.Amount_Given_to_Member) - recorded)
              return (
                <Card key={t.Chit_Taken_ID} className="!p-0 overflow-hidden">
                  <div className="flex flex-wrap items-center justify-between gap-2 border-b border-slate-800 bg-slate-900/40 px-4 py-3">
                    <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-sm">
                      <span className="text-slate-300">Month #{num(t.Month_Count)}</span>
                      <span className="text-slate-500">{fmtDate(t.Date_Auction)}</span>
                      <span className="text-slate-400">Payout <b className="text-hd">{inr(num(t.Total_Amount_to_Member))}</b></span>
                      <span className="text-emerald-400">Given {inr(num(t.Amount_Given_to_Member))}</span>
                      {num(t.Pending_Amount) > 0 && <span className="text-rose-300">Pending {inr(num(t.Pending_Amount))}</span>}
                      <Badge tone={statusTone(t.Status)}>{t.Status ?? '—'}</Badge>
                    </div>
                    {editable && num(t.Pending_Amount) > 0 && (
                      <button className="btn-primary !py-1.5" onClick={() => setPayTaker(t)}><Plus size={14} /> Record payment</button>
                    )}
                  </div>
                  {(pays.length > 0 || earlier > 0) ? (
                    <div className="overflow-x-auto">
                      <table className="w-full">
                        <thead className="border-b border-slate-800 bg-slate-900/60">
                          <tr><Th>Date</Th><Th>Type</Th><Th>Notes</Th><Th right>Amount</Th>{editable && <Th right>Edit</Th>}</tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800">
                          {earlier > 0 && (
                            <tr>
                              <Td className="italic text-slate-500">Earlier payouts</Td>
                              <Td className="text-slate-500">—</Td>
                              <Td className="italic text-slate-500">before history was kept</Td>
                              <Td right className="text-emerald-400/70">{inr(earlier)}</Td>
                              {editable && <Td right className="text-slate-600">—</Td>}
                            </tr>
                          )}
                          {pays.map(p => (
                            <tr key={p.Payment_ID} className="hover:bg-slate-800/40">
                              <Td className="text-slate-400">{fmtDate(p.Date)}</Td>
                              <Td className="text-slate-400">{p.Payment_Type ?? '—'}</Td>
                              <Td className="text-slate-400">{p.Remarks ?? '—'}</Td>
                              <Td right className="text-emerald-400">{inr(num(p.Amount))}</Td>
                              {editable && <Td right><button className="btn-ghost !py-1 !px-2 text-xs text-brand-300" onClick={() => setEditPay(p)}><Pencil size={12} /> Edit</button></Td>}
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  ) : (
                    <p className="px-4 py-4 text-sm text-slate-500">No payments recorded yet.{editable && num(t.Pending_Amount) > 0 ? ' Use “Record payment” to add one.' : ''}</p>
                  )}
                </Card>
              )
            })}
          </div>
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

      {payTaker && (
        <AmountModal
          title={`Record payout — ${payTaker.Member_Name}`}
          max={num(payTaker.Pending_Amount)}
          onClose={() => setPayTaker(null)}
          onSave={(amt, date, pt, remarks) => payChitTaker(payTaker.Chit_Taken_ID, amt, date, pt, remarks).then(() => { setPayTaker(null); setTick(t => t + 1) })}
        />
      )}

      {editPay && (
        <PaymentEditModal
          payment={editPay}
          onClose={() => setEditPay(null)}
          onSave={patch => editChitTakerPayment(editPay.Payment_ID, patch).then(() => { setEditPay(null); setTick(t => t + 1) })}
          onDelete={() => deleteChitTakerPayment(editPay.Payment_ID).then(() => { setEditPay(null); setTick(t => t + 1) })}
        />
      )}
    </div>
  )
}

// Edit (or delete) one recorded payout installment to a chit-taken member.
function PaymentEditModal({ payment, onClose, onSave, onDelete }: {
  payment: ChitTakenPayment
  onClose: () => void
  onSave: (patch: { amount: number; date: string; payType: string; remarks?: string }) => Promise<void>
  onDelete: () => Promise<void>
}) {
  const [amount, setAmount] = useState(String(num(payment.Amount)))
  const [date, setDate] = useState(payment.Date ?? new Date().toISOString().slice(0, 10))
  const [payType, setPayType] = useState(payment.Payment_Type ?? 'Cash')
  const [remarks, setRemarks] = useState(payment.Remarks ?? '')
  const [busy, setBusy] = useState(false)
  const amt = num(amount)
  const valid = amt > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await onSave({ amount: amt, date, payType, remarks: remarks.trim() || undefined })
  }
  async function remove() {
    if (busy) return
    if (!window.confirm('Delete this payout entry? The given/pending totals will be adjusted.')) return
    setBusy(true)
    await onDelete()
  }

  return (
    <Modal title="Edit payout" onClose={onClose} footer={<>
      <button className="btn-ghost !text-rose-300" disabled={busy} onClick={remove}>Delete</button>
      <div className="flex-1" />
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Save</button>
    </>}>
      <Field label="Amount (₹)" hint="Given/pending totals adjust by the difference"><input type="number" className="input" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}><option>Cash</option><option>UPI</option><option>Account</option><option>Other</option></select>
        </Field>
      </div>
      <Field label="Notes / remarks" hint="Optional"><input className="input" value={remarks} onChange={e => setRemarks(e.target.value)} /></Field>
    </Modal>
  )
}

// Printable / PDF statement for a single member (self-contained HTML → print).
interface PrintData {
  member: import('../data/types').ChitMember
  chitName?: string
  dues: ChitLedgerRow[]
  takings: import('../data/types').ChitTakenMember[]
  payments: Record<string, ChitTakenPayment[]>
  due: number; recv: number; pend: number; payout: number; payoutGiven: number; payoutPending: number
}
function printMemberStatement(d: PrintData): void {
  const esc = (s: unknown) => String(s ?? '').replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string))
  const rup = (n: number) => `₹${Math.round(n).toLocaleString('en-IN')}`
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
  // Dues received from the member — one row per month, now with the paid-on date.
  const paid = (s?: string) => /paid/i.test(String(s ?? '')) ? 'ok' : /partial/i.test(String(s ?? '')) ? 'part' : 'due'
  const dueRows = d.dues.map(r => `<tr>
    <td class="muted">#${num(r.Month_Count)} · ${esc(fmtDate(r.Date_Auction))}</td>
    <td class="r">${rup(num(r.Due_Amount))}</td>
    <td class="r pos">${rup(num(r.Received_Amount))}</td>
    <td class="muted">${num(r.Received_Amount) ? esc(fmtDate(r.Paid_Date)) : '—'}</td>
    <td class="r neg">${num(r.Pending_Amount) ? rup(num(r.Pending_Amount)) : '—'}</td>
    <td><span class="tag ${paid(r.Status)}">${esc(r.Status)}</span></td></tr>`).join('')
  // Payouts given to the member when they took the chit — the full installment
  // history (each dated payment), not just the running total.
  const payoutSection = d.takings.length ? `
    <h3>Chit taken — payout ${rup(d.payoutGiven)} of ${rup(d.payout)}</h3>
    ${d.takings.map(t => {
      const pays = (d.payments[t.Chit_Taken_ID] ?? []).slice().sort((a, b) => new Date(a.Date ?? 0).getTime() - new Date(b.Date ?? 0).getTime())
      const recorded = pays.reduce((s, p) => s + num(p.Amount), 0)
      const earlier = Math.max(0, num(t.Amount_Given_to_Member) - recorded)
      const instRows = [
        earlier > 0 ? `<tr><td class="muted">Earlier payouts</td><td class="muted">—</td><td class="muted"><i>before history was kept</i></td><td class="r pos">${rup(earlier)}</td></tr>` : '',
        ...pays.map(p => `<tr>
          <td class="muted">${esc(fmtDate(p.Date))}</td>
          <td><span class="pill">${esc(p.Payment_Type ?? '—')}</span></td>
          <td class="muted">${esc(p.Remarks ?? '—')}</td>
          <td class="r pos">${rup(num(p.Amount))}</td></tr>`),
      ].join('')
      return `
        <p class="sub2">Month #${num(t.Month_Count)} · ${esc(fmtDate(t.Date_Auction))} — payout ${rup(num(t.Total_Amount_to_Member))}, given ${rup(num(t.Amount_Given_to_Member))}${num(t.Pending_Amount) ? `, pending ${rup(num(t.Pending_Amount))}` : ''}</p>
        <table><thead><tr><th>Date</th><th>Type</th><th>Notes</th><th class="r">Amount</th></tr></thead>
        <tbody>${instRows || '<tr><td colspan="4">No payouts recorded yet.</td></tr>'}</tbody></table>`
    }).join('')}` : ''
  const html = `<!doctype html><html><head><meta charset="utf-8"><title>Chit statement — ${esc(d.member.Member_Name)}</title>
  <style>
    *{box-sizing:border-box} html{-webkit-print-color-adjust:exact;print-color-adjust:exact}
    body{font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#0f172a;margin:0;font-size:13px;background:#fff}
    .wrap{margin:28px 32px}
    .hero{background:linear-gradient(120deg,#f5f3ff,#fdf2f8);color:#0f172a;border:1px solid #f3e8ff;border-radius:14px;padding:18px 22px;margin:0 0 16px}
    .hero h1{font-size:21px;margin:0;color:#7e22ce} .hero .fin{font-size:13px;color:#475569;margin-top:2px}
    .hero .who{margin-top:12px;display:flex;flex-wrap:wrap;gap:6px 16px;font-size:12px}
    .hero .who .chip{background:#fff;border:1px solid #e9d5ff;color:#334155;border-radius:999px;padding:2px 10px} .hero .who .chip b{font-size:14px;color:#1e293b}
    h3{font-size:12px;margin:20px 0 6px;text-transform:uppercase;letter-spacing:.05em;color:#7e22ce;font-weight:800}
    .cards{display:flex;flex-wrap:wrap;gap:10px;margin:10px 0 4px} .cards div{flex:1;min-width:120px;border:1px solid;border-radius:10px;padding:9px 12px}
    .cards .k{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .cards .v{font-size:16px;font-weight:800}
    table{width:100%;border-collapse:collapse;margin-top:4px;border:1px solid #e2e8f0;border-radius:10px;overflow:hidden}
    thead tr{background:#f5f3ff} th{color:#7e22ce;font-size:10px;text-transform:uppercase;letter-spacing:.04em;padding:8px;text-align:left;border-bottom:1px solid #ede9fe}
    td{border-top:1px solid #eef2f7;padding:7px 8px;text-align:left} tbody tr:nth-child(even){background:#faf5ff}
    .r{text-align:right;font-variant-numeric:tabular-nums} .muted{color:#64748b}
    .pos{color:#047857;font-weight:600} .neg{color:#b91c1c;font-weight:600}
    .pill{display:inline-block;background:#f3e8ff;color:#7e22ce;border-radius:6px;padding:1px 7px;font-size:11px;font-weight:600}
    .tag{display:inline-block;border-radius:999px;padding:1px 9px;font-size:11px;font-weight:700}
    .tag.ok{background:#dcfce7;color:#047857} .tag.part{background:#fef3c7;color:#b45309} .tag.due{background:#fee2e2;color:#b91c1c}
    .sub2{font-size:12px;color:#334155;margin:16px 0 4px;font-weight:700}
    .foot{margin-top:22px;color:#94a3b8;font-size:11px}
    @media print{.wrap{margin:12mm}}
  </style></head><body><div class="wrap">
    <div class="hero">
      <h1>Chit Statement</h1>
      <div class="fin">${esc(d.member.Finance_Name)}${d.chitName ? ` · Chit ${esc(d.chitName)}` : ''}</div>
      <div class="who">
        <span class="chip"><b>${esc(d.member.Member_Name)}</b></span>
        <span class="chip">${esc(d.member.Member_ID)}</span>
        <span class="chip">Share ${num(d.member.Member_Percentage)}</span>
        ${d.member.Member_Phone_No ? `<span class="chip">${esc(d.member.Member_Phone_No)}</span>` : ''}
        <span class="chip">Chit ${d.member.Chit_Taken === 'Taken' ? 'taken' : 'not taken'}</span>
      </div>
    </div>
    <div class="cards">
      <div style="background:#eff6ff;border-color:#bfdbfe"><div class="k">Total due</div><div class="v" style="color:#1d4ed8">${rup(d.due)}</div></div>
      <div style="background:#f0fdf4;border-color:#bbf7d0"><div class="k">Paid</div><div class="v" style="color:#15803d">${rup(d.recv)}</div></div>
      <div style="background:#fef2f2;border-color:#fecaca"><div class="k">Pending</div><div class="v" style="color:#dc2626">${rup(d.pend)}</div></div>
    </div>
    <h3>Monthly dues — received from member</h3>
    <table><thead><tr><th>Month</th><th class="r">Due</th><th class="r">Paid</th><th>Paid on</th><th class="r">Pending</th><th>Status</th></tr></thead>
    <tbody>${dueRows || '<tr><td colspan="6">No dues yet.</td></tr>'}</tbody></table>
    ${payoutSection}
    <div class="foot">Generated ${today} · Arul Finance</div>
  </div>
    <script>window.onload=function(){window.print()}</script>
  </body></html>`
  const w = window.open('', '_blank')
  if (!w) { alert('Allow pop-ups to print the statement.'); return }
  w.document.open(); w.document.write(html); w.document.close()
}
