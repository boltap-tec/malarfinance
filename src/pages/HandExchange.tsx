import { useMemo, useState } from 'react'
import { createPortal } from 'react-dom'
import { Handshake, Plus, ArrowUpRight, ArrowDownLeft, Trash2, Pencil, Search, FileText, Download, Printer, X, ArrowLeftRight, BookOpen } from 'lucide-react'
import { repo, addHandEntry, updateHandEntry, deleteHandEntry } from '../data/repository'
import { useApp, canEdit, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState, Modal, Field, ConfirmModal } from '../components/ui'
import type { HandExchange } from '../data/types'
import { inr, inrShort, fmtDate, phone as fmtPhone, num } from '../lib/format'

// Type → money direction. Give/Return leave your hand; Get/Borrow come in.
const TYPES: { value: HandExchange['Type']; label: string; dir: 'out' | 'in'; hint: string }[] = [
  { value: 'Give', label: 'Give (I gave)', dir: 'out', hint: 'Money you handed out — they owe you' },
  { value: 'Get', label: 'Get (I received)', dir: 'in', hint: 'Money you received back from them' },
  { value: 'Borrow', label: 'Borrow (I took)', dir: 'in', hint: 'Money you took — you owe them' },
  { value: 'Return', label: 'Return (I repaid)', dir: 'out', hint: 'Money you paid back to them' },
]

const CATEGORIES = ['Customer', 'Supplier'] as const

// What the "New entry" / edit form is seeded with. `edit` switches it to edit mode.
type EntrySeed = { person?: string; phone?: number | string; type?: HandExchange['Type']; category?: string; edit?: HandExchange }

// ── Deterministic coloured initials avatar (OkCredit-style) ──────────────────
const AVATAR_COLORS = ['#e0563f', '#2f9e78', '#3d6fd6', '#b8567d', '#d99128', '#7a56c2', '#0f9aa8', '#c2454a', '#4b8f2e', '#8a6d3b']
function avatarColor(seed: string): string {
  let h = 0
  for (let i = 0; i < seed.length; i++) h = (h * 31 + seed.charCodeAt(i)) >>> 0
  return AVATAR_COLORS[h % AVATAR_COLORS.length]
}
function initials(name: string): string {
  const p = name.trim().split(/\s+/).filter(Boolean)
  if (!p.length) return '?'
  if (p.length === 1) return p[0].slice(0, 2).toUpperCase()
  return (p[0][0] + p[p.length - 1][0]).toUpperCase()
}
function Avatar({ name, size = 9 }: { name: string; size?: number }) {
  return (
    <span
      className="grid shrink-0 place-items-center rounded-full font-bold text-white"
      style={{ backgroundColor: avatarColor(name), width: size * 4, height: size * 4, fontSize: size >= 10 ? 14 : 11 }}
    >
      {initials(name)}
    </span>
  )
}

// Running balance after each entry, oldest → newest, returned newest-first for display.
function withRunningBalance(history: HandExchange[]): { e: HandExchange; balance: number }[] {
  const asc = [...history].sort((a, b) => new Date(a.Date ?? 0).getTime() - new Date(b.Date ?? 0).getTime())
  let run = 0
  const rows = asc.map(e => { run += e.Direction === 'out' ? num(e.Amount) : -num(e.Amount); return { e, balance: run } })
  return rows.reverse()
}

// Date + time label for a statement line (e.g. "16 May 2025 · 02:59 PM").
function fmtDateTime(d?: string): string {
  if (!d) return '—'
  const dt = new Date(d)
  if (isNaN(dt.getTime())) return fmtDate(d)
  const hasTime = /[T ]\d{2}:\d{2}/.test(d)
  return hasTime
    ? `${fmtDate(d)} · ${dt.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' })}`
    : fmtDate(d)
}

// Net-balance phrasing shared by the person statement and the reports.
// net > 0 → they owe you (you'll get); net < 0 → you owe (you'll give).
function netLabel(net: number): { text: string; tone: 'green' | 'red' | 'slate' } {
  if (net === 0) return { text: 'Settled', tone: 'slate' }
  return net > 0
    ? { text: `${inr(net)} · owes you`, tone: 'green' }
    : { text: `${inr(-net)} · you owe`, tone: 'red' }
}

export default function HandExchange() {
  const role = useApp(s => s.user?.role)
  const finance = useApp(s => s.finance)
  const editable = canEdit(role)
  // New entries must land in a specific finance firm's book, so adding needs a
  // single finance picked in the switcher (not the combined 'ALL' view).
  const canAdd = editable && finance !== 'ALL'
  const [tick, setTick] = useState(0)
  const [entry, setEntry] = useState<EntrySeed | null>(null)
  const [openPerson, setOpenPerson] = useState<string | null>(null)
  const [report, setReport] = useState(false)
  const [tab, setTab] = useState<'all' | 'Customer' | 'Supplier'>('all')
  const [q, setQ] = useState('')
  const [sort, setSort] = useState<'balance' | 'name' | 'recent'>('balance')

  const people = useMemo(() => repo.handPeople(financeFilter(finance)), [tick, finance])
  const summary = useMemo(() => repo.handSummary(financeFilter(finance)), [tick, finance])
  const refresh = () => { setEntry(null); setTick(t => t + 1) }

  const counts = useMemo(() => ({
    all: people.length,
    Customer: people.filter(p => p.category === 'Customer').length,
    Supplier: people.filter(p => p.category === 'Supplier').length,
  }), [people])

  const shown = useMemo(() => {
    let list = people
    if (tab !== 'all') list = list.filter(p => p.category === tab)
    const query = q.trim().toLowerCase()
    if (query) list = list.filter(p => p.name.toLowerCase().includes(query) || String(p.phone ?? '').includes(query))
    const arr = [...list]
    if (sort === 'name') arr.sort((a, b) => a.name.localeCompare(b.name))
    else if (sort === 'recent') arr.sort((a, b) => (b.last ?? '').localeCompare(a.last ?? ''))
    // 'balance' keeps the repository's default order (largest outstanding first).
    return arr
  }, [people, tab, q, sort])

  const tabs: { key: typeof tab; label: string; n: number }[] = [
    { key: 'all', label: 'All', n: counts.all },
    { key: 'Customer', label: 'Customers', n: counts.Customer },
    { key: 'Supplier', label: 'Suppliers', n: counts.Supplier },
  ]

  return (
    <div>
      <PageHeader
        title="Hand exchange"
        subtitle="Money given and taken with people you know — a separate book per finance firm, kept entirely out of that firm's ledger and balances."
        action={<div className="flex gap-2">
          <button className="btn-ghost !py-1.5" onClick={() => setReport(true)}><FileText size={15} /> Report</button>
          {canAdd && <button className="btn-primary !py-1.5" onClick={() => setEntry({})}><Plus size={15} /> New entry</button>}
        </div>}
      />

      {editable && finance === 'ALL' && (
        <p className="mb-4 text-xs text-amber-300/80">Showing all firms combined. Pick a single finance in the switcher to add a hand-exchange entry.</p>
      )}

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="They owe you" value={inrShort(summary.theyOwe)} tone="green" icon={<ArrowDownLeft size={18} />} />
        <StatCard label="You owe" value={inrShort(summary.youOwe)} tone="red" icon={<ArrowUpRight size={18} />} />
        <StatCard label="People" value={people.length} tone="blue" icon={<Handshake size={18} />} />
      </div>

      {/* Tabs + search + sort */}
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
        <div className="ml-auto flex items-center gap-2">
          <div className="relative">
            <Search size={14} className="pointer-events-none absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-500" />
            <input className="input !py-1.5 pl-8 text-sm" placeholder="Search name / phone" value={q} onChange={e => setQ(e.target.value)} />
          </div>
          <select className="input !py-1.5 text-sm" value={sort} onChange={e => setSort(e.target.value as typeof sort)}>
            <option value="balance">Sort: Balance</option>
            <option value="name">Sort: Name</option>
            <option value="recent">Sort: Recent</option>
          </select>
        </div>
      </div>

      {people.length === 0 ? (
        <EmptyState title="No hand-exchange records yet" hint={canAdd ? 'Use “New entry” to record giving or taking money.' : editable ? 'Pick a single finance in the switcher to add an entry.' : undefined} />
      ) : shown.length === 0 ? (
        <EmptyState title="No matches" hint="Try a different tab or search." />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th sticky>Person</Th><Th>Last</Th><Th right>Entries</Th><Th right>Net balance</Th>{canAdd && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {shown.map(p => (
                  <tr key={p.name} className="group hover:bg-slate-800/40">
                    <Td sticky>
                      <button className="flex items-center gap-2.5 text-left" onClick={() => setOpenPerson(p.name)}>
                        <Avatar name={p.name} />
                        <span className="min-w-0">
                          <span className="flex items-center gap-1.5">
                            <span className="font-medium text-brand-300 hover:underline">{p.name}</span>
                            <Badge tone={p.category === 'Supplier' ? 'amber' : 'slate'}>{p.category}</Badge>
                          </span>
                          {p.phone && <span className="block text-xs text-slate-500">{fmtPhone(p.phone)}</span>}
                        </span>
                      </button>
                    </Td>
                    <Td className="text-slate-400">{fmtDate(p.last)}</Td>
                    <Td right className="text-slate-400">{p.count}</Td>
                    <Td right>
                      {p.net === 0
                        ? <span className="text-slate-500">Settled</span>
                        : <span className={p.net > 0 ? 'font-semibold text-emerald-400' : 'font-semibold text-rose-300'}>
                            {inr(Math.abs(p.net))} <span className="text-xs font-normal text-slate-500">{p.net > 0 ? 'owes you' : 'you owe'}</span>
                          </span>}
                    </Td>
                    {canAdd && (
                      <Td>
                        <div className="flex gap-1.5">
                          <button title="Give" onClick={() => setEntry({ person: p.name, phone: p.phone, category: p.category, type: 'Give' })} className="btn-ghost !px-2 !py-1 text-xs text-rose-300 ring-1 ring-inset ring-rose-500/30"><ArrowUpRight size={13} /> Give</button>
                          <button title="Get" onClick={() => setEntry({ person: p.name, phone: p.phone, category: p.category, type: 'Get' })} className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"><ArrowDownLeft size={13} /> Get</button>
                        </div>
                      </Td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {entry && <EntryModal seed={entry} finance={finance} onClose={() => setEntry(null)} onSaved={refresh} />}
      {openPerson && <PersonModal person={openPerson} finance={finance} editable={editable} canAdd={canAdd} onClose={() => setOpenPerson(null)} onChanged={() => setTick(t => t + 1)} />}
      {report && <HandReportModal finance={finance} onClose={() => setReport(false)} />}
    </div>
  )
}

// Record or edit a give / get / borrow / return, for an existing or brand-new person.
function EntryModal({ seed, finance, onClose, onSaved }: { seed: EntrySeed; finance: string; onClose: () => void; onSaved: () => void }) {
  const editing = seed.edit
  const known = repo.handPeople(financeFilter(finance))
  const lockedPerson = !!editing || !!seed.person
  const [personMode, setPersonMode] = useState<'existing' | 'new'>(known.length ? 'existing' : 'new')
  const [person, setPerson] = useState(seed.person ?? known[0]?.name ?? '')
  const [newName, setNewName] = useState('')
  const [newPhone, setNewPhone] = useState('')
  const [category, setCategory] = useState<string>(seed.category ?? 'Customer')
  const [type, setType] = useState<HandExchange['Type']>(editing?.Type ?? seed.type ?? 'Give')
  const [amount, setAmount] = useState(editing ? String(editing.Amount) : '')
  const [date, setDate] = useState((editing?.Date ?? new Date().toISOString()).slice(0, 10))
  const [mode, setMode] = useState(editing?.Mode ?? 'Cash')
  const [note, setNote] = useState(editing?.Note ?? '')
  const [busy, setBusy] = useState(false)

  const usingNew = !lockedPerson && (personMode === 'new' || known.length === 0)
  const finalName = editing ? editing.Person : (usingNew ? newName : person).trim()
  const valid = finalName.length > 0 && num(amount) > 0
  const dir = TYPES.find(t => t.value === type)?.dir ?? 'out'

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    if (editing) {
      await updateHandEntry(editing.ID, { Date: date, Amount: num(amount), Direction: dir, Type: type, Mode: mode, Note: note.trim() || undefined })
    } else {
      const cat = usingNew ? category : (seed.category ?? known.find(k => k.name.toLowerCase() === finalName.toLowerCase())?.category ?? 'Customer')
      await addHandEntry({
        Finance_Name: finance, Date: date, Person: finalName, Person_Phone: usingNew && newPhone ? newPhone : seed.phone, Category: cat,
        Amount: num(amount), Direction: dir, Type: type, Mode: mode, Note: note.trim() || undefined,
      })
    }
    onSaved()
  }

  return (
    <Modal
      title={editing ? 'Edit entry' : 'Hand-exchange entry'}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>{editing ? 'Save' : 'Record'}</button>
      </>}
    >
      {/* Person: pick existing, or add a new one with details */}
      {!lockedPerson && known.length > 0 && (
        <div className="flex gap-2 text-sm">
          <button className={personMode === 'existing' ? 'btn-primary !py-1' : 'btn-ghost !py-1'} onClick={() => setPersonMode('existing')}>Existing person</button>
          <button className={personMode === 'new' ? 'btn-primary !py-1' : 'btn-ghost !py-1'} onClick={() => setPersonMode('new')}>New person</button>
        </div>
      )}
      {!lockedPerson && !usingNew && (
        <Field label="Person">
          <select className="input" value={person} onChange={e => setPerson(e.target.value)}>
            {known.map(p => <option key={p.name} value={p.name}>{p.name}</option>)}
          </select>
        </Field>
      )}
      {lockedPerson && <div className="rounded-xl bg-slate-800/40 p-3 text-sm text-slate-300">Person: <b className="text-hd">{finalName}</b></div>}
      {usingNew && (
        <>
          <div className="grid grid-cols-2 gap-3">
            <Field label="Name"><input className="input" autoFocus value={newName} onChange={e => setNewName(e.target.value)} /></Field>
            <Field label="Phone (optional)"><input className="input" inputMode="tel" value={newPhone} onChange={e => setNewPhone(e.target.value)} /></Field>
          </div>
          <Field label="File under">
            <div className="flex gap-2">
              {CATEGORIES.map(c => (
                <button key={c} type="button" className={`btn-ghost !py-1 flex-1 ${category === c ? 'ring-1 ring-brand-500/40 text-brand-200' : 'text-slate-400'}`} onClick={() => setCategory(c)}>{c}</button>
              ))}
            </div>
          </Field>
        </>
      )}

      <Field label="Type" hint={TYPES.find(t => t.value === type)?.hint}>
        <select className="input" value={type} onChange={e => setType(e.target.value as HandExchange['Type'])}>
          {TYPES.map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
        </select>
      </Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Mode">
          <select className="input" value={mode} onChange={e => setMode(e.target.value)}><option>Cash</option><option>Account</option><option>UPI</option><option>Other</option></select>
        </Field>
        <Field label="Note (optional)"><input className="input" value={note} onChange={e => setNote(e.target.value)} /></Field>
      </div>
    </Modal>
  )
}

// One person's full history as a two-column (You gave / You got) statement with a
// pinned header and a scrollable body, plus quick add / edit.
function PersonModal({ person, finance, editable, canAdd, onClose, onChanged }: { person: string; finance: string; editable: boolean; canAdd: boolean; onClose: () => void; onChanged: () => void }) {
  const [tick, setTick] = useState(0)
  const [del, setDel] = useState<HandExchange | null>(null)
  const [form, setForm] = useState<EntrySeed | null>(null)
  const history = useMemo(() => repo.handHistory(person, financeFilter(finance)), [person, finance, tick])
  const category = useMemo(() => repo.handPeople(financeFilter(finance)).find(p => p.name.toLowerCase() === person.toLowerCase())?.category ?? 'Customer', [person, finance, tick])
  const rows = useMemo(() => withRunningBalance(history), [history])
  const net = rows.length ? rows[0].balance : 0
  const afterChange = () => { setForm(null); setTick(t => t + 1); onChanged() }
  const nl = netLabel(net)

  return (
    <Modal
      title={person}
      onClose={onClose}
      footer={canAdd ? <>
        <button className="btn-ghost text-rose-300 ring-1 ring-inset ring-rose-500/30" onClick={() => setForm({ person, category, type: 'Give' })}><ArrowUpRight size={15} /> You gave</button>
        <button className="btn-ghost text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setForm({ person, category, type: 'Get' })}><ArrowDownLeft size={15} /> You got</button>
        <button className="btn-ghost" onClick={() => setForm({ person, category, type: 'Borrow' })}>Borrow</button>
        <button className="btn-primary" onClick={onClose}>Close</button>
      </> : <button className="btn-primary" onClick={onClose}>Close</button>}
    >
      {/* Summary header — stays put while the statement below scrolls. */}
      <div className="flex items-center gap-3 rounded-xl bg-slate-800/40 p-3 text-sm">
        <Avatar name={person} size={11} />
        <div className="flex-1">
          <div className="flex items-center gap-2"><Badge tone={category === 'Supplier' ? 'amber' : 'slate'}>{category}</Badge><span className="text-slate-500">{history.length} entries</span></div>
          <div className="mt-1 flex justify-between">
            <span className="text-slate-400">Net balance</span>
            <span className={nl.tone === 'green' ? 'font-semibold text-emerald-400' : nl.tone === 'red' ? 'font-semibold text-rose-300' : 'text-slate-400'}>{nl.text}</span>
          </div>
        </div>
      </div>

      {/* Two-column statement: ENTRIES | YOU GAVE | YOU GOT. The body scrolls
          on its own so a long history reads top → bottom inside the dialog. */}
      <div className="overflow-hidden rounded-xl border border-slate-800">
        <div className="grid grid-cols-[1fr_auto_auto] gap-x-4 border-b border-slate-800 bg-slate-900/60 px-3 py-2 text-[11px] font-semibold uppercase tracking-wide text-slate-400">
          <span>Entries</span>
          <span className="w-20 text-right">You gave</span>
          <span className="w-20 text-right">You got</span>
        </div>
        <div className="max-h-[48vh] divide-y divide-slate-800 overflow-y-auto">
          {rows.map(({ e, balance }) => {
            const gave = e.Direction === 'out'
            const bl = netLabel(balance)
            return (
              <div key={e.ID} className="group grid grid-cols-[1fr_auto_auto] items-center gap-x-4 px-3 py-2.5 text-sm hover:bg-slate-800/40">
                <div className="min-w-0">
                  <p className="font-medium text-slate-200">{fmtDateTime(e.Date)}</p>
                  <p className="mt-0.5 text-xs text-slate-500">
                    Balance: {balance === 0 ? 'Settled' : bl.text}
                    {e.Mode && <span> · {e.Mode}</span>}
                  </p>
                  <p className="mt-0.5 flex items-center gap-2 text-xs">
                    <Badge tone={gave ? 'red' : 'green'}>{e.Type}</Badge>
                    {e.Note && <span className="truncate text-slate-500">{e.Note}</span>}
                  </p>
                </div>
                <span className={`w-20 text-right tabular-nums font-semibold ${gave ? 'text-rose-300' : 'text-slate-600'}`}>{gave ? inr(num(e.Amount)) : '−'}</span>
                <div className="flex w-20 items-center justify-end gap-1.5">
                  <span className={`text-right tabular-nums font-semibold ${!gave ? 'text-emerald-400' : 'text-slate-600'}`}>{!gave ? inr(num(e.Amount)) : '−'}</span>
                  {editable && (
                    <span className="flex flex-col gap-1 opacity-0 transition group-hover:opacity-100">
                      <button className="text-slate-500 hover:text-brand-300" title="Edit" onClick={() => setForm({ edit: e })}><Pencil size={13} /></button>
                      <button className="text-slate-500 hover:text-rose-300" title="Delete" onClick={() => setDel(e)}><Trash2 size={13} /></button>
                    </span>
                  )}
                </div>
              </div>
            )
          })}
          {rows.length === 0 && <p className="px-3 py-4 text-sm text-slate-500">No entries.</p>}
        </div>
      </div>

      {form && <EntryModal seed={form} finance={finance} onClose={() => setForm(null)} onSaved={afterChange} />}
      {del && (
        <ConfirmModal
          title="Delete entry"
          message={<>Delete this {del.Type} of <b className="text-hd">{inr(num(del.Amount))}</b>?</>}
          onConfirm={async () => { await deleteHandEntry(del.ID); setDel(null); setTick(t => t + 1); onChanged() }}
          onClose={() => setDel(null)}
        />
      )}
    </Modal>
  )
}

// ── Reports ──────────────────────────────────────────────────────────────────
// Two OkCredit-style reports over the hand-exchange book, both scoped to the
// current finance switcher: a per-party Transaction report and a Cashbook report.
type Period = 'this-month' | 'last-month' | 'this-year' | 'last-year' | 'all' | 'custom'
const PERIODS: { value: Period; label: string }[] = [
  { value: 'this-month', label: 'This Month' },
  { value: 'last-month', label: 'Last Month' },
  { value: 'this-year', label: 'This Year' },
  { value: 'last-year', label: 'Last Year' },
  { value: 'all', label: 'All Time' },
  { value: 'custom', label: 'Custom' },
]
const isoDay = (d: Date) => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
function periodRange(p: Period): { start: string; end: string } {
  const now = new Date(), y = now.getFullYear(), m = now.getMonth()
  switch (p) {
    case 'this-month': return { start: isoDay(new Date(y, m, 1)), end: isoDay(new Date(y, m + 1, 0)) }
    case 'last-month': return { start: isoDay(new Date(y, m - 1, 1)), end: isoDay(new Date(y, m, 0)) }
    case 'this-year': return { start: isoDay(new Date(y, 0, 1)), end: isoDay(new Date(y, 11, 31)) }
    case 'last-year': return { start: isoDay(new Date(y - 1, 0, 1)), end: isoDay(new Date(y - 1, 11, 31)) }
    default: return { start: '', end: '' }
  }
}
// An entry's yyyy-mm-dd, for range comparison.
const entryDay = (e: HandExchange) => (e.Date ?? '').slice(0, 10)
function inRange(day: string, start: string, end: string): boolean {
  if (!day) return false
  if (start && day < start) return false
  if (end && day > end) return false
  return true
}
const prettyDay = (d: string) => (d ? fmtDate(d) : '—')

// Trigger a client-side file download from generated text.
function downloadFile(filename: string, text: string, mime: string) {
  const blob = new Blob([text], { type: mime })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url; a.download = filename
  document.body.appendChild(a); a.click(); a.remove()
  setTimeout(() => URL.revokeObjectURL(url), 1000)
}
// Excel-friendly CSV (UTF-8 BOM so ₹ and Indian names render correctly).
function downloadCSV(filename: string, rows: (string | number)[][]) {
  const esc = (v: string | number) => {
    const s = String(v ?? '')
    return /[",\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s
  }
  downloadFile(filename, '﻿' + rows.map(r => r.map(esc).join(',')).join('\r\n'), 'text/csv;charset=utf-8;')
}
// Open a print window with a plain report table; the browser's print dialog
// offers "Save as PDF" (no PDF library needed).
function printReport(title: string, subtitle: string, headers: string[], rows: (string | number)[][], totals?: { label: string; value: string }[]) {
  const w = window.open('', '_blank', 'width=900,height=700')
  if (!w) { alert('Please allow pop-ups to download the PDF.'); return }
  const esc = (v: string | number) => String(v ?? '').replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c]!))
  const thead = `<tr>${headers.map((h, i) => `<th class="${i === 0 ? 'l' : 'r'}">${esc(h)}</th>`).join('')}</tr>`
  const tbody = rows.map(r => `<tr>${r.map((c, i) => `<td class="${i === 0 ? 'l' : 'r'}">${esc(c)}</td>`).join('')}</tr>`).join('')
  const totalsHtml = totals?.length
    ? `<div class="totals">${totals.map(t => `<div><span>${esc(t.label)}</span><b>${esc(t.value)}</b></div>`).join('')}</div>`
    : ''
  w.document.write(`<!doctype html><html><head><meta charset="utf-8"><title>${esc(title)}</title>
    <style>
      *{box-sizing:border-box} body{font-family:Arial,Helvetica,sans-serif;color:#111;margin:28px}
      h1{font-size:20px;margin:0 0 2px} .sub{color:#555;font-size:12px;margin:0 0 16px}
      .totals{display:flex;gap:24px;margin:0 0 16px;flex-wrap:wrap}
      .totals div{border:1px solid #ddd;border-radius:8px;padding:8px 14px;min-width:130px}
      .totals span{display:block;font-size:11px;color:#666;text-transform:uppercase;letter-spacing:.04em}
      .totals b{font-size:16px}
      table{width:100%;border-collapse:collapse;font-size:12px}
      th,td{border-bottom:1px solid #e5e5e5;padding:7px 8px} th{background:#f5f5f5;text-transform:uppercase;font-size:10px;letter-spacing:.04em;color:#555}
      .l{text-align:left} .r{text-align:right}
      @media print{body{margin:12mm}}
    </style></head><body>
    <h1>${esc(title)}</h1><p class="sub">${esc(subtitle)}</p>
    ${totalsHtml}
    <table><thead>${thead}</thead><tbody>${tbody || `<tr><td class="l" colspan="${headers.length}">No entries.</td></tr>`}</tbody></table>
    </body></html>`)
  w.document.close(); w.focus()
  setTimeout(() => w.print(), 350)
}

function HandReportModal({ finance, onClose }: { finance: string; onClose: () => void }) {
  const [view, setView] = useState<'transaction' | 'cashbook'>('transaction')
  const all = useMemo(() => repo.handEntries(financeFilter(finance)), [finance])
  const scope = finance === 'ALL' ? 'All firms' : finance

  const overlay = (
    <div className="fixed inset-0 z-[70] overflow-y-auto bg-black/60 p-3 backdrop-blur-sm sm:p-4" onClick={onClose}>
      <div className="mx-auto flex min-h-full max-w-5xl items-start justify-center">
        <div className="card relative w-full min-w-0 !p-0" onClick={e => e.stopPropagation()}>
          <div className="flex items-center justify-between border-b border-slate-800 px-4 py-3 sm:px-5">
            <div className="flex items-center gap-2">
              <FileText size={18} className="text-brand-300" />
              <h3 className="text-lg font-bold text-hd">Hand-exchange reports</h3>
            </div>
            <button onClick={onClose} className="text-slate-400 hover:text-slate-200"><X size={18} /></button>
          </div>
          <div className="flex flex-col sm:flex-row">
            {/* Report picker */}
            <div className="flex shrink-0 gap-1.5 border-b border-slate-800 p-3 sm:w-56 sm:flex-col sm:border-b-0 sm:border-r">
              <button onClick={() => setView('transaction')} className={`flex flex-1 items-center gap-2 rounded-xl px-3 py-2.5 text-left text-sm font-medium sm:flex-none ${view === 'transaction' ? 'bg-brand-500/15 text-brand-200 ring-1 ring-brand-500/30' : 'text-slate-400 hover:bg-slate-800/40'}`}>
                <ArrowLeftRight size={16} /> <span><span className="block">Transaction Report</span><span className="hidden text-xs font-normal text-slate-500 sm:block">Per person, by period</span></span>
              </button>
              <button onClick={() => setView('cashbook')} className={`flex flex-1 items-center gap-2 rounded-xl px-3 py-2.5 text-left text-sm font-medium sm:flex-none ${view === 'cashbook' ? 'bg-brand-500/15 text-brand-200 ring-1 ring-brand-500/30' : 'text-slate-400 hover:bg-slate-800/40'}`}>
                <BookOpen size={16} /> <span><span className="block">Cashbook Report</span><span className="hidden text-xs font-normal text-slate-500 sm:block">Cash in vs out</span></span>
              </button>
            </div>
            <div className="min-w-0 flex-1 p-4 sm:p-5">
              {view === 'transaction'
                ? <TransactionReport all={all} scope={scope} />
                : <CashbookReport all={all} scope={scope} />}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
  return typeof document !== 'undefined' ? createPortal(overlay, document.body) : overlay
}

// Shared period + date-range picker used by both reports.
function PeriodPicker({ period, setPeriod, start, end, setStart, setEnd }: {
  period: Period; setPeriod: (p: Period) => void
  start: string; end: string; setStart: (s: string) => void; setEnd: (s: string) => void
}) {
  const custom = period === 'custom'
  const onPeriod = (p: Period) => {
    setPeriod(p)
    if (p !== 'custom') { const r = periodRange(p); setStart(r.start); setEnd(r.end) }
  }
  return (
    <div className="grid grid-cols-1 gap-3 sm:grid-cols-3">
      <Field label="Period">
        <select className="input" value={period} onChange={e => onPeriod(e.target.value as Period)}>
          {PERIODS.map(p => <option key={p.value} value={p.value}>{p.label}</option>)}
        </select>
      </Field>
      <Field label="Start">
        <input type="date" className="input" value={start} onChange={e => { setStart(e.target.value); setPeriod('custom') }} disabled={!custom && period !== 'all'} />
      </Field>
      <Field label="End">
        <input type="date" className="input" value={end} onChange={e => { setEnd(e.target.value); setPeriod('custom') }} disabled={!custom && period !== 'all'} />
      </Field>
    </div>
  )
}

function TransactionReport({ all, scope }: { all: HandExchange[]; scope: string }) {
  const [cat, setCat] = useState<'Customer' | 'Supplier'>('Customer')
  const [q, setQ] = useState('')
  const [period, setPeriod] = useState<Period>('this-month')
  const init = periodRange('this-month')
  const [start, setStart] = useState(init.start)
  const [end, setEnd] = useState(init.end)

  const counts = useMemo(() => {
    const c = new Set<string>(), s = new Set<string>()
    for (const e of all) {
      const k = (e.Person ?? '').trim().toLowerCase(); if (!k) continue
      ;(e.Category === 'Supplier' ? s : c).add(k)
    }
    return { Customer: c.size, Supplier: s.size }
  }, [all])

  const rows = useMemo(() => {
    const query = q.trim().toLowerCase()
    return all
      .filter(e => (e.Category === 'Supplier' ? 'Supplier' : 'Customer') === cat)
      .filter(e => inRange(entryDay(e), start, end))
      .filter(e => !query || (e.Person ?? '').toLowerCase().includes(query) || String(e.Person_Phone ?? '').includes(query))
      .sort((a, b) => new Date(b.Date ?? 0).getTime() - new Date(a.Date ?? 0).getTime())
  }, [all, cat, q, start, end])

  const gave = rows.filter(e => e.Direction === 'out').reduce((s, e) => s + num(e.Amount), 0)
  const got = rows.filter(e => e.Direction === 'in').reduce((s, e) => s + num(e.Amount), 0)
  const net = gave - got
  const rangeText = start || end ? `${prettyDay(start)} – ${prettyDay(end)}` : 'All time'

  const table = (): { headers: string[]; data: (string | number)[][] } => ({
    headers: ['Date', 'Person', 'Type', 'Note', 'You Gave', 'You Got'],
    data: rows.map(e => [
      prettyDay(entryDay(e)), e.Person, e.Type, e.Note ?? '',
      e.Direction === 'out' ? num(e.Amount) : '', e.Direction === 'in' ? num(e.Amount) : '',
    ]),
  })
  const doPdf = () => { const t = table(); printReport('Transaction Report', `${cat}s · ${scope} · ${rangeText}`, t.headers, t.data,
    [{ label: 'You Gave', value: inr(gave) }, { label: 'You Got', value: inr(got) }, { label: 'Net Balance', value: inr(net) }]) }
  const doCsv = () => { const t = table(); downloadCSV(`transaction-report-${cat.toLowerCase()}.csv`, [['Transaction Report', `${cat}s`, scope, rangeText], t.headers, ...t.data,
    [], ['You Gave', gave], ['You Got', got], ['Net Balance', net]]) }

  const nl = netLabel(net)
  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between gap-2">
        <div className="flex items-center gap-2">
          <span className="grid h-9 w-9 place-items-center rounded-full bg-brand-500/15 text-brand-300"><ArrowLeftRight size={18} /></span>
          <div><h4 className="font-bold text-hd">Transaction Report</h4><p className="text-xs text-slate-500">{scope} · all transactions</p></div>
        </div>
        <div className="flex gap-2">
          <button className="btn-ghost !py-1.5 text-sm" onClick={doPdf}><Printer size={14} /> PDF</button>
          <button className="btn-ghost !py-1.5 text-sm" onClick={doCsv}><Download size={14} /> Excel</button>
        </div>
      </div>

      {/* Customers / Suppliers tabs */}
      <div className="flex gap-1.5">
        {(['Customer', 'Supplier'] as const).map(c => (
          <button key={c} onClick={() => setCat(c)} className={`btn-ghost !py-1 text-sm ${cat === c ? 'ring-1 ring-brand-500/40 text-brand-200' : 'text-slate-400'}`}>
            {c}s <span className="text-xs text-slate-500">{counts[c]}</span>
          </button>
        ))}
      </div>

      <Field label="Customer / person name">
        <div className="relative">
          <Search size={14} className="pointer-events-none absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input pl-8" placeholder="Search" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </Field>
      <PeriodPicker period={period} setPeriod={setPeriod} start={start} end={end} setStart={setStart} setEnd={setEnd} />

      <p className="text-sm font-semibold text-slate-300">Total {rows.length} {rows.length === 1 ? 'entry' : 'entries'}</p>
      <div className="grid grid-cols-3 gap-3">
        <StatCard label="You Gave" value={inr(gave)} tone="red" />
        <StatCard label="You Got" value={inr(got)} tone="green" />
        <StatCard label="Net Balance" value={nl.tone === 'slate' ? 'Settled' : inr(Math.abs(net))} sub={nl.tone === 'slate' ? undefined : net > 0 ? 'they owe you' : 'you owe'} tone={nl.tone === 'red' ? 'red' : nl.tone === 'green' ? 'green' : 'slate'} />
      </div>

      {rows.length === 0 ? (
        <EmptyState title="No entries" hint="Try another period or category." />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="max-h-[42vh] overflow-auto">
            <table className="w-full">
              <thead className="sticky top-0 border-b border-slate-800 bg-slate-900"><tr><Th sticky>Person</Th><Th>Date</Th><Th>Type</Th><Th right>You Gave</Th><Th right>You Got</Th></tr></thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(e => (
                  <tr key={e.ID} className="group hover:bg-slate-800/40">
                    <Td sticky>
                      <span className="font-medium text-slate-200">{e.Person}</span>
                      {e.Note && <span className="block text-xs text-slate-500">{e.Note}</span>}
                    </Td>
                    <Td className="text-slate-400">{fmtDate(e.Date)}</Td>
                    <Td><Badge tone={e.Direction === 'out' ? 'red' : 'green'}>{e.Type}</Badge></Td>
                    <Td right className="font-semibold text-rose-300">{e.Direction === 'out' ? inr(num(e.Amount)) : '−'}</Td>
                    <Td right className="font-semibold text-emerald-400">{e.Direction === 'in' ? inr(num(e.Amount)) : '−'}</Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}
    </div>
  )
}

function CashbookReport({ all, scope }: { all: HandExchange[]; scope: string }) {
  const [period, setPeriod] = useState<Period>('this-month')
  const init = periodRange('this-month')
  const [start, setStart] = useState(init.start)
  const [end, setEnd] = useState(init.end)

  // Oldest → newest so the running cash balance reads correctly; displayed newest first.
  const asc = useMemo(() => all
    .filter(e => inRange(entryDay(e), start, end))
    .sort((a, b) => new Date(a.Date ?? 0).getTime() - new Date(b.Date ?? 0).getTime()), [all, start, end])
  const rows = useMemo(() => {
    let run = 0
    return asc.map(e => { run += e.Direction === 'in' ? num(e.Amount) : -num(e.Amount); return { e, balance: run } }).reverse()
  }, [asc])

  const totalIn = asc.filter(e => e.Direction === 'in').reduce((s, e) => s + num(e.Amount), 0)
  const totalOut = asc.filter(e => e.Direction === 'out').reduce((s, e) => s + num(e.Amount), 0)
  const netCash = totalIn - totalOut
  const rangeText = start || end ? `${prettyDay(start)} – ${prettyDay(end)}` : 'All time'

  const table = (): { headers: string[]; data: (string | number)[][] } => ({
    headers: ['Date', 'Person', 'Type', 'Note', 'In', 'Out', 'Balance'],
    data: rows.map(({ e, balance }) => [
      prettyDay(entryDay(e)), e.Person, e.Type, e.Note ?? '',
      e.Direction === 'in' ? num(e.Amount) : '', e.Direction === 'out' ? num(e.Amount) : '', balance,
    ]),
  })
  const doPdf = () => { const t = table(); printReport('Cashbook Report', `${scope} · ${rangeText}`, t.headers, t.data,
    [{ label: 'Total In', value: inr(totalIn) }, { label: 'Total Out', value: inr(totalOut) }, { label: 'Net Balance', value: inr(netCash) }]) }
  const doCsv = () => { const t = table(); downloadCSV('cashbook-report.csv', [['Cashbook Report', scope, rangeText], t.headers, ...t.data,
    [], ['Total In', totalIn], ['Total Out', totalOut], ['Net Balance', netCash]]) }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between gap-2">
        <div className="flex items-center gap-2">
          <span className="grid h-9 w-9 place-items-center rounded-full bg-brand-500/15 text-brand-300"><BookOpen size={18} /></span>
          <div><h4 className="font-bold text-hd">Cashbook Report</h4><p className="text-xs text-slate-500">{scope} · cash in vs out</p></div>
        </div>
        <div className="flex gap-2">
          <button className="btn-ghost !py-1.5 text-sm" onClick={doPdf}><Printer size={14} /> PDF</button>
          <button className="btn-ghost !py-1.5 text-sm" onClick={doCsv}><Download size={14} /> Excel</button>
        </div>
      </div>

      <PeriodPicker period={period} setPeriod={setPeriod} start={start} end={end} setStart={setStart} setEnd={setEnd} />

      <p className="text-sm font-semibold text-slate-300">Total {rows.length} {rows.length === 1 ? 'entry' : 'entries'}</p>
      <div className="grid grid-cols-3 gap-3">
        <StatCard label="Total In" value={inr(totalIn)} tone="green" icon={<ArrowDownLeft size={18} />} />
        <StatCard label="Total Out" value={inr(totalOut)} tone="red" icon={<ArrowUpRight size={18} />} />
        <StatCard label="Net Balance" value={inr(netCash)} tone="blue" />
      </div>

      {rows.length === 0 ? (
        <EmptyState title="No cash movements" hint="Try another period." />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="max-h-[42vh] overflow-auto">
            <table className="w-full">
              <thead className="sticky top-0 border-b border-slate-800 bg-slate-900"><tr><Th sticky>Person</Th><Th>Date</Th><Th right>In</Th><Th right>Out</Th><Th right>Balance</Th></tr></thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(({ e, balance }) => (
                  <tr key={e.ID} className="group hover:bg-slate-800/40">
                    <Td sticky>
                      <span className="font-medium text-slate-200">{e.Person}</span>
                      <span className="block text-xs text-slate-500">{e.Type}{e.Note ? ` · ${e.Note}` : ''}</span>
                    </Td>
                    <Td className="text-slate-400">{fmtDate(e.Date)}</Td>
                    <Td right className="font-semibold text-emerald-400">{e.Direction === 'in' ? inr(num(e.Amount)) : '−'}</Td>
                    <Td right className="font-semibold text-rose-300">{e.Direction === 'out' ? inr(num(e.Amount)) : '−'}</Td>
                    <Td right className="tabular-nums text-slate-300">{inr(balance)}</Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}
    </div>
  )
}
