import { useState } from 'react'
import { Modal, Field } from './ui'
import { inr, num } from '../lib/format'

// A small confirm-and-pay form for one interest line. Clicking Pay opens this;
// the user confirms the amount (defaults to the full pending, partial allowed),
// date and mode before it's recorded.
export default function InterestPayModal({
  title, name, code, month, pending, onPay, onClose, onSaved,
}: {
  title: string
  name: string
  code: string
  month?: string
  pending: number
  onPay: (amount: number, date: string, payType: string, note?: string) => Promise<void>
  onClose: () => void
  onSaved: () => void
}) {
  const [amount, setAmount] = useState('')   // typed by the user — no pre-fill
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [payType, setPayType] = useState('Cash')
  const [note, setNote] = useState('')

  const amt = num(amount)
  const valid = amt > 0 && amt <= pending

  async function save() {
    await onPay(amt, date, payType, note.trim() || undefined)
    onSaved()
  }

  return (
    <Modal
      title={title}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Pay</button>
      </>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <p className="font-semibold text-hd">{name} <span className="text-xs font-normal text-slate-500">· {code}{month ? ` · ${month}` : ''}</span></p>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">Pending interest</span><span className="font-semibold text-amber-300">{inr(pending)}</span></div>
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Amount (₹) *" hint="Required"><input className="input" inputMode="numeric" autoFocus placeholder="Enter amount" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      {amt > pending && <p className="text-xs text-rose-300">Cannot pay more than the pending interest ({inr(pending)}).</p>}
      <Field label="Payment type">
        <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
          <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
        </select>
      </Field>
      <Field label="Notes / remarks"><input className="input" value={note} onChange={e => setNote(e.target.value)} placeholder="Optional — a note to remind you later" /></Field>
      {amt < pending && amt > 0 && <p className="text-xs text-amber-300/80">Partial payment — {inr(pending - amt)} stays pending.</p>}
    </Modal>
  )
}
