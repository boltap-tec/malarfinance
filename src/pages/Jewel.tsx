import { useEffect, useMemo, useRef, useState } from 'react'
import { Link } from 'react-router-dom'
import { Search, Plus, Gem, Scale, Trash2, ImagePlus, X, Camera } from 'lucide-react'
import {
  repo, addJewelLoan, updateJewelLoan, deleteJewelLoan, addJewelPhotos, nextJewelLoanNo,
} from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field, ConfirmModal, AmountHint } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'
import { useCreateParam } from '../lib/useCreateParam'
import { shrinkImages } from '../lib/image'
import type { JewelLoan } from '../data/types'

const FILTERS = ['All', 'Active', 'Closed'] as const

// Monthly interest implied by a per-lakh rate: amount ÷ 1 lakh × rate.
const monthlyInterest = (amount: number, ratePerLakh: number) => (amount / 100000) * ratePerLakh

// Interest accrued so far on a loan — monthly interest × months elapsed from the
// loan date up to today (or to the close date, once closed). Months are counted
// as elapsed days ÷ 30, so a part-month still accrues its share. An estimate for
// a running view, not the final settlement figure the lender charges.
export function accruedInterest(j: JewelLoan): number {
  const perMonth = monthlyInterest(num(j.Loan_Amount), num(j.Interest_Rate))
  if (!perMonth || !j.Loan_Taken_Date) return 0
  const start = new Date(j.Loan_Taken_Date)
  const end = j.Loan_Closed_Date ? new Date(j.Loan_Closed_Date) : new Date()
  if (isNaN(start.getTime()) || isNaN(end.getTime())) return 0
  const days = (end.getTime() - start.getTime()) / 86400000
  if (days <= 0) return 0
  return Math.round(perMonth * (days / 30))
}
// Default settle-by date: one week before the loan completes a year.
export function defaultDueDate(takenISO?: string): string {
  if (!takenISO) return ''
  const d = new Date(takenISO)
  if (isNaN(d.getTime())) return ''
  d.setFullYear(d.getFullYear() + 1)
  d.setDate(d.getDate() - 7)
  return d.toISOString().slice(0, 10)
}

export default function Jewel() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const isMd = role === 'md'
  const [q, setQ] = useState('')
  const [filter, setFilter] = useState<typeof FILTERS[number]>('All')
  const [open, setOpen] = useCreateParam()
  const [tick, setTick] = useState(0)
  const [edit, setEdit] = useState<JewelLoan | null>(null)
  const [del, setDel] = useState<JewelLoan | null>(null)

  const { rows, activeRows, closedRows, openCount, borrowed, grams } = useMemo(() => {
    let list = repo.jewelLoans(financeFilter(finance))
    if (filter !== 'All') list = list.filter(j => (j.Loan_Status ?? 'Active') === filter)
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(j =>
      j.Loan_No?.toLowerCase().includes(s) ||
      (j.Loan_Taken_From ?? '').toLowerCase().includes(s) ||
      (j.Loan_Taken_By ?? '').toLowerCase().includes(s) ||
      (j.Particular_Description ?? '').toLowerCase().includes(s))
    const isActive = (j: JewelLoan) => (j.Loan_Status ?? 'Active') !== 'Closed'
    const openRows = repo.jewelLoans(financeFilter(finance)).filter(isActive)
    return {
      rows: list,
      activeRows: list.filter(isActive),   // Active group — shown on top
      closedRows: list.filter(j => !isActive(j)),
      openCount: openRows.length,
      borrowed: openRows.reduce((a, j) => a + num(j.Loan_Amount), 0),
      grams: openRows.reduce((a, j) => a + num(j.Loan_Total_grams), 0),
    }
  }, [finance, q, filter, tick])

  return (
    <div>
      <PageHeader
        title="Jewel Loans"
        subtitle="Gold pledged to borrow — lender, grams, item particulars & photos."
        action={canEdit(role) &&
          <button className="btn-primary" onClick={() => setOpen(true)} disabled={finance === 'ALL'}>
            <Plus size={16} /> New jewel loan
          </button>}
      />

      {canEdit(role) && finance === 'ALL' && <p className="mb-3 text-xs text-amber-300/80">Pick a single finance in the switcher to add a jewel loan.</p>}

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
        <StatCard label="Open loans" value={openCount} tone="blue" icon={<Gem size={18} />} />
        <StatCard label="Borrowed (open)" value={inr(borrowed)} tone="amber" />
        <StatCard label="Gold pledged" value={`${grams.toLocaleString('en-IN', { maximumFractionDigits: 2 })} g`} tone="slate" icon={<Scale size={18} />} />
        <StatCard label="All loans" value={rows.length} tone="slate" />
      </div>

      <Card className="mb-4 !p-3">
        <div className="flex flex-wrap items-center gap-3">
          <div className="relative flex-1 min-w-[220px]">
            <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
            <input className="input pl-9" placeholder="Search loan no., lender, person, item…" value={q} onChange={e => setQ(e.target.value)} />
          </div>
          <div className="flex gap-1 rounded-xl bg-slate-800/60 p-1">
            {FILTERS.map(fl => (
              <button key={fl} onClick={() => setFilter(fl)}
                className={`rounded-lg px-3 py-1.5 text-sm font-medium ${filter === fl ? 'bg-brand-600 text-white' : 'text-slate-300'}`}>{fl}</button>
            ))}
          </div>
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No jewel loans yet" hint={canEdit(role) ? 'Add one with the button above.' : undefined} /> : (
        <>
          {activeRows.length > 0 && <JewelGroup title="Active" tone="green" rows={activeRows} isMd={isMd} onDelete={setDel} />}
          {closedRows.length > 0 && <JewelGroup title="Closed" tone="slate" rows={closedRows} isMd={isMd} onDelete={setDel} />}
        </>
      )}

      {open && (
        <JewelForm
          finance={finance}
          onClose={() => setOpen(false)}
          onSaved={() => { setOpen(false); setTick(t => t + 1) }}
        />
      )}
      {edit && (
        <JewelForm
          finance={edit.Finance_Name}
          initial={edit}
          onClose={() => setEdit(null)}
          onSaved={() => { setEdit(null); setTick(t => t + 1) }}
        />
      )}
      {del && (
        <ConfirmModal
          title="Delete jewel loan"
          message={<>Delete <b className="text-hd">{del.Loan_No}</b> ({del.Loan_Taken_From || 'jewel loan'}) and its {num(del.Photo_Count) || 0} photo(s)?</>}
          onConfirm={async () => { await deleteJewelLoan(del.Loan_No); setDel(null); setTick(t => t + 1) }}
          onClose={() => setDel(null)}
        />
      )}
    </div>
  )
}

// One status section (Active / Closed) with its own header carrying the group's
// loan count and total loan amount, above its table of loans.
function JewelGroup({ title, tone, rows, isMd, onDelete }: {
  title: string; tone: 'green' | 'slate'; rows: JewelLoan[]; isMd: boolean; onDelete: (j: JewelLoan) => void
}) {
  const closedGroup = title === 'Closed'
  const total = rows.reduce((a, j) => a + num(j.Loan_Amount), 0)
  // Closed loans: sum the interest actually paid. Active loans: sum the interest
  // accrued so far.
  const intTotal = rows.reduce((a, j) => a + (closedGroup ? num(j.Total_Interest_Paid) : accruedInterest(j)), 0)
  const intLabel = closedGroup ? 'Interest paid' : 'Interest so far'
  return (
    <div className="mb-5">
      <div className="mb-2 flex flex-wrap items-center justify-between gap-2 px-1">
        <div className="flex items-center gap-2">
          <Badge tone={tone}>{title}</Badge>
          <span className="text-xs text-slate-500">{rows.length} loan{rows.length === 1 ? '' : 's'}</span>
        </div>
        <div className="flex flex-wrap items-center gap-x-4 gap-y-0.5 text-sm">
          <span><span className="text-slate-400">Total loan </span><span className="font-semibold text-hd tabular-nums">{inr(total)}</span></span>
          {intTotal > 0 && <span><span className="text-slate-400">{intLabel} </span><span className="font-semibold text-amber-300 tabular-nums">{inr(intTotal)}</span></span>}
        </div>
      </div>
      <Card className="!p-0 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-900/60">
              <tr>
                <Th sticky>Loan no.</Th><Th>Taken from</Th><Th>By</Th><Th>Date</Th><Th>Due by</Th>
                <Th right>Grams</Th><Th right>Amount</Th><Th right>Int / mo</Th><Th right>{intLabel}</Th><Th>Photos</Th><Th>Status</Th>{isMd && <Th>Del</Th>}
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {rows.map(j => {
                const intVal = closedGroup ? num(j.Total_Interest_Paid) : accruedInterest(j)
                return (
                <tr key={j.Loan_No} className="group hover:bg-slate-800/40">
                  <Td sticky><Link to={`/jewel/${encodeURIComponent(j.Loan_No)}`} className="font-medium text-brand-300">{j.Loan_No}</Link></Td>
                  <Td>
                    <p className="text-slate-200">{j.Loan_Taken_From || '—'}</p>
                    {j.Particular_Description && <p className="max-w-[220px] truncate text-xs text-slate-500">{j.Particular_Description}</p>}
                  </Td>
                  <Td className="text-slate-400">{j.Loan_Taken_By || '—'}</Td>
                  <Td className="text-slate-400 whitespace-nowrap">{fmtDate(j.Loan_Taken_Date)}</Td>
                  <Td className="whitespace-nowrap"><DueCell loan={j} /></Td>
                  <Td right className="text-slate-300 whitespace-nowrap">{num(j.Loan_Total_grams) ? `${num(j.Loan_Total_grams)} g` : '—'}</Td>
                  <Td right className="text-hd">{inr(num(j.Loan_Amount))}</Td>
                  <Td right className="text-amber-300">{num(j.Interest_Rate) ? inr(monthlyInterest(num(j.Loan_Amount), num(j.Interest_Rate))) : '—'}</Td>
                  <Td right className={closedGroup ? 'text-emerald-300' : 'text-slate-300'}>{intVal ? inr(intVal) : '—'}</Td>
                  <Td>
                    <Link to={`/jewel/${encodeURIComponent(j.Loan_No)}`} className="inline-flex items-center gap-1 text-xs text-slate-400 hover:text-slate-200">
                      <Camera size={13} /> {num(j.Photo_Count) || 0}
                    </Link>
                  </Td>
                  <Td><Badge tone={statusTone(j.Loan_Status)}>{j.Loan_Status ?? 'Active'}</Badge></Td>
                  {isMd && <Td><button title="Delete jewel loan" className="btn-ghost !px-2 !py-1 text-xs text-rose-300" onClick={() => onDelete(j)}><Trash2 size={13} /></button></Td>}
                </tr>
              )})}
            </tbody>
          </table>
        </div>
      </Card>
    </div>
  )
}

// Due date with an urgency hint once the loan is within 15 days of maturity
// (or overdue). Closed loans show a plain date.
export function DueCell({ loan }: { loan: JewelLoan }) {
  if (!loan.Due_Date) return <span className="text-slate-600">—</span>
  const closed = (loan.Loan_Status ?? 'Active') === 'Closed'
  const today = new Date(); today.setHours(0, 0, 0, 0)
  const due = new Date(loan.Due_Date); due.setHours(0, 0, 0, 0)
  const days = Math.round((due.getTime() - today.getTime()) / 86400000)
  const soon = !closed && days <= 15
  return (
    <span className={soon ? (days < 0 ? 'text-rose-300' : 'text-amber-300') : 'text-slate-400'}>
      {fmtDate(loan.Due_Date)}
      {soon && <span className="ml-1 text-[11px]">· {days < 0 ? `overdue ${-days}d` : days === 0 ? 'due today' : `in ${days}d`}</span>}
    </span>
  )
}

// Shared create / edit form. Photos can be attached while CREATING (staged in
// memory, then written after the loan row is inserted). Editing an existing loan
// manages photos on the detail page instead, so the modal stays focused.
export function JewelForm({ finance, initial, onClose, onSaved }: {
  finance: string; initial?: JewelLoan; onClose: () => void; onSaved: () => void
}) {
  const editing = !!initial
  const today = new Date().toISOString().slice(0, 10)
  const [from, setFrom] = useState(initial?.Loan_Taken_From ?? '')
  const [by, setBy] = useState(initial?.Loan_Taken_By ?? '')
  const [date, setDate] = useState(initial?.Loan_Taken_Date ?? today)
  const [amount, setAmount] = useState(initial?.Loan_Amount != null ? String(initial.Loan_Amount) : '')
  const [rate, setRate] = useState(initial?.Interest_Rate != null ? String(initial.Interest_Rate) : '')
  const [grams, setGrams] = useState(initial?.Loan_Total_grams != null ? String(initial.Loan_Total_grams) : '')
  const [desc, setDesc] = useState(initial?.Particular_Description ?? '')
  const [remark, setRemark] = useState(initial?.Remark1 ?? '')
  const [status, setStatus] = useState<'Active' | 'Closed'>((initial?.Loan_Status as 'Active' | 'Closed') ?? 'Active')
  const [closedDate, setClosedDate] = useState(initial?.Loan_Closed_Date ?? today)
  const [interestPaid, setInterestPaid] = useState(initial?.Total_Interest_Paid != null ? String(initial.Total_Interest_Paid) : '')
  // Settle-by date: defaults to one week before the loan turns a year old, and
  // follows the loan date until the user overrides it themselves.
  const [due, setDue] = useState(initial?.Due_Date ?? defaultDueDate(date))
  const dueTouched = useRef(!!initial?.Due_Date)

  const monthlyInt = monthlyInterest(num(amount), num(rate))
  const [staged, setStaged] = useState<string[]>([])
  const [busy, setBusy] = useState('')
  const [saving, setSaving] = useState(false)
  const fileRef = useRef<HTMLInputElement>(null)

  const loanNo = editing ? initial!.Loan_No : nextJewelLoanNo(finance)
  const valid = num(amount) > 0 && !saving

  // Keep the due date one week short of a year from the loan date, until the
  // user edits it themselves.
  useEffect(() => {
    if (!dueTouched.current) setDue(defaultDueDate(date))
  }, [date])

  async function onPick(e: React.ChangeEvent<HTMLInputElement>) {
    const files = Array.from(e.target.files ?? [])
    e.target.value = ''
    if (!files.length) return
    setBusy(`Processing 0 / ${files.length}…`)
    const urls = await shrinkImages(files, (d, t) => setBusy(`Processing ${d} / ${t}…`))
    setStaged(s => [...s, ...urls])
    setBusy('')
  }

  async function save() {
    setSaving(true)
    const closedOn = status === 'Closed' ? (closedDate || today) : undefined
    const common: Partial<JewelLoan> = {
      Loan_Taken_From: from.trim() || undefined,
      Loan_Taken_By: by.trim() || undefined,
      Loan_Taken_Date: date || undefined,
      Loan_Amount: num(amount),
      Interest_Rate: rate ? num(rate) : undefined,
      Interest_Amount: rate && num(amount) ? Math.round(monthlyInt) : undefined,
      Loan_Total_grams: grams ? num(grams) : undefined,
      Particular_Description: desc.trim() || undefined,
      Due_Date: due || undefined,
      Remark1: remark.trim() || undefined,
      Loan_Closed_Date: closedOn,
      // Only record interest paid when the loan is being closed.
      Total_Interest_Paid: status === 'Closed' && interestPaid ? num(interestPaid) : undefined,
    }
    if (editing) {
      await updateJewelLoan(loanNo, common)
    } else {
      await addJewelLoan({ Finance_Name: finance, Loan_No: loanNo, Photo_Count: 0, ...common })
      if (staged.length) await addJewelPhotos(loanNo, finance, staged)
    }
    onSaved()
  }

  return (
    <Modal
      title={editing ? `Edit ${loanNo}` : 'New jewel loan'}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>
          {saving ? 'Saving…' : editing ? 'Save changes' : (staged.length ? `Save + ${staged.length} photo${staged.length === 1 ? '' : 's'}` : 'Save loan')}
        </button>
      </>}
    >
      <div className="grid grid-cols-2 gap-3">
        <Field label="Taken from (lender)"><input className="input" value={from} onChange={e => setFrom(e.target.value)} placeholder="Muthoot / bank / person" /></Field>
        <Field label="Taken by"><input className="input" value={by} onChange={e => setBy(e.target.value)} placeholder="Who took it" /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Loan amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value.replace(/[^\d.]/g, ''))} /></Field>
        <Field label="Taken date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      <AmountHint value={amount} />
      <div className="grid grid-cols-2 gap-3">
        <Field label="Interest rate (₹ / lakh · month)"><input className="input" inputMode="decimal" value={rate} onChange={e => setRate(e.target.value.replace(/[^\d.]/g, ''))} placeholder="e.g. 1000" /></Field>
        <Field label="Total grams"><input className="input" inputMode="decimal" value={grams} onChange={e => setGrams(e.target.value.replace(/[^\d.]/g, ''))} /></Field>
      </div>
      {num(amount) > 0 && num(rate) > 0 && (
        <div className="rounded-xl bg-amber-500/10 px-3 py-2 text-sm ring-1 ring-inset ring-amber-500/25">
          <span className="text-slate-300">Interest / month</span>
          <span className="ml-2 font-semibold text-amber-300 tabular-nums">{inr(Math.round(monthlyInt))}</span>
          <span className="text-slate-500"> · {inr(num(amount))} at ₹{num(rate)}/lakh</span>
        </div>
      )}

      <div className="grid grid-cols-2 gap-3">
        <Field label="Loan status">
          <div className="flex gap-1 rounded-xl bg-slate-800/60 p-1">
            {(['Active', 'Closed'] as const).map(s => (
              <button key={s} type="button" onClick={() => setStatus(s)}
                className={`flex-1 rounded-lg px-3 py-1.5 text-sm font-medium ${status === s ? (s === 'Closed' ? 'bg-slate-600 text-white' : 'bg-emerald-600 text-white') : 'text-slate-300'}`}>{s}</button>
            ))}
          </div>
        </Field>
        {status === 'Closed'
          ? <Field label="Closed date"><input type="date" className="input" value={closedDate} onChange={e => setClosedDate(e.target.value)} /></Field>
          : <Field label="Settle by (period)" hint="Defaults to a week before it turns a year old.">
              <input type="date" className="input" value={due} onChange={e => { dueTouched.current = true; setDue(e.target.value) }} />
            </Field>}
      </div>
      {status === 'Closed' && (
        <div className="grid grid-cols-2 gap-3">
          <Field label="Total interest paid (₹)" hint="What you actually paid over the loan's life.">
            <input className="input" inputMode="numeric" value={interestPaid} onChange={e => setInterestPaid(e.target.value.replace(/[^\d.]/g, ''))} />
          </Field>
          <Field label="Settle by (period)" hint="Kept for reference.">
            <input type="date" className="input" value={due} onChange={e => { dueTouched.current = true; setDue(e.target.value) }} />
          </Field>
        </div>
      )}

      <Field label="Item particulars"><textarea className="input min-h-[64px]" value={desc} onChange={e => setDesc(e.target.value)} placeholder="e.g. 2 gold bangles, 1 chain (22k)" /></Field>
      <Field label="Remark"><input className="input" value={remark} onChange={e => setRemark(e.target.value)} /></Field>

      {!editing && (
        <div>
          <div className="flex items-center justify-between">
            <span className="label">Photos of the jewels</span>
            <button type="button" className="btn-ghost !py-1 text-xs text-brand-300 ring-1 ring-inset ring-brand-500/30" onClick={() => fileRef.current?.click()}>
              <ImagePlus size={14} /> Add photos
            </button>
          </div>
          <input ref={fileRef} type="file" accept="image/*" multiple hidden onChange={onPick} />
          {busy && <p className="mt-2 text-xs text-amber-300">{busy}</p>}
          {staged.length > 0 ? (
            <div className="mt-2 grid grid-cols-4 gap-2 sm:grid-cols-5">
              {staged.map((src, i) => (
                <div key={i} className="group relative aspect-square overflow-hidden rounded-lg ring-1 ring-slate-700">
                  <img src={src} alt="" className="h-full w-full object-cover" />
                  <button type="button" onClick={() => setStaged(s => s.filter((_, k) => k !== i))}
                    className="absolute right-1 top-1 grid h-5 w-5 place-items-center rounded-full bg-black/60 text-white opacity-0 transition group-hover:opacity-100">
                    <X size={12} />
                  </button>
                </div>
              ))}
            </div>
          ) : (
            <p className="mt-2 text-xs text-slate-500">Attach 3–4 clear pictures — front, back, hallmark. You can add more later on the loan page.</p>
          )}
        </div>
      )}
    </Modal>
  )
}
