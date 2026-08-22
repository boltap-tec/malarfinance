import { useState } from 'react'
import { Modal, Field } from './ui'
import { inr, fmtDate, num, monthKey } from '../lib/format'
import type { InterestRow } from '../data/types'

// Collect interest for a WHOLE customer, not just one line. Shows every pending
// month (e.g. Jun ₹3,350, Jul ₹3,380 …), the total, and — as you type an amount —
// previews which months it settles (oldest first).
export default function CustomerInterestPayModal({
  name, rows, onPay, onClose, onSaved,
}: {
  name: string
  rows: InterestRow[]                    // all interest rows for this customer
  onPay: (amount: number, date: string, payType: string) => Promise<void>
  onClose: () => void
  onSaved: () => void
}) {
  // Pending months, oldest first.
  const pending = rows
    .filter(r => num(r.Interest_Pending) > 0)
    .sort((a, b) =>
      (monthKey(a.Month) - monthKey(b.Month)) ||
      String(a.From_Date ?? '').localeCompare(String(b.From_Date ?? '')))

  const total = pending.reduce((s, r) => s + num(r.Interest_Pending), 0)
  const [amount, setAmount] = useState(String(total))
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [payType, setPayType] = useState('Cash')
  const [busy, setBusy] = useState(false)

  const amt = num(amount)
  const valid = amt > 0 && amt <= total

  // Preview allocation oldest-first for the entered amount.
  let left = amt
  const alloc = pending.map(r => {
    const p = num(r.Interest_Pending)
    const applied = Math.max(0, Math.min(p, left))
    left -= applied
    return { row: r, pending: p, applied }
  })

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await onPay(amt, date, payType)
    onSaved()
  }

  return (
    <Modal
      title={`Collect interest — ${name}`}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>Pay {inr(amt)}</button>
      </>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3">
        <div className="flex items-center justify-between text-sm">
          <span className="text-slate-400">Total pending ({pending.length} month{pending.length === 1 ? '' : 's'})</span>
          <span className="font-semibold text-amber-300">{inr(total)}</span>
        </div>
        <div className="mt-2 divide-y divide-slate-800 border-t border-slate-800">
          {alloc.map(({ row, pending: p, applied }, i) => (
            <div key={i} className="flex items-center justify-between gap-2 py-1.5 text-sm">
              <span className="text-slate-300">
                {row.Month ?? '—'}
                <span className="ml-2 text-xs text-slate-500">{fmtDate(row.From_Date)} – {fmtDate(row.To_Date)}</span>
              </span>
              <span className="flex items-center gap-2">
                <span className="tabular-nums text-slate-300">{inr(p)}</span>
                {applied > 0
                  ? <span className={`rounded-full px-2 py-0.5 text-xs ${applied >= p ? 'bg-emerald-500/15 text-emerald-300' : 'bg-amber-500/15 text-amber-300'}`}>
                      {applied >= p ? 'Paid' : `+${inr(applied)}`}
                    </span>
                  : <span className="text-xs text-slate-600">—</span>}
              </span>
            </div>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <Field label="Amount to pay (₹)" hint="Applied oldest month first"><input className="input" inputMode="numeric" autoFocus value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      <Field label="Payment type">
        <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
          <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
        </select>
      </Field>
      <div className="flex flex-wrap gap-2">
        <button type="button" className="btn-ghost !py-1 text-xs" onClick={() => setAmount(String(total))}>Full {inr(total)}</button>
        {pending[0] && <button type="button" className="btn-ghost !py-1 text-xs" onClick={() => setAmount(String(num(pending[0].Interest_Pending)))}>Oldest month {inr(num(pending[0].Interest_Pending))}</button>}
      </div>
    </Modal>
  )
}
