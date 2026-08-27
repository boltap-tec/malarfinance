import { useMemo, useState } from 'react'
import { repo, repayCustomer, repayLoan, getSettings } from '../data/repository'
import { accrueOnRepaidPrincipal } from '../lib/interestEngine'
import { Modal, Field } from './ui'
import { inr, num, fmtDate } from '../lib/format'
import type { InterestRow, Loan } from '../data/types'

const shiftDay = (d: string, days: number) => {
  const x = new Date(d); x.setDate(x.getDate() + days)
  return x.toISOString().slice(0, 10)
}
const rateLabelOf = (l: Loan) => l.Interest_Type === 'Per_Month'
  ? `₹${num(l.Interest_Per_Month_Per_Lakh)}/L·mo`
  : `₹${num(l.Interest_Per_day_Per_Lakh)}/L·day`
const rateKeyOf = (l: Loan) => `${l.Interest_Type || 'Per_Day'}:${l.Interest_Type === 'Per_Month' ? num(l.Interest_Per_Month_Per_Lakh) : num(l.Interest_Per_day_Per_Lakh)}`

// Repay a customer's loan(s). When the customer has several loans you pick which
// one to close; if their rates differ you MUST pick one (so interest is charged
// at that loan's rate). When all rates match you may also repay "all loans
// (oldest first)". Interest is charged only on the amount being repaid, up to the
// repay date (with an "include today" toggle), plus any previously-pending interest.
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
  const loans = useMemo(
    () => repo.loansByCustomer(stl)
      .filter(l => (l.Loan_Status ?? '').toLowerCase() === 'active' && num(l.Outstand_Amount) > 0)
      .sort((a, b) => new Date(a.Loan_Given_Date ?? 0).getTime() - new Date(b.Loan_Given_Date ?? 0).getTime()),
    [stl],
  )
  const multi = loans.length > 1
  const allSameRate = loans.length > 0 && loans.every(l => rateKeyOf(l) === rateKeyOf(loans[0]))

  // Default target: a single loan → that loan; many loans same rate → ALL;
  // many loans with different rates → force an explicit choice.
  const [target, setTarget] = useState<string>(!multi ? (loans[0]?.Loan_No ?? '') : (allSameRate ? 'ALL' : ''))
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [principal, setPrincipal] = useState('')
  const [interestStr, setInterestStr] = useState('')
  const [includeToday, setIncludeToday] = useState(true)
  const [payType, setPayType] = useState('Cash')
  const [note, setNote] = useState('')
  const [busy, setBusy] = useState(false)

  const calcTo = includeToday ? date : shiftDay(date, -1)
  const p = num(principal)
  // Where interest starts when a loan has NO posted interest yet: the "Interest
  // posted up to" date from Settings (migration cut-over). computeInterest still
  // clamps to the loan's given date, so newer loans start from their own date.
  const postedUpto = getSettings().lastPostedDate || undefined

  const targetLoans = target === 'ALL' ? loans : loans.filter(l => l.Loan_No === target)
  const selOutstanding = target === 'ALL' ? outstanding : targetLoans.reduce((s, l) => s + num(l.Outstand_Amount), 0)
  const selPending = target === 'ALL'
    ? pendingInterest
    : targetLoans.reduce((s, l) => s + repo.interestByLoan(l.Loan_No).reduce((t, i) => t + num(i.Interest_Pending), 0), 0)
  const rateLabel = target === 'ALL' ? (allSameRate && loans[0] ? rateLabelOf(loans[0]) : 'mixed') : (targetLoans[0] ? rateLabelOf(targetLoans[0]) : '')

  // Interest on the repaid principal only, for the targeted loan(s), oldest first.
  const raw = useMemo(() => {
    const lines = targetLoans.map(l => ({
      key: l.Loan_No,
      outstanding: num(l.Outstand_Amount),
      type: l.Interest_Type,
      perDay: num(l.Interest_Per_day_Per_Lakh),
      perMonth: num(l.Interest_Per_Month_Per_Lakh),
      lastTo: repo.interestByLoan(l.Loan_No).map(i => i.To_Date).filter(Boolean).sort().slice(-1)[0] || postedUpto,
      givenDate: l.Loan_Given_Date,
    }))
    return accrueOnRepaidPrincipal(lines, p, calcTo).accruals
  }, [target, loans, p, calcTo]) // eslint-disable-line react-hooks/exhaustive-deps

  const accrued = raw.reduce((s, a) => s + num(a.amount), 0)
  const totalInterest = selPending + accrued
  const interestPaid = Math.max(0, num(interestStr))
  const remainingInterest = Math.max(0, totalInterest - interestPaid)
  const needChoice = multi && target === ''
  const valid = !needChoice && (p > 0 || interestPaid > 0) && p <= selOutstanding && interestPaid <= totalInterest

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    if (target === 'ALL') {
      const accrualRows: InterestRow[] = raw.map(a => {
        const l = loans.find(x => x.Loan_No === a.key)!
        return {
          ID: `${l.Customer_Name}-${l.Customer_STL_NO}-${l.Loan_No}-${a.month}-repay-${Date.now()}-${l.Loan_No}`,
          Finance_Name: l.Finance_Name, Loan_No: l.Loan_No,
          Customer_STL_NO: l.Customer_STL_NO, Customer_Name: l.Customer_Name,
          From_Date: a.from, To_Date: a.to, Interest_Amount: a.amount, Loan_Amount: a.base, Month: a.month,
          Description: `Interest on ₹${a.base.toLocaleString('en-IN')} repaid — ${l.Loan_No}`,
          Amount_Received: 0, Status: 'Pending', Interest_Pending: a.amount,
          Referred_Partner: l.Referred_Partner, Interest_Type: l.Interest_Type,
        }
      })
      await repayCustomer({ stl, principal: p, interest: interestPaid, date, payType, note: note.trim() || undefined, accruals: accrualRows })
    } else {
      const a = raw[0]
      await repayLoan({
        loanNo: target, principal: p, date, paymentType: payType,
        accrue: a ? { from: a.from, to: a.to, amount: a.amount, month: a.month } : undefined,
        payInterest: interestPaid > 0, interestPaid, note: note.trim() || undefined,
      })
    }
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
      {multi && (
        <Field label="Which loan to repay?" hint={allSameRate ? undefined : 'Rates differ — pick the loan you want to close.'}>
          <select className="input" value={target} onChange={e => { setTarget(e.target.value); setPrincipal(''); setInterestStr('') }}>
            {!allSameRate && <option value="">Choose a loan…</option>}
            {allSameRate && <option value="ALL">All loans (oldest first)</option>}
            {loans.map(l => <option key={l.Loan_No} value={l.Loan_No}>{l.Loan_No} · {rateLabelOf(l)} · {inr(num(l.Outstand_Amount))}</option>)}
          </select>
        </Field>
      )}

      {!needChoice && <>
        <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
          <div className="flex justify-between"><span className="text-slate-400">{target === 'ALL' ? 'Total outstanding loan' : 'Outstanding (this loan)'}</span><span className="font-semibold text-hd">{inr(selOutstanding)}</span></div>
          {rateLabel && <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest rate</span><span className="font-semibold text-slate-200">{rateLabel}</span></div>}
          <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest on repaid amount (to {fmtDate(calcTo)})</span><span className="font-semibold text-amber-300">{inr(accrued)}</span></div>
        </div>

        <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
          <Field label="Principal paid (₹)"><input className="input" inputMode="numeric" placeholder="Enter amount" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
          <Field label="Repay date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        </div>
        {p > selOutstanding && <p className="text-xs text-rose-300">Principal cannot exceed the outstanding ({inr(selOutstanding)}).</p>}

        <label className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
          <input type="checkbox" className="accent-brand-500" checked={includeToday} onChange={e => setIncludeToday(e.target.checked)} />
          Include today in the interest (calculate up to {fmtDate(date)}, else the previous day)
        </label>

        <div className="rounded-xl border border-slate-800 bg-slate-800/30 p-3 text-sm">
          <div className="flex justify-between"><span className="text-slate-400">Previous pending interest</span><span className="text-slate-200">{inr(selPending)}</span></div>
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
          {target === 'ALL' ? 'Principal reduces the oldest loan first; ' : ''}Interest settles the oldest pending first. Principal and interest post as two separate ledger entries.
        </p>
        {p >= selOutstanding && selOutstanding > 0 && <p className="text-xs text-emerald-300/80">Full principal — {target === 'ALL' ? 'the loan(s)' : 'this loan'} will be marked Closed.</p>}
      </>}
    </Modal>
  )
}
