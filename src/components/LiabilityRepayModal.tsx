import { useState } from 'react'
import { Modal, Field } from './ui'
import { inr, num } from '../lib/format'

// Repay a depositor or an other-finance lender: principal and/or pending
// interest in one box. The repository posts TWO separate ledger entries and
// settles the interest schedule oldest-first.
export default function LiabilityRepayModal({
  title, name, code, outstanding, pendingInterest = 0, interestOnly,
  onRepay, onClose, onSaved,
}: {
  title: string
  name: string
  code: string
  outstanding: number
  pendingInterest?: number
  interestOnly?: boolean
  onRepay: (principal: number, interest: number, date: string, payType: string, note?: string) => Promise<void>
  onClose: () => void
  onSaved: () => void
}) {
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [principal, setPrincipal] = useState('')   // typed by the user — no pre-fill
  const [interest, setInterest] = useState('')     // typed by the user — no pre-fill
  const [payType, setPayType] = useState('Cash')
  const [note, setNote] = useState('')

  const showPrincipal = !interestOnly
  const p = showPrincipal ? num(principal) : 0, i = num(interest)
  const valid = (p > 0 || i > 0) && p <= outstanding && i <= pendingInterest

  async function save() {
    await onRepay(p, i, date, payType, note.trim() || undefined)
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
        <div className="mt-1 flex justify-between"><span className="text-slate-400">Pending interest</span><span className="font-semibold text-amber-300">{inr(pendingInterest)}</span></div>
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        {showPrincipal && <Field label="Principal paid (₹)"><input className="input" inputMode="numeric" placeholder="Enter amount" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>}
        <Field label="Interest paid (₹)"><input className="input" inputMode="numeric" placeholder="Enter amount" value={interest} onChange={e => setInterest(e.target.value)} /></Field>
      </div>
      {p > outstanding && <p className="text-xs text-rose-300">Principal cannot exceed the outstanding ({inr(outstanding)}).</p>}
      {i > pendingInterest && <p className="text-xs text-rose-300">Interest cannot exceed the pending ({inr(pendingInterest)}).</p>}
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
