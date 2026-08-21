import { useState } from 'react'
import { repayCustomer } from '../data/repository'
import { Modal, Field } from './ui'
import { inr, num } from '../lib/format'

// One-shot customer repayment — principal is applied to the oldest loans first,
// interest settles the oldest pending interest first. Two separate ledger
// entries are posted. No loan selection needed.
export default function CustomerRepayModal({
  stl, name, outstanding, pendingInterest, mode = 'repay', onClose, onSaved,
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
  const [principal, setPrincipal] = useState(mode === 'interest' ? '0' : String(outstanding))
  const [interest, setInterest] = useState(String(pendingInterest))
  const [payType, setPayType] = useState('Cash')

  const p = num(principal), i = num(interest)
  const valid = (p > 0 || i > 0) && p <= outstanding && i <= pendingInterest

  async function save() {
    await repayCustomer({ stl, principal: p, interest: i, date, payType })
    onSaved()
  }

  return (
    <Modal
      title={`Repay — ${name}`}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Record repayment</button>
      </>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Total outstanding loan</span><span className="font-semibold text-hd">{inr(outstanding)}</span></div>
        <div className="mt-1 flex justify-between"><span className="text-slate-400">Total pending interest</span><span className="font-semibold text-amber-300">{inr(pendingInterest)}</span></div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <Field label="Principal paid (₹)"><input className="input" inputMode="numeric" value={principal} onChange={e => setPrincipal(e.target.value)} /></Field>
        <Field label="Interest paid (₹)"><input className="input" inputMode="numeric" value={interest} onChange={e => setInterest(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
          </select>
        </Field>
      </div>
      <p className="text-xs text-slate-500">
        Principal reduces the oldest loan first; interest settles the oldest pending first. The ledger records principal and interest as two separate entries.
      </p>
    </Modal>
  )
}
