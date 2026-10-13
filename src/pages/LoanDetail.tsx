import { useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Calculator, HandCoins, Pencil } from 'lucide-react'
import { repo, editLoan } from '../data/repository'
import { computeInterest } from '../lib/interestEngine'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field, AmountHint } from '../components/ui'
import RepayModal from '../components/RepayModal'
import { inr, fmtDate, num } from '../lib/format'
import type { Loan } from '../data/types'

export default function LoanDetail() {
  const { loanNo = '' } = useParams()
  const role = useApp(s => s.user?.role)
  const finance = useApp(s => s.finance)
  const id = decodeURIComponent(loanNo)
  const [tick, setTick] = useState(0)
  // "All finances" is view-only — no editing until a single finance is picked.
  const isMd = role === 'md' && finance !== 'ALL'
  const loan = useMemo(() => repo.loan(id), [id, tick])
  const interest = useMemo(() => repo.interestByLoan(id), [id, tick])
  const [repayOpen, setRepayOpen] = useState(false)
  const [editOpen, setEditOpen] = useState(false)

  const today = new Date().toISOString().slice(0, 10)
  const monthStart = today.slice(0, 8) + '01'
  const [from, setFrom] = useState(monthStart)
  const [to, setTo] = useState(today)

  const preview = useMemo(() => (loan ? computeInterest(loan, from, to) : null), [loan, from, to])

  if (!loan) return <EmptyState title="Loan not found" />

  const billed = interest.reduce((s, i) => s + num(i.Interest_Amount), 0)
  const received = interest.reduce((s, i) => s + num(i.Amount_Received), 0)
  const pendingInterest = interest.reduce((s, i) => s + num(i.Interest_Pending), 0)

  return (
    <div>
      <Link to="/loans" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Loans</Link>
      <PageHeader
        title={`Loan ${loan.Loan_No}`}
        subtitle={<Link to={`/customers/${encodeURIComponent(loan.Customer_STL_NO)}`} className="text-brand-300">{loan.Customer_Name} · {loan.Customer_STL_NO}</Link>}
        action={
          <div className="flex items-center gap-2">
            <Badge tone={statusTone(loan.Loan_Status)}>{loan.Loan_Status ?? '—'}</Badge>
            {isMd && (
              <button className="btn-ghost !py-1.5" onClick={() => setEditOpen(true)}><Pencil size={15} /> Edit</button>
            )}
          </div>
        }
      />

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Loan amount" value={inr(num(loan.Loan_Amount))} tone="blue" />
        <StatCard label="Outstanding" value={inr(num(loan.Outstand_Amount))} tone="amber" />
        <StatCard label="Interest billed" value={inr(billed)} tone="slate" sub={`${inr(pendingInterest)} pending`} />
        <StatCard label="Interest received" value={inr(received)} tone="green" />
      </div>

      <div className="mt-4 grid gap-4 lg:grid-cols-3">
        <Card>
          <h3 className="mb-3 font-semibold text-hd">Loan details</h3>
          <dl className="space-y-2 text-sm">
            <Row k="Given date" v={fmtDate(loan.Loan_Given_Date)} />
            <Row k="Interest type" v={loan.Interest_Type ?? '—'} />
            <Row k="Rate" v={loan.Interest_Type === 'Per_Month' ? `₹${num(loan.Interest_Per_Month_Per_Lakh)} / lakh / month` : `₹${num(loan.Interest_Per_day_Per_Lakh)} / lakh / day`} />
            <Row k="Referred partner" v={loan.Referred_Partner ?? '—'} />
            <Row k="Payment type" v={loan.Payment_Type ?? '—'} />
            <Row k="Repaid" v={inr(num(loan.Repaid_Amount))} />
          </dl>
        </Card>

        {/* Interest calculator — uses the exact engine ported from Apps Script */}
        <Card className="lg:col-span-2">
          <h3 className="mb-3 flex items-center gap-2 font-semibold text-hd"><Calculator size={16} /> Interest calculator</h3>
          <div className="flex flex-wrap gap-3">
            <div>
              <label className="label">From</label>
              <input type="date" className="input mt-1" value={from} onChange={e => setFrom(e.target.value)} />
            </div>
            <div>
              <label className="label">To</label>
              <input type="date" className="input mt-1" value={to} onChange={e => setTo(e.target.value)} />
            </div>
          </div>
          {preview && (
            <div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
              <MiniStat k="Billing days" v={String(preview.noOfDays)} />
              <MiniStat k="Raw interest" v={inr(Math.round(preview.rawInterest))} />
              <MiniStat k="Rounded (₹10)" v={inr(preview.interest)} accent />
              <MiniStat k="Month" v={preview.month} />
            </div>
          )}
          <p className="mt-3 text-xs text-slate-500">
            Same formula as your Google Sheet engine: actual-from = later of loan date / from-date, inclusive days, rounded to nearest ₹10.
          </p>
        </Card>
      </div>

      <h3 className="mb-2 mt-6 font-semibold text-hd">Interest schedule</h3>
      {interest.length === 0 ? <EmptyState title="No interest posted for this loan yet" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Period</Th><Th right>Days</Th><Th right>Interest</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {interest.slice().reverse().map((i, k) => (
                  <tr key={k} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{i.Month}</Td>
                    <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                    <Td right className="text-slate-400">{num(i.No_Days)}</Td>
                    <Td right className="text-hd">{inr(num(i.Interest_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                    <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                    <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {editOpen && (
        <EditLoanModal
          loan={loan}
          onClose={() => setEditOpen(false)}
          onSaved={() => { setEditOpen(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// Admin correction of a loan — the full loan-giving form in edit mode, so every
// detail entered when the loan was disbursed can be fixed. Repaid is kept
// consistent as (loan amount − outstanding). Logged & restorable.
function EditLoanModal({ loan, onClose, onSaved }: { loan: Loan; onClose: () => void; onSaved: () => void }) {
  const partners = repo.partners(loan.Finance_Name)
  const [amount, setAmount] = useState(String(num(loan.Loan_Amount)))
  const [outstanding, setOutstanding] = useState(String(num(loan.Outstand_Amount)))
  const [date, setDate] = useState((loan.Loan_Given_Date ?? '').slice(0, 10))
  const [type, setType] = useState<'Per_Day' | 'Per_Month'>(loan.Interest_Type === 'Per_Month' ? 'Per_Month' : 'Per_Day')
  const [rate, setRate] = useState(String(loan.Interest_Type === 'Per_Month' ? num(loan.Interest_Per_Month_Per_Lakh) : num(loan.Interest_Per_day_Per_Lakh)))
  const [bonds, setBonds] = useState(loan.No_Bond_Received != null ? String(num(loan.No_Bond_Received)) : '')
  const [chqs, setChqs] = useState(loan.No_Chq_Received != null ? String(num(loan.No_Chq_Received)) : '')
  const [partner, setPartner] = useState(loan.Referred_Partner ?? '')
  const [payType, setPayType] = useState(loan.Payment_Type ?? 'Cash')
  const [remarks, setRemarks] = useState(loan.Remarks ?? '')
  const [status, setStatus] = useState(loan.Loan_Status ?? 'Active')
  const [busy, setBusy] = useState(false)

  const perMonth = type === 'Per_Month'
  const amt = num(amount), out = num(outstanding)
  const repaid = Math.max(0, amt - out)
  const valid = amt > 0 && out >= 0 && out <= amt && num(rate) >= 0 && !busy

  async function save() {
    if (!valid) return
    setBusy(true)
    await editLoan(loan.Loan_No, {
      Loan_Amount: amt,
      Outstand_Amount: out,
      Repaid_Amount: repaid,
      Loan_Given_Date: date || loan.Loan_Given_Date,
      Interest_Type: type,
      // Keep both rate columns consistent with the chosen type (the other is zeroed).
      Interest_Per_day_Per_Lakh: perMonth ? 0 : num(rate),
      Interest_Per_Month_Per_Lakh: perMonth ? num(rate) : 0,
      No_Bond_Received: bonds.trim() ? num(bonds) : undefined,
      No_Chq_Received: chqs.trim() ? num(chqs) : undefined,
      Referred_Partner: partner || undefined,
      Payment_Type: payType,
      Remarks: remarks.trim() || undefined,
      Loan_Status: status,
    })
    onSaved()
  }

  return (
    <Modal title={`Edit loan ${loan.Loan_No}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid} onClick={save}>Save changes</button>
    </>}>
      <p className="text-sm text-slate-400">Correct any detail entered when this loan was given. Repaid is kept as (amount − outstanding). This is logged and can be restored from the Activity Log.</p>
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm text-slate-300">
        Customer: <b className="text-hd">{loan.Customer_Name}</b> · {loan.Customer_STL_NO}
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Loan amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Outstanding (₹)"><input className="input" inputMode="numeric" value={outstanding} onChange={e => setOutstanding(e.target.value)} /></Field>
      </div>
      <AmountHint value={amount} />
      {out > amt && <p className="text-xs text-rose-300">Outstanding can't be more than the loan amount.</p>}
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Repaid (auto)</span><span className="font-semibold text-hd">{inr(repaid)}</span></div>
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Given date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Status">
          <select className="input" value={status} onChange={e => setStatus(e.target.value)}>
            <option>Active</option><option>Closed</option>
            {status && !['Active', 'Closed'].includes(status) && <option value={status}>{status}</option>}
          </select>
        </Field>
      </div>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Interest type">
          <select className="input" value={type} onChange={e => setType(e.target.value as 'Per_Day' | 'Per_Month')}>
            <option value="Per_Day">Per day / lakh</option>
            <option value="Per_Month">Per month / lakh</option>
          </select>
        </Field>
        <Field label={perMonth ? 'Rate (₹/lakh/month)' : 'Rate (₹/lakh/day)'}><input className="input" inputMode="numeric" value={rate} onChange={e => setRate(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Bonds received"><input className="input" inputMode="numeric" value={bonds} onChange={e => setBonds(e.target.value)} /></Field>
        <Field label="Cheques received"><input className="input" inputMode="numeric" value={chqs} onChange={e => setChqs(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Referred partner">
          <select className="input" value={partner} onChange={e => setPartner(e.target.value)}>
            <option value="">—</option>
            {partners.map(p => <option key={p.Partner_ID} value={p.Partner_ID}>{p.Partner_Name} · {p.Partner_ID}</option>)}
          </select>
        </Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            {['Cash', 'Bank', 'UPI', 'Cheque'].map(o => <option key={o} value={o}>{o}</option>)}
            {/* Preserve a legacy value (e.g. "Other") that isn't one of the standard options. */}
            {payType && !['Cash', 'Bank', 'UPI', 'Cheque'].includes(payType) && <option value={payType}>{payType}</option>}
          </select>
        </Field>
      </div>
      <Field label="Remarks"><input className="input" value={remarks} onChange={e => setRemarks(e.target.value)} /></Field>
      <p className="text-xs text-slate-500">Note: this fixes the loan record only. If you're reversing a wrong repayment, also delete its entry from the Ledger tab so the cash balance matches.</p>
    </Modal>
  )
}

function Row({ k, v }: { k: string; v: string }) {
  return <div className="flex justify-between border-b border-slate-800/60 pb-2"><dt className="text-slate-400">{k}</dt><dd className="font-medium text-slate-200">{v}</dd></div>
}
function MiniStat({ k, v, accent }: { k: string; v: string; accent?: boolean }) {
  return (
    <div className="rounded-xl bg-slate-800/40 p-3">
      <p className="label">{k}</p>
      <p className={`mt-1 text-lg font-bold ${accent ? 'text-brand-300' : 'text-hd'}`}>{v}</p>
    </div>
  )
}
