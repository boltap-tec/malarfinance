import { useState } from 'react'
import { Pencil, Trash2 } from 'lucide-react'
import { updateLedgerEntry, deleteLedgerEntry } from '../data/repository'
import { Card, Th, Td, Badge, EmptyState, Modal, Field, ConfirmModal } from './ui'
import { inr, fmtDate, num } from '../lib/format'
import type { LedgerRow } from '../data/types'

// A ledger table scoped to one entity (customer / depositor / other-finance).
// When `canManage` is true (MD), each row can be edited or deleted — the change
// recomputes the finance balance and is recorded in the Activity Log.
export default function LedgerTable({
  rows, canManage = false, emptyHint, onChanged,
}: {
  rows: LedgerRow[]
  canManage?: boolean
  emptyHint?: string
  onChanged?: () => void
}) {
  const [edit, setEdit] = useState<LedgerRow | null>(null)
  const [del, setDel] = useState<LedgerRow | null>(null)

  if (rows.length === 0) return <EmptyState title="No ledger entries yet" hint={emptyHint} />

  const sorted = rows.slice().sort((a, b) => {
    const d = new Date(b.Date_Transaction ?? 0).getTime() - new Date(a.Date_Transaction ?? 0).getTime()
    return d !== 0 ? d : Number(String(b.Ref_ID).replace(/\D/g, '')) - Number(String(a.Ref_ID).replace(/\D/g, ''))
  })

  return (
    <>
      <Card className="!p-0 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-900/60">
              <tr><Th>Date</Th><Th>Nature</Th><Th>Description</Th><Th right>Receipt</Th><Th right>Payment</Th><Th>Mode</Th>{canManage && <Th>Actions</Th>}</tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {sorted.map((t, i) => (
                <tr key={i} className="hover:bg-slate-800/40">
                  <Td className="whitespace-nowrap text-slate-400">
                    {fmtDate(t.Date_Transaction)}
                    {t.Created_Date && fmtDate(t.Created_Date) !== fmtDate(t.Date_Transaction) && (
                      <span className="block text-[11px] text-slate-500" title={t.Created_Date}>entered {fmtDate(t.Created_Date)}</span>
                    )}
                  </Td>
                  <Td><Badge tone="slate">{t.Nature_Transaction ?? '—'}</Badge></Td>
                  <Td className="text-slate-400">{t.Description ?? '—'}</Td>
                  <Td right className="text-emerald-400">{num(t.Receipt_Amount) ? inr(num(t.Receipt_Amount)) : '—'}</Td>
                  <Td right className="text-rose-300">{num(t.Payment_Amount) ? inr(num(t.Payment_Amount)) : '—'}</Td>
                  <Td className="text-slate-400">{t.Payment_Type ?? '—'}</Td>
                  {canManage && (
                    <Td>
                      <div className="flex gap-1">
                        <button title="Edit entry" className="btn-ghost !px-2 !py-1 text-xs" onClick={() => setEdit(t)}><Pencil size={13} /></button>
                        <button title="Delete entry" className="btn-ghost !px-2 !py-1 text-xs text-rose-300" onClick={() => setDel(t)}><Trash2 size={13} /></button>
                      </div>
                    </Td>
                  )}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </Card>

      {del && (
        <ConfirmModal
          title="Delete ledger entry"
          message={<>Delete <b className="text-hd">{del.Description ?? del.Nature_Transaction}</b> (Ref {del.Ref_ID})? This also <b className="text-amber-300">reverses the linked record</b> — a repayment adds the principal back, interest becomes pending again. The balance recomputes and it's logged.</>}
          onConfirm={async () => { await deleteLedgerEntry(String(del.Ref_ID)); setDel(null); onChanged?.() }}
          onClose={() => setDel(null)}
        />
      )}

      {edit && (
        <EditLedgerModal row={edit} onClose={() => setEdit(null)} onSaved={() => { setEdit(null); onChanged?.() }} />
      )}
    </>
  )
}

function EditLedgerModal({ row, onClose, onSaved }: { row: LedgerRow; onClose: () => void; onSaved: () => void }) {
  const [date, setDate] = useState(row.Date_Transaction ?? new Date().toISOString().slice(0, 10))
  const [desc, setDesc] = useState(row.Description ?? '')
  const [receipt, setReceipt] = useState(String(num(row.Receipt_Amount) || ''))
  const [payment, setPayment] = useState(String(num(row.Payment_Amount) || ''))
  const [payType, setPayType] = useState(row.Payment_Type ?? 'Cash')
  const [busy, setBusy] = useState(false)
  const valid = num(receipt) > 0 || num(payment) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await updateLedgerEntry(String(row.Ref_ID), {
      Date_Transaction: date, Description: desc.trim() || row.Nature_Transaction,
      Receipt_Amount: num(receipt), Payment_Amount: num(payment), Payment_Type: payType,
    })
    onSaved()
  }

  return (
    <Modal title={`Edit entry — Ref ${row.Ref_ID}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Save changes</button>
    </>}>
      <p className="text-sm text-slate-400">{row.Nature_Transaction} · {row.Finance_Name}. Editing recomputes the running balance and is logged.</p>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option><option>Account</option><option>Other</option>
          </select>
        </Field>
      </div>
      <Field label="Description"><input className="input" value={desc} onChange={e => setDesc(e.target.value)} /></Field>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Receipt (money in) ₹"><input className="input" inputMode="numeric" value={receipt} onChange={e => setReceipt(e.target.value)} /></Field>
        <Field label="Payment (money out) ₹"><input className="input" inputMode="numeric" value={payment} onChange={e => setPayment(e.target.value)} /></Field>
      </div>
      {num(receipt) > 0 && num(payment) > 0 && <p className="text-xs text-amber-300/80">An entry is usually either a receipt or a payment, not both.</p>}
      <p className="mt-1 text-xs text-slate-500">Note: this edits the cash ledger only — it does not change any linked loan, deposit or interest record.</p>
    </Modal>
  )
}
