import { useMemo, useState } from 'react'
import { accrueOnRepaidPrincipal, type DebtLine, type RepayAccrual } from '../lib/interestEngine'
import { Modal, Field } from './ui'
import { inr, num, fmtDate } from '../lib/format'

const shiftDay = (d: string, days: number) => {
  const x = new Date(d); x.setDate(x.getDate() + days)
  return x.toISOString().slice(0, 10)
}

// Repay a depositor or an other-finance lender. Principal is typed; interest on
// the refunded amount is charged from the day after the last posted interest up
// to the repay date (with an "include today" toggle), added to any previously
// pending interest. The user types how much interest to settle now.
export default function LiabilityRepayModal({
  title, name, code, outstanding, pendingInterest = 0, interestOnly, debts, rateLabel,
  onRepay, onClose, onSaved,
}: {
  title: string
  name: string
  code: string
  outstanding: number
  pendingInterest?: number
  interestOnly?: boolean
  debts?: DebtLine[]
  rateLabel?: string
  onRepay: (principal: number, interest: number, date: string, payType: string, note: string | undefined, accruals?: RepayAccrual[]) => Promise<void>
  onClose: () => void
  onSaved: () => void
}) {
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [principal, setPrincipal] = useState('')   // typed by the user — no pre-fill
  const [interestStr, setInterestStr] = useState('')
  const [includeToday, setIncludeToday] = useState(true)
  const [payType, setPayType] = useState('Cash')
  const [note, setNote] = useState('')
  const [busy, setBusy] = useState(false)

  const showPrincipal = !interestOnly
  const p = showPrincipal ? num(principal) : 0
  const calcTo = includeToday ? date : shiftDay(date, -1)

  const { accruals, accrued } = useMemo(() => {
    if (!debts || !showPrincipal) return { accruals: [] as RepayAccrual[], accrued: 0 }
    const r = accrueOnRepaidPrincipal(debts, p, calcTo)
    return { accruals: r.accruals, accrued: r.total }
  }, [debts, showPrincipal, p, calcTo])

  const totalInterest = pendingInterest + accrued
  const interestPaid = Math.max(0, num(interestStr))
  const remainingInterest = Math.max(0, totalInterest - interestPaid)
  const valid = (p > 0 || interestPaid > 0) && p <= outstanding && interestPaid <= totalInterest && !busy

  async function save() {
    if (!valid) return
    setBusy(true)
    await onRepay(p, interestPaid, date, payType, note.trim() || undefined, accruals)
    onSaved()
  }

  return (
    <Modal
      title={title}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Record payment</button>
      </>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <p className="font-semibold text-hd">{name} <span className="text-xs font-normal text-slate-500">· {code}</span></p>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">Outstanding</span><span className="font-semibold text-hd">{inr(outstanding)}</span></div>
        {rateLabel && <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest rate</span><span className="font-semibold text-slate-200">{rateLabel}</span></div>}
        {showPrincipal && <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest on repaid amount (to {fmtDate(calcTo)})</span><span className="font-semibold text-amber-300">{inr(accrued)}</span></div>}
      </div>

      {showPrincipal && (
        <Field label="Principal paid (₹)"><input className="input" inputMode="numeric" placeholder="Enter amount" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
      )}
      {p > outstanding && <p className="text-xs text-rose-300">Principal cannot exceed the outstanding ({inr(outstanding)}).</p>}

      {showPrincipal && debts && (
        <label className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
          <input type="checkbox" className="accent-brand-500" checked={includeToday} onChange={e => setIncludeToday(e.target.checked)} />
          Include today in the interest (calculate up to {fmtDate(date)}, else the previous day)
        </label>
      )}

      {/* Interest breakdown: previous pending + this repayment's interest = total */}
      <div className="rounded-xl border border-slate-800 bg-slate-800/30 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Previous pending interest</span><span className="text-slate-200">{inr(pendingInterest)}</span></div>
        {showPrincipal && <div className="mt-1 flex justify-between"><span className="text-slate-400">This repayment's interest</span><span className="text-slate-200">{inr(accrued)}</span></div>}
        <div className="mt-1.5 flex justify-between border-t border-slate-700 pt-1.5 font-semibold"><span className="text-hd">Total interest due</span><span className="text-hd">{inr(totalInterest)}</span></div>
        <div className="mt-3">
          <span className="label">Interest paid now (₹)</span>
          <input className="input mt-1" inputMode="numeric" placeholder="Enter amount" value={interestStr} onChange={e => setInterestStr(e.target.value)} />
        </div>
        {interestPaid > totalInterest && <p className="mt-1 text-xs text-rose-300">Cannot pay more than the total interest due.</p>}
        {remainingInterest > 0 && interestPaid <= totalInterest && (
          <p className="mt-1.5 text-xs text-amber-300/90">{inr(remainingInterest)} will remain as <b>pending interest</b>.</p>
        )}
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Payment date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
          </select>
        </Field>
      </div>
      <Field label="Notes / remarks"><input className="input" value={note} onChange={e => setNote(e.target.value)} placeholder="Optional — a note to remind you later" /></Field>
      <p className="text-xs text-slate-500">Principal refund and interest post as two separate ledger entries; interest settles the schedule oldest-first.</p>
    </Modal>
  )
}
