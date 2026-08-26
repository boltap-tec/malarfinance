import { useMemo, useState } from 'react'
import { repo, repayLoan } from '../data/repository'
import { computeInterest } from '../lib/interestEngine'
import { Modal, Field } from './ui'
import { inr, num, fmtDate } from '../lib/format'
import type { Loan } from '../data/types'

const shiftDay = (d: string, days: number) => {
  const x = new Date(d); x.setDate(x.getDate() + days)
  return x.toISOString().slice(0, 10)
}
const nextDay = (d: string) => shiftDay(d, 1)

export default function RepayModal({ loan, onClose, onSaved, interestOnly }: { loan: Loan; onClose: () => void; onSaved: () => void; interestOnly?: boolean }) {
  const rows = repo.interestByLoan(loan.Loan_No)
  const pendingInterest = rows.reduce((s, i) => s + num(i.Interest_Pending), 0)
  const lastTo = rows.map(i => i.To_Date).filter(Boolean).sort().slice(-1)[0]

  const outstanding = num(loan.Outstand_Amount)
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [principal, setPrincipal] = useState('')         // typed by the user — no pre-fill
  const [interestStr, setInterestStr] = useState('')     // interest amount being paid now
  const [includeToday, setIncludeToday] = useState(true)
  const [payType, setPayType] = useState('Cash')
  const [note, setNote] = useState('')

  const p = num(principal)
  // Interest accrues ONLY on the amount being repaid (the closed principal), so
  // an empty principal means no fresh interest — consistent with the customer &
  // deposit repay screens. Already-posted interest still shows as pending.
  const base = p
  // Interest is calculated up to the repay date, or the previous day if the
  // customer shouldn't be charged for today. The ledger still uses the repay date.
  const calcTo = includeToday ? date : shiftDay(date, -1)
  const accrue = useMemo(() => {
    const from = lastTo ? nextDay(lastTo) : (loan.Loan_Given_Date ?? calcTo)
    if (new Date(from) > new Date(calcTo)) return null
    const pr = computeInterest({ ...loan, Loan_Amount: base }, from, calcTo)
    return pr.interest > 0 ? { from: pr.actualFromDate, to: pr.toDate, amount: pr.interest, month: pr.month } : null
  }, [loan, lastTo, calcTo, base])

  const accrued = accrue?.amount ?? 0
  const totalInterest = pendingInterest + accrued
  // Interest paid is typed by the user (no pre-fill); the total is shown as a reference.
  const interestPaid = Math.max(0, num(interestStr))
  const remainingInterest = Math.max(0, totalInterest - interestPaid)
  const valid = (p > 0 || interestPaid > 0) && p <= outstanding && interestPaid <= totalInterest

  async function save() {
    await repayLoan({
      loanNo: loan.Loan_No, principal: p, date, paymentType: payType,
      accrue: accrue ?? undefined, payInterest: interestPaid > 0, interestPaid,
      note: note.trim() || undefined,
    })
    onSaved()
  }

  return (
    <Modal
      title={`Repay loan ${loan.Loan_No}`}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Record repayment</button>
      </>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Outstanding principal</span><span className="font-semibold text-hd">{inr(outstanding)}</span></div>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">Pending interest</span><span className="font-semibold text-amber-300">{inr(pendingInterest)}</span></div>
        <div className="mt-1 flex justify-between">
          <span className="text-slate-400">Interest on repaid amount (to {fmtDate(calcTo)}{lastTo ? `, since ${fmtDate(lastTo)}` : ''})</span>
          <span className="font-semibold text-amber-300">{inr(accrued)}</span>
        </div>
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Principal repaid (₹)"><input className="input" inputMode="numeric" placeholder="Enter amount" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
        <Field label="Repay date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>

      <label className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
        <input type="checkbox" className="accent-brand-500" checked={includeToday} onChange={e => setIncludeToday(e.target.checked)} />
        Include today in the interest (calculate up to {fmtDate(date)}, else the previous day)
      </label>

      {/* Interest breakdown: previous pending + this closure's interest = total */}
      <div className="rounded-xl border border-slate-800 bg-slate-800/30 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Previous pending interest</span><span className="text-slate-200">{inr(pendingInterest)}</span></div>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">This repayment's interest</span><span className="text-slate-200">{inr(accrued)}</span></div>
        <div className="mt-1.5 flex justify-between border-t border-slate-700 pt-1.5 font-semibold"><span className="text-hd">Total interest due</span><span className="text-hd">{inr(totalInterest)}</span></div>
        <div className="mt-3">
          <span className="label">Interest paid now (₹)</span>
          <input
            className="input mt-1" inputMode="numeric" placeholder="Enter amount"
            value={interestStr}
            onChange={e => setInterestStr(e.target.value)}
          />
        </div>
        {interestPaid > totalInterest && <p className="mt-1 text-xs text-rose-300">Cannot pay more than the total interest due.</p>}
        {remainingInterest > 0 && interestPaid <= totalInterest && (
          <p className="mt-1.5 text-xs text-amber-300/90">{inr(remainingInterest)} will remain as <b>pending interest</b> on this loan.</p>
        )}
        {totalInterest > 0 && remainingInterest === 0 && interestPaid > 0 && (
          <p className="mt-1.5 text-xs text-emerald-300/90">All interest cleared.</p>
        )}
      </div>

      <Field label="Payment type">
        <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
          <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
        </select>
      </Field>
      <Field label="Notes / remarks"><input className="input" value={note} onChange={e => setNote(e.target.value)} placeholder="Optional — a note to remind you later" /></Field>

      {p >= outstanding && outstanding > 0 && <p className="text-xs text-emerald-300/80">Full principal — this loan will be marked Closed.</p>}
    </Modal>
  )
}
