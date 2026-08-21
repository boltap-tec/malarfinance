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
  const [principal, setPrincipal] = useState(interestOnly ? '0' : String(outstanding))
  const [payInterest, setPayInterest] = useState(true)
  const [includeToday, setIncludeToday] = useState(true)
  const [payType, setPayType] = useState('Cash')

  const p = num(principal)
  // Interest accrues on the amount being closed (the principal repaid); when
  // paying interest only, it accrues on the whole outstanding balance.
  const base = p > 0 ? p : outstanding
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
  const valid = (p > 0 || (payInterest && totalInterest > 0)) && p <= outstanding

  async function save() {
    await repayLoan({
      loanNo: loan.Loan_No, principal: p, date, paymentType: payType,
      accrue: accrue ?? undefined, payInterest,
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
          <span className="text-slate-400">Interest up to {fmtDate(calcTo)}{lastTo ? ` (since ${fmtDate(lastTo)})` : ''}</span>
          <span className="font-semibold text-amber-300">{inr(accrued)}</span>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <Field label="Principal repaid (₹)"><input className="input" inputMode="numeric" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
        <Field label="Repay date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>

      <label className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
        <input type="checkbox" className="accent-brand-500" checked={includeToday} onChange={e => setIncludeToday(e.target.checked)} />
        Include the repay date in interest (else calculated up to the previous day)
      </label>

      <label className="flex cursor-pointer items-center gap-2 rounded-xl bg-slate-800/40 px-3 py-2.5 text-sm">
        <input type="checkbox" className="accent-brand-500" checked={payInterest} onChange={e => setPayInterest(e.target.checked)} />
        <span className="text-slate-200">Customer pays the interest now</span>
        <span className="ml-auto font-semibold text-hd">{inr(totalInterest)}</span>
      </label>
      {!payInterest && totalInterest > 0 && (
        <p className="text-xs text-amber-300/80">{inr(totalInterest)} interest will be left as <b>Pending</b> against this loan.</p>
      )}

      <Field label="Payment type">
        <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
          <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
        </select>
      </Field>

      {p >= outstanding && outstanding > 0 && <p className="text-xs text-emerald-300/80">Full principal — this loan will be marked Closed.</p>}
    </Modal>
  )
}
