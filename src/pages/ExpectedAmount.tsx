import { useMemo, useState } from 'react'
import { Plus, Pencil, Trash2, CircleCheck, CircleDashed, Wallet, Search } from 'lucide-react'
import { repo, addExpectedAmount, updateExpectedAmount, deleteExpectedAmount } from '../data/repository'
import { useApp, canEdit, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState, Modal, Field, ConfirmModal } from '../components/ui'
import type { ExpectedAmount as Row } from '../data/types'
import { inr, inrShort, fmtDate, num } from '../lib/format'

const NOT_ADJUSTED = 'Not Adjusted'
const ADJUSTED = 'Adjusted'
const today = () => new Date().toISOString().slice(0, 10)

export default function ExpectedAmount() {
  const role = useApp(s => s.user?.role)
  const finance = useApp(s => s.finance)
  const editable = canEdit(role)
  // New rows must belong to one finance firm, so adding needs a single finance picked.
  const canAdd = editable && finance !== 'ALL'
  const [tick, setTick] = useState(0)
  const [form, setForm] = useState<{ edit?: Row } | null>(null)
  const [adjusting, setAdjusting] = useState<Row | null>(null)
  const [del, setDel] = useState<Row | null>(null)
  const [tab, setTab] = useState<'all' | typeof NOT_ADJUSTED | typeof ADJUSTED>('all')
  const [q, setQ] = useState('')

  const rows = useMemo(() => repo.expectedAmounts(financeFilter(finance)), [tick, finance])
  const refresh = () => setTick(t => t + 1)

  const pending = rows.filter(r => r.Status !== ADJUSTED)
  const done = rows.filter(r => r.Status === ADJUSTED)
  const total = (list: Row[]) => list.reduce((s, r) => s + num(r.Amount), 0)

  const shown = useMemo(() => {
    let list = rows
    if (tab !== 'all') list = list.filter(r => (r.Status === ADJUSTED ? ADJUSTED : NOT_ADJUSTED) === tab)
    const query = q.trim().toLowerCase()
    if (query) list = list.filter(r => `${r.Description ?? ''} ${r.Remarks ?? ''}`.toLowerCase().includes(query))
    return list
  }, [rows, tab, q])

  async function markNotAdjusted(r: Row) {
    await updateExpectedAmount(r.ID, { Status: NOT_ADJUSTED, Adjusted_Date: null })
    refresh()
  }

  const tabs: { key: typeof tab; label: string; n: number }[] = [
    { key: 'all', label: 'All', n: rows.length },
    { key: NOT_ADJUSTED, label: 'Not adjusted', n: pending.length },
    { key: ADJUSTED, label: 'Adjusted', n: done.length },
  ]

  return (
    <div>
      <PageHeader
        title="Expected amount"
        subtitle="Amounts you expect, tracked until they are adjusted — a separate list per finance firm, kept out of the ledger."
        action={canAdd && <button className="btn-primary !py-1.5" onClick={() => setForm({})}><Plus size={15} /> New entry</button>}
      />

      {editable && finance === 'ALL' && (
        <p className="mb-4 text-xs text-amber-300/80">Showing all firms combined. Pick a single finance in the switcher to add an expected amount.</p>
      )}

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Not adjusted" value={inrShort(total(pending))} tone="amber" icon={<CircleDashed size={18} />} />
        <StatCard label="Adjusted" value={inrShort(total(done))} tone="green" icon={<CircleCheck size={18} />} />
        <StatCard label="Entries" value={rows.length} tone="blue" icon={<Wallet size={18} />} />
      </div>

      <div className="mb-3 flex flex-wrap items-center gap-2">
        <div className="flex gap-1.5">
          {tabs.map(t => (
            <button
              key={t.key}
              onClick={() => setTab(t.key)}
              className={`btn-ghost !py-1 text-sm ${tab === t.key ? 'ring-1 ring-brand-500/40 text-brand-200' : 'text-slate-400'}`}
            >
              {t.label} <span className="text-xs text-slate-500">{t.n}</span>
            </button>
          ))}
        </div>
        <div className="relative ml-auto">
          <Search size={14} className="pointer-events-none absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input !py-1.5 pl-8 text-sm" placeholder="Search description / remark" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </div>

      {rows.length === 0 ? (
        <EmptyState title="No expected amounts yet" hint={canAdd ? 'Use “New entry” to add one.' : editable ? 'Pick a single finance in the switcher to add an entry.' : undefined} />
      ) : shown.length === 0 ? (
        <EmptyState title="No matches" hint="Try a different tab or search." />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr>
                  <Th>Date</Th><Th>Description</Th><Th right>Amount</Th><Th>Status</Th><Th>Remark</Th>
                  {editable && <Th>Actions</Th>}
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {shown.map(r => {
                  const isAdj = r.Status === ADJUSTED
                  return (
                    <tr key={r.ID} className="hover:bg-slate-800/40">
                      <Td className="whitespace-nowrap text-slate-300">{fmtDate(r.Date)}</Td>
                      <Td className="text-slate-200">{r.Description || <span className="text-slate-600">—</span>}</Td>
                      <Td right className="tabular-nums font-semibold text-hd">{inr(num(r.Amount))}</Td>
                      <Td>
                        <div className="flex flex-wrap items-center gap-1.5">
                          {editable ? (
                            <div className="inline-flex overflow-hidden rounded-lg ring-1 ring-inset ring-slate-700 text-xs">
                              <button
                                className={`px-2 py-1 ${!isAdj ? 'bg-amber-500/20 text-amber-200' : 'text-slate-500 hover:text-slate-300'}`}
                                onClick={() => isAdj && markNotAdjusted(r)}
                              >Not adjusted</button>
                              <button
                                className={`px-2 py-1 ${isAdj ? 'bg-emerald-500/20 text-emerald-200' : 'text-slate-500 hover:text-slate-300'}`}
                                onClick={() => setAdjusting(r)}
                                title={isAdj ? 'Change adjusted date' : 'Mark as adjusted'}
                              >Adjusted</button>
                            </div>
                          ) : (
                            <Badge tone={isAdj ? 'green' : 'amber'}>{isAdj ? 'Adjusted' : 'Not adjusted'}</Badge>
                          )}
                          {isAdj && r.Adjusted_Date && <span className="whitespace-nowrap text-xs text-slate-400">on {fmtDate(r.Adjusted_Date)}</span>}
                        </div>
                      </Td>
                      <Td className="text-slate-400">{r.Remarks || <span className="text-slate-600">—</span>}</Td>
                      {editable && (
                        <Td>
                          <div className="flex gap-2">
                            <button className="text-slate-500 hover:text-brand-300" title="Edit" onClick={() => setForm({ edit: r })}><Pencil size={14} /></button>
                            <button className="text-slate-500 hover:text-rose-300" title="Delete" onClick={() => setDel(r)}><Trash2 size={14} /></button>
                          </div>
                        </Td>
                      )}
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {form && <EntryModal edit={form.edit} finance={finance} onClose={() => setForm(null)} onSaved={() => { setForm(null); refresh() }} />}
      {adjusting && <AdjustModal row={adjusting} onClose={() => setAdjusting(null)} onSaved={() => { setAdjusting(null); refresh() }} />}
      {del && (
        <ConfirmModal
          title="Delete expected amount"
          message={<>Delete <b className="text-hd">{del.Description || 'this entry'}</b> of <b className="text-hd">{inr(num(del.Amount))}</b>?</>}
          onConfirm={async () => { await deleteExpectedAmount(del.ID); setDel(null); refresh() }}
          onClose={() => setDel(null)}
        />
      )}
    </div>
  )
}

// Add or edit an expected amount. New entries always start as 'Not Adjusted'.
function EntryModal({ edit, finance, onClose, onSaved }: { edit?: Row; finance: string; onClose: () => void; onSaved: () => void }) {
  const [date, setDate] = useState((edit?.Date ?? today()).slice(0, 10))
  const [description, setDescription] = useState(edit?.Description ?? '')
  const [amount, setAmount] = useState(edit ? String(edit.Amount) : '')
  const [remarks, setRemarks] = useState(edit?.Remarks ?? '')
  const [busy, setBusy] = useState(false)
  const valid = description.trim().length > 0 && num(amount) > 0 && !!date

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    const fields = { Date: date, Description: description.trim(), Amount: num(amount), Remarks: remarks.trim() || null }
    if (edit) await updateExpectedAmount(edit.ID, fields)
    else await addExpectedAmount({ ...fields, Finance_Name: finance, Status: NOT_ADJUSTED, Adjusted_Date: null })
    onSaved()
  }

  return (
    <Modal
      title={edit ? 'Edit expected amount' : 'New expected amount'}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>{edit ? 'Save' : 'Add'}</button>
      </>}
    >
      <div className="grid grid-cols-2 gap-3">
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
      </div>
      <Field label="Description"><input className="input" autoFocus value={description} onChange={e => setDescription(e.target.value)} /></Field>
      <Field label="Remark (optional)"><textarea className="input min-h-[70px]" value={remarks} onChange={e => setRemarks(e.target.value)} /></Field>
      {!edit && <p className="text-xs text-slate-500">Status starts as <b>Not adjusted</b>.</p>}
    </Modal>
  )
}

// Mark an entry Adjusted — asks for the date it was adjusted (defaults to today).
function AdjustModal({ row, onClose, onSaved }: { row: Row; onClose: () => void; onSaved: () => void }) {
  const [date, setDate] = useState((row.Adjusted_Date ?? today()).slice(0, 10))
  const [busy, setBusy] = useState(false)

  async function save() {
    if (!date || busy) return
    setBusy(true)
    await updateExpectedAmount(row.ID, { Status: ADJUSTED, Adjusted_Date: date })
    onSaved()
  }

  return (
    <Modal
      title="Mark as adjusted"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!date || busy} onClick={save}>Mark adjusted</button>
      </>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm text-slate-300">
        <b className="text-hd">{row.Description || '—'}</b> · {inr(num(row.Amount))} · {fmtDate(row.Date)}
      </div>
      <Field label="Adjusted date"><input type="date" className="input" autoFocus value={date} onChange={e => setDate(e.target.value)} /></Field>
    </Modal>
  )
}
