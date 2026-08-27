import { useMemo, useState } from 'react'
import { accrueOnRepaidPrincipal, type DebtLine, type RepayAccrual } from '../lib/interestEngine'
import { Modal, Field, AmountHint } from './ui'
import { inr, num, fmtDate } from '../lib/format'

const shiftDay = (d: string, days: number) => {
  const x = new Date(d); x.setDate(x.getDate() + days)
  return x.toISOString().slice(0, 10)
}
const labelOf = (d: DebtLine) => d.type === 'Per_Month' ? `₹${num(d.perMonth)}/L·mo` : `₹${num(d.perDay)}/L·day`
const keyOf = (d: DebtLine) => `${d.type || 'Per_Day'}:${d.type === 'Per_Month' ? num(d.perMonth) : num(d.perDay)}`

// Repay a depositor or an other-finance lender. When there are several deposits/
// borrowings you pick which one to refund; if their rates differ you must pick
// one (so interest is charged at that one's rate). Interest is charged only on the
// refunded amount, up to the repay date, plus any previously pending interest.
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
  onRepay: (principal: number, interest: number, date: string, payType: string, note: string | undefined, accruals?: RepayAccrual[], targetKey?: string) => Promise<void>
  onClose: () => void
  onSaved: () => void
}) {
  const showPrincipal = !interestOnly
  const debtRows = useMemo(() => (showPrincipal && debts ? debts.filter(d => d.outstanding > 0) : []), [debts, showPrincipal])
  const multi = debtRows.length > 1
  const allSame = debtRows.length > 0 && debtRows.every(d => keyOf(d) === keyOf(debtRows[0]))

  const [target, setTarget] = useState<string>(
    !showPrincipal ? 'ALL' : (!multi ? (debtRows[0]?.key ?? 'ALL') : (allSame ? 'ALL' : '')),
  )
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [principal, setPrincipal] = useState('')
  const [interestStr, setInterestStr] = useState('')
  const [includeToday, setIncludeToday] = useState(true)
  const [payType, setPayType] = useState('Cash')
  const [note, setNote] = useState('')
  const [busy, setBusy] = useState(false)

  const p = showPrincipal ? num(principal) : 0
  const calcTo = includeToday ? date : shiftDay(date, -1)

  const targetDebts = target === 'ALL' ? debtRows : debtRows.filter(d => d.key === target)
  const selOutstanding = !showPrincipal ? outstanding : (target === 'ALL' ? outstanding : targetDebts.reduce((s, d) => s + d.outstanding, 0))
  const selRate = target === 'ALL' ? (allSame && debtRows[0] ? labelOf(debtRows[0]) : (rateLabel ?? 'mixed')) : (targetDebts[0] ? labelOf(targetDebts[0]) : '')

  const { accruals, accrued } = useMemo(() => {
    if (!showPrincipal || !targetDebts.length) return { accruals: [] as RepayAccrual[], accrued: 0 }
    const r = accrueOnRepaidPrincipal(targetDebts, p, calcTo)
    return { accruals: r.accruals, accrued: r.total }
  }, [target, debtRows, showPrincipal, p, calcTo]) // eslint-disable-line react-hooks/exhaustive-deps

  const totalInterest = pendingInterest + accrued
  const interestPaid = Math.max(0, num(interestStr))
  const remainingInterest = Math.max(0, totalInterest - interestPaid)
  const needChoice = showPrincipal && multi && target === ''
  const valid = !needChoice && (p > 0 || interestPaid > 0) && p <= selOutstanding && interestPaid <= totalInterest && !busy

  async function save() {
    if (!valid) return
    setBusy(true)
    await onRepay(p, interestPaid, date, payType, note.trim() || undefined, accruals, target === 'ALL' ? undefined : target)
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
      {showPrincipal && multi && (
        <Field label="Which one to repay?" hint={allSame ? undefined : 'Rates differ — pick the one you want to close.'}>
          <select className="input" value={target} onChange={e => { setTarget(e.target.value); setPrincipal(''); setInterestStr('') }}>
            {!allSame && <option value="">Choose…</option>}
            {allSame && <option value="ALL">All (oldest first)</option>}
            {debtRows.map(d => <option key={d.key} value={d.key}>{labelOf(d)} · {inr(d.outstanding)}{d.givenDate ? ` · ${fmtDate(d.givenDate)}` : ''}</option>)}
          </select>
        </Field>
      )}

      {!needChoice && <>
        <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
          <p className="font-semibold text-hd">{name} <span className="text-xs font-normal text-slate-500">· {code}</span></p>
          <div className="mt-1 flex justify-between"><span className="text-slate-400">Outstanding</span><span className="font-semibold text-hd">{inr(selOutstanding)}</span></div>
          {selRate && <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest rate</span><span className="font-semibold text-slate-200">{selRate}</span></div>}
          {showPrincipal && <div className="mt-1 flex justify-between"><span className="text-slate-400">Interest on repaid amount (to {fmtDate(calcTo)})</span><span className="font-semibold text-amber-300">{inr(accrued)}</span></div>}
        </div>

        {showPrincipal && (
          <Field label="Principal paid (₹)"><input className="input" inputMode="numeric" placeholder="Enter amount" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
        )}
        {showPrincipal && <AmountHint value={principal} />}
        {p > selOutstanding && <p className="text-xs text-rose-300">Principal cannot exceed the outstanding ({inr(selOutstanding)}).</p>}

        {showPrincipal && (
          <label className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
            <input type="checkbox" className="accent-brand-500" checked={includeToday} onChange={e => setIncludeToday(e.target.checked)} />
            Include today in the interest (calculate up to {fmtDate(date)}, else the previous day)
          </label>
        )}

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
      </>}
    </Modal>
  )
}
