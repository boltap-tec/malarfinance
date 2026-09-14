import { useMemo, useRef, useState } from 'react'
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

const FILTERS = ['All', 'Open', 'Closed'] as const

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

  const { rows, openCount, borrowed, grams } = useMemo(() => {
    let list = repo.jewelLoans(financeFilter(finance))
    if (filter !== 'All') list = list.filter(j => (j.Loan_Status ?? 'Open') === filter)
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(j =>
      j.Loan_No?.toLowerCase().includes(s) ||
      (j.Loan_Taken_From ?? '').toLowerCase().includes(s) ||
      (j.Loan_Taken_By ?? '').toLowerCase().includes(s) ||
      (j.Particular_Description ?? '').toLowerCase().includes(s))
    const openRows = repo.jewelLoans(financeFilter(finance)).filter(j => (j.Loan_Status ?? 'Open') !== 'Closed')
    return {
      rows: list,
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
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr>
                  <Th sticky>Loan no.</Th><Th>Taken from</Th><Th>By</Th><Th>Date</Th>
                  <Th right>Grams</Th><Th right>Amount</Th><Th right>Interest</Th><Th>Photos</Th><Th>Status</Th>{isMd && <Th>Del</Th>}
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(j => (
                  <tr key={j.Loan_No} className="group hover:bg-slate-800/40">
                    <Td sticky><Link to={`/jewel/${encodeURIComponent(j.Loan_No)}`} className="font-medium text-brand-300">{j.Loan_No}</Link></Td>
                    <Td>
                      <p className="text-slate-200">{j.Loan_Taken_From || '—'}</p>
                      {j.Particular_Description && <p className="max-w-[220px] truncate text-xs text-slate-500">{j.Particular_Description}</p>}
                    </Td>
                    <Td className="text-slate-400">{j.Loan_Taken_By || '—'}</Td>
                    <Td className="text-slate-400 whitespace-nowrap">{fmtDate(j.Loan_Taken_Date)}</Td>
                    <Td right className="text-slate-300 whitespace-nowrap">{num(j.Loan_Total_grams) ? `${num(j.Loan_Total_grams)} g` : '—'}</Td>
                    <Td right className="text-hd">{inr(num(j.Loan_Amount))}</Td>
                    <Td right className="text-amber-300">{num(j.Interest_Amount) ? inr(num(j.Interest_Amount)) : '—'}</Td>
                    <Td>
                      <Link to={`/jewel/${encodeURIComponent(j.Loan_No)}`} className="inline-flex items-center gap-1 text-xs text-slate-400 hover:text-slate-200">
                        <Camera size={13} /> {num(j.Photo_Count) || 0}
                      </Link>
                    </Td>
                    <Td><Badge tone={statusTone(j.Loan_Status)}>{j.Loan_Status ?? 'Open'}</Badge></Td>
                    {isMd && <Td><button title="Delete jewel loan" className="btn-ghost !px-2 !py-1 text-xs text-rose-300" onClick={() => setDel(j)}><Trash2 size={13} /></button></Td>}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
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

// Shared create / edit form. Photos can be attached while CREATING (staged in
// memory, then written after the loan row is inserted). Editing an existing loan
// manages photos on the detail page instead, so the modal stays focused.
export function JewelForm({ finance, initial, onClose, onSaved }: {
  finance: string; initial?: JewelLoan; onClose: () => void; onSaved: () => void
}) {
  const editing = !!initial
  const [from, setFrom] = useState(initial?.Loan_Taken_From ?? '')
  const [by, setBy] = useState(initial?.Loan_Taken_By ?? '')
  const [date, setDate] = useState(initial?.Loan_Taken_Date ?? new Date().toISOString().slice(0, 10))
  const [amount, setAmount] = useState(initial?.Loan_Amount != null ? String(initial.Loan_Amount) : '')
  const [rate, setRate] = useState(initial?.Interest_Rate != null ? String(initial.Interest_Rate) : '')
  const [interestAmt, setInterestAmt] = useState(initial?.Interest_Amount != null ? String(initial.Interest_Amount) : '')
  const [grams, setGrams] = useState(initial?.Loan_Total_grams != null ? String(initial.Loan_Total_grams) : '')
  const [desc, setDesc] = useState(initial?.Particular_Description ?? '')
  const [remark, setRemark] = useState(initial?.Remark1 ?? '')
  const [closedDate, setClosedDate] = useState(initial?.Loan_Closed_Date ?? '')

  const [staged, setStaged] = useState<string[]>([])
  const [busy, setBusy] = useState('')
  const [saving, setSaving] = useState(false)
  const fileRef = useRef<HTMLInputElement>(null)

  const loanNo = editing ? initial!.Loan_No : nextJewelLoanNo(finance)
  const valid = num(amount) > 0 && !saving

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
    if (editing) {
      await updateJewelLoan(loanNo, {
        Loan_Taken_From: from.trim() || undefined,
        Loan_Taken_By: by.trim() || undefined,
        Loan_Taken_Date: date || undefined,
        Loan_Amount: num(amount),
        Interest_Rate: rate ? num(rate) : undefined,
        Interest_Amount: interestAmt ? num(interestAmt) : undefined,
        Loan_Total_grams: grams ? num(grams) : undefined,
        Particular_Description: desc.trim() || undefined,
        Remark1: remark.trim() || undefined,
        Loan_Closed_Date: closedDate || undefined,
      })
    } else {
      const loan: JewelLoan = {
        Finance_Name: finance,
        Loan_No: loanNo,
        Loan_Taken_From: from.trim() || undefined,
        Loan_Taken_By: by.trim() || undefined,
        Loan_Taken_Date: date || undefined,
        Loan_Amount: num(amount),
        Interest_Rate: rate ? num(rate) : undefined,
        Interest_Amount: interestAmt ? num(interestAmt) : undefined,
        Loan_Total_grams: grams ? num(grams) : undefined,
        Particular_Description: desc.trim() || undefined,
        Remark1: remark.trim() || undefined,
        Photo_Count: 0,
      }
      await addJewelLoan(loan)
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
      <div className="grid grid-cols-3 gap-3">
        <Field label="Rate (₹/L·mo)"><input className="input" inputMode="numeric" value={rate} onChange={e => setRate(e.target.value.replace(/[^\d.]/g, ''))} /></Field>
        <Field label="Interest paid (₹)"><input className="input" inputMode="numeric" value={interestAmt} onChange={e => setInterestAmt(e.target.value.replace(/[^\d.]/g, ''))} /></Field>
        <Field label="Total grams"><input className="input" inputMode="decimal" value={grams} onChange={e => setGrams(e.target.value.replace(/[^\d.]/g, ''))} /></Field>
      </div>
      <Field label="Item particulars"><textarea className="input min-h-[64px]" value={desc} onChange={e => setDesc(e.target.value)} placeholder="e.g. 2 gold bangles, 1 chain (22k)" /></Field>
      <Field label="Remark"><input className="input" value={remark} onChange={e => setRemark(e.target.value)} /></Field>
      {editing && (
        <Field label="Closed date" hint="Set this to mark the loan Closed; leave blank while it's open.">
          <input type="date" className="input" value={closedDate} onChange={e => setClosedDate(e.target.value)} />
        </Field>
      )}

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
