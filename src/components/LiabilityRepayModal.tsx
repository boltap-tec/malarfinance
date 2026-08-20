import { useMemo, useState } from 'react'
import { computeInterest } from '../lib/interestEngine'
import { Modal, Field } from './ui'
import { inr, num, fmtDate } from '../lib/format'
import type { Loan } from '../data/types'

const shiftDay = (d: string, days: number) => {
  const x = new Date(d); x.setDate(x.getDate() + days)
  return x.toISOString().slice(0, 10)
}

// Reused for repaying a deposit (to a depositor) or an other-finance loan (to a
// lender). Both are payments OUT; interest is suggested from the rate.
export default function LiabilityRepayModal({
  title, name, code, outstanding, interestType, perDay, perMonth, sinceDate,
  interestOnly, principalOnly, onRepay, onClose, onSaved,
}: {
  title: string
  name: string
  code: string
  outstanding: number
  interestType?: string
  perDay?: number
  perMonth?: number
  sinceDate?: string
  interestOnly?: boolean
  principalOnly?: boolean
  onRepay: (principal: number, interest: number, date: string) => Promise<void>
  onClose: () => void
  onSaved: () => void
}) {
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [principal, setPrincipal] = useState(interestOnly ? '0' : String(outstanding))
  const [from, setFrom] = useState(sinceDate || new Date().toISOString().slice(0, 10))
  const [includeToday, setIncludeToday] = useState(true)
  const [payInterest, setPayInterest] = useState(true)
  const [interestOverride, setInterestOverride] = useState<string | null>(null)
  const [payType, setPayType] = useState('Cash')

  const p = num(principal)
  const base = p > 0 ? p : outstanding
  const calcTo = includeToday ? date : shiftDay(date, -1)

  const suggested = useMemo(() => {
    if (new Date(from) > new Date(calcTo)) return 0
    const pseudo = {
      Loan_Amount: base, Interest_Type: interestType || 'Per_Month',
      Interest_Per_day_Per_Lakh: perDay || 0, Interest_Per_Month_Per_Lakh: perMonth || 0,
      Loan_Given_Date: from,
    } as Loan
    return computeInterest(pseudo, from, calcTo).interest
  }, [base, from, calcTo, interestType, perDay, perMonth])

  const interest = principalOnly ? 0 : (interestOverride !== null ? num(interestOverride) : suggested)
  const valid = (p > 0 || (payInterest && interest > 0)) && p <= outstanding

  async function save() {
    await onRepay(p, payInterest ? interest : 0, date)
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
        <p className="font-semibold text-white">{name} <span className="text-xs font-normal text-slate-500">· {code}</span></p>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">Outstanding</span><span className="font-semibold text-white">{inr(outstanding)}</span></div>
        {!principalOnly && <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest {fmtDate(from)} → {fmtDate(calcTo)}</span><span className="font-semibold text-amber-300">{inr(interest)}</span></div>}
      </div>

      <div className="grid grid-cols-2 gap-3">
        <Field label="Principal paid (₹)"><input className="input" inputMode="numeric" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
        <Field label="Payment date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      {!principalOnly && <>
        <div className="grid grid-cols-2 gap-3">
          <Field label="Interest from"><input type="date" className="input" value={from} onChange={e => setFrom(e.target.value)} /></Field>
          <Field label="Interest amount (₹)"><input className="input" inputMode="numeric" value={interest} onChange={e => setInterestOverride(e.target.value)} /></Field>
        </div>
        <label className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
          <input type="checkbox" className="accent-brand-500" checked={includeToday} onChange={e => setIncludeToday(e.target.checked)} />
          Include the payment date in interest (else up to the previous day)
        </label>
        <label className="flex cursor-pointer items-center gap-2 rounded-xl bg-slate-800/40 px-3 py-2.5 text-sm">
          <input type="checkbox" className="accent-brand-500" checked={payInterest} onChange={e => setPayInterest(e.target.checked)} />
          <span className="text-slate-200">Pay the interest now</span>
          <span className="ml-auto font-semibold text-white">{inr(interest)}</span>
        </label>
      </>}

      <Field label="Payment type">
        <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
          <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
        </select>
      </Field>
      {p >= outstanding && outstanding > 0 && <p className="text-xs text-emerald-300/80">Full principal — this will be marked Closed.</p>}
    </Modal>
  )
}
