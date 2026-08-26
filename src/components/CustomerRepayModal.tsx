import { useMemo, useState } from 'react'
import { repo, repayCustomer } from '../data/repository'
import { computeInterest } from '../lib/interestEngine'
import { Modal, Field } from './ui'
import { inr, num, fmtDate } from '../lib/format'
import type { InterestRow } from '../data/types'

const shiftDay = (d: string, days: number) => {
  const x = new Date(d); x.setDate(x.getDate() + days)
  return x.toISOString().slice(0, 10)
}
const nextDay = (d: string) => shiftDay(d, 1)

// Repay a customer's loan(s). Principal is applied to the oldest loans first.
// Interest up to the repay date is calculated fresh on each active loan (an
// "include today" toggle decides whether today is charged), added to any
// previously-pending interest, and the user types how much interest to settle
// now — the rest stays pending. Two ledger entries are posted (principal + interest).
export default function CustomerRepayModal({
  stl, name, outstanding, pendingInterest, onClose, onSaved,
}: {
  stl: string
  name: string
  outstanding: number
  pendingInterest: number
  mode?: 'repay' | 'interest'
  onClose: () => void
  onSaved: () => void
}) {
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [principal, setPrincipal] = useState('')     // typed by the user — no pre-fill
  const [interestStr, setInterestStr] = useState('') // interest amount being paid now
  const [includeToday, setIncludeToday] = useState(true)
  const [payType, setPayType] = useState('Cash')
  const [note, setNote] = useState('')
  const [busy, setBusy] = useState(false)

  // Interest is charged up to the repay date, or the previous day when today
  // shouldn't be charged. The ledger still uses the repay date.
  const calcTo = includeToday ? date : shiftDay(date, -1)

  // Fresh interest on every active loan, from the day after its last posted
  // interest up to calcTo, on the loan's current outstanding.
  const accruals = useMemo(() => {
    const rows: InterestRow[] = []
    const loans = repo.loansByCustomer(stl).filter(l => (l.Loan_Status ?? '').toLowerCase() === 'active' && num(l.Outstand_Amount) > 0)
    for (const l of loans) {
      const lastTo = repo.interestByLoan(l.Loan_No).map(i => i.To_Date).filter(Boolean).sort().slice(-1)[0]
      const from = lastTo ? nextDay(lastTo) : (l.Loan_Given_Date ?? calcTo)
      if (new Date(from) > new Date(calcTo)) continue
      const pr = computeInterest({ ...l, Loan_Amount: num(l.Outstand_Amount) }, from, calcTo)
      if (pr.interest <= 0) continue
      rows.push({
        ID: `${l.Customer_Name}-${l.Customer_STL_NO}-${l.Loan_No}-${pr.month}-repay-${Date.now()}-${l.Loan_No}`,
        Finance_Name: l.Finance_Name, Loan_No: l.Loan_No,
        Customer_STL_NO: l.Customer_STL_NO, Customer_Name: l.Customer_Name,
        From_Date: pr.actualFromDate, To_Date: pr.toDate, Interest_Amount: pr.interest,
        Loan_Amount: num(l.Outstand_Amount), Month: pr.month,
        Description: `Interest on repayment — ${l.Loan_No}`,
        Amount_Received: 0, Status: 'Pending', Interest_Pending: pr.interest,
        Referred_Partner: l.Referred_Partner, Interest_Type: l.Interest_Type,
      })
    }
    return rows
  }, [stl, calcTo])

  const accrued = accruals.reduce((s, r) => s + num(r.Interest_Amount), 0)
  const totalInterest = pendingInterest + accrued
  const p = num(principal)
  const interestPaid = Math.max(0, num(interestStr))
  const remainingInterest = Math.max(0, totalInterest - interestPaid)
  const valid = (p > 0 || interestPaid > 0) && p <= outstanding && interestPaid <= totalInterest

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await repayCustomer({ stl, principal: p, interest: interestPaid, date, payType, note: note.trim() || undefined, accruals })
    onSaved()
  }

  return (
    <Modal
      title={`Repay — ${name}`}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>Record repayment</button>
      </>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Total outstanding loan</span><span className="font-semibold text-hd">{inr(outstanding)}</span></div>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest up to {fmtDate(calcTo)}</span><span className="font-semibold text-amber-300">{inr(accrued)}</span></div>
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Principal paid (₹)"><input className="input" inputMode="numeric" placeholder="Enter amount" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
        <Field label="Repay date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      {p > outstanding && <p className="text-xs text-rose-300">Principal cannot exceed the outstanding ({inr(outstanding)}).</p>}

      <label className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
        <input type="checkbox" className="accent-brand-500" checked={includeToday} onChange={e => setIncludeToday(e.target.checked)} />
        Include today in the interest (calculate up to {fmtDate(date)}, else the previous day)
      </label>

      {/* Interest breakdown: previous pending + this repayment's interest = total */}
      <div className="rounded-xl border border-slate-800 bg-slate-800/30 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Previous pending interest</span><span className="text-slate-200">{inr(pendingInterest)}</span></div>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">This repayment's interest</span><span className="text-slate-200">{inr(accrued)}</span></div>
        <div className="mt-1.5 flex justify-between border-t border-slate-700 pt-1.5 font-semibold"><span className="text-hd">Total interest due</span><span className="text-hd">{inr(totalInterest)}</span></div>
        <div className="mt-3">
          <span className="label">Interest paid now (₹)</span>
          <input className="input mt-1" inputMode="numeric" placeholder="Enter amount" value={interestStr} onChange={e => setInterestStr(e.target.value)} />
        </div>
        {interestPaid > totalInterest && <p className="mt-1 text-xs text-rose-300">Cannot pay more than the total interest due.</p>}
        {remainingInterest > 0 && interestPaid <= totalInterest && (
          <p className="mt-1.5 text-xs text-amber-300/90">{inr(remainingInterest)} will remain as <b>pending interest</b>.</p>
        )}
        {totalInterest > 0 && remainingInterest === 0 && interestPaid > 0 && (
          <p className="mt-1.5 text-xs text-emerald-300/90">All interest cleared.</p>
        )}
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
          </select>
        </Field>
      </div>
      <Field label="Notes / remarks"><input className="input" value={note} onChange={e => setNote(e.target.value)} placeholder="Optional — a note to remind you later" /></Field>
      <p className="text-xs text-slate-500">
        Principal reduces the oldest loan first; interest settles the oldest pending first. Principal and interest are posted as two separate ledger entries.
      </p>
      {p >= outstanding && outstanding > 0 && <p className="text-xs text-emerald-300/80">Full principal — the loan(s) will be marked Closed.</p>}
    </Modal>
  )
}
