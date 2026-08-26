import { useMemo, useState } from 'react'
import { Handshake, Plus, ArrowUpRight, ArrowDownLeft, Trash2, Pencil, Search } from 'lucide-react'
import { repo, addHandEntry, updateHandEntry, deleteHandEntry } from '../data/repository'
import { useApp, canEdit } from '../store/app'
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

export default function HandExchange() {
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [tick, setTick] = useState(0)
  const [entry, setEntry] = useState<EntrySeed | null>(null)
  const [openPerson, setOpenPerson] = useState<string | null>(null)
  const [tab, setTab] = useState<'all' | 'Customer' | 'Supplier'>('all')
  const [q, setQ] = useState('')
  const [sort, setSort] = useState<'balance' | 'name' | 'recent'>('balance')

  const people = useMemo(() => repo.handPeople(), [tick])
  const summary = useMemo(() => repo.handSummary(), [tick])
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
        subtitle="Personal money you give and take with people you know — a separate module, kept entirely out of your finance ledger and balances."
        action={editable && <button className="btn-primary !py-1.5" onClick={() => setEntry({})}><Plus size={15} /> New entry</button>}
      />

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
        <EmptyState title="No hand-exchange records yet" hint={editable ? 'Use “New entry” to record giving or taking money.' : undefined} />
      ) : shown.length === 0 ? (
        <EmptyState title="No matches" hint="Try a different tab or search." />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Person</Th><Th>Last</Th><Th right>Entries</Th><Th right>Net balance</Th>{editable && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {shown.map(p => (
                  <tr key={p.name} className="hover:bg-slate-800/40">
                    <Td>
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
                    {editable && (
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

      {entry && <EntryModal seed={entry} onClose={() => setEntry(null)} onSaved={refresh} />}
      {openPerson && <PersonModal person={openPerson} editable={editable} onClose={() => setOpenPerson(null)} onChanged={() => setTick(t => t + 1)} />}
    </div>
  )
}

// Record or edit a give / get / borrow / return, for an existing or brand-new person.
function EntryModal({ seed, onClose, onSaved }: { seed: EntrySeed; onClose: () => void; onSaved: () => void }) {
  const editing = seed.edit
  const known = repo.handPeople()
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
        Date: date, Person: finalName, Person_Phone: usingNew && newPhone ? newPhone : seed.phone, Category: cat,
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
          <button className={`btn-ghost !py-1 ${personMode === 'existing' ? 'ring-1 ring-brand-500/40 text-brand-200' : ''}`} onClick={() => setPersonMode('existing')}>Existing person</button>
          <button className={`btn-ghost !py-1 ${personMode === 'new' ? 'ring-1 ring-brand-500/40 text-brand-200' : ''}`} onClick={() => setPersonMode('new')}>New person</button>
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

// One person's full history as a running-balance statement + quick add / edit.
function PersonModal({ person, editable, onClose, onChanged }: { person: string; editable: boolean; onClose: () => void; onChanged: () => void }) {
  const [tick, setTick] = useState(0)
  const [del, setDel] = useState<HandExchange | null>(null)
  const [form, setForm] = useState<EntrySeed | null>(null)
  const history = useMemo(() => repo.handHistory(person), [person, tick])
  const category = useMemo(() => repo.handPeople().find(p => p.name.toLowerCase() === person.toLowerCase())?.category ?? 'Customer', [person, tick])
  const rows = useMemo(() => withRunningBalance(history), [history])
  const net = rows.length ? rows[0].balance : 0
  const afterChange = () => { setForm(null); setTick(t => t + 1); onChanged() }

  return (
    <Modal
      title={person}
      onClose={onClose}
      footer={editable ? <>
        <button className="btn-ghost text-rose-300 ring-1 ring-inset ring-rose-500/30" onClick={() => setForm({ person, category, type: 'Give' })}><ArrowUpRight size={15} /> Give</button>
        <button className="btn-ghost text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setForm({ person, category, type: 'Get' })}><ArrowDownLeft size={15} /> Get</button>
        <button className="btn-ghost" onClick={() => setForm({ person, category, type: 'Borrow' })}>Borrow</button>
        <button className="btn-primary" onClick={onClose}>Close</button>
      </> : <button className="btn-primary" onClick={onClose}>Close</button>}
    >
      <div className="flex items-center gap-3 rounded-xl bg-slate-800/40 p-3 text-sm">
        <Avatar name={person} size={11} />
        <div className="flex-1">
          <div className="flex items-center gap-2"><Badge tone={category === 'Supplier' ? 'amber' : 'slate'}>{category}</Badge><span className="text-slate-500">{history.length} entries</span></div>
          <div className="mt-1 flex justify-between">
            <span className="text-slate-400">Net balance</span>
            {net === 0 ? <span className="text-slate-400">Settled</span>
              : <span className={net > 0 ? 'font-semibold text-emerald-400' : 'font-semibold text-rose-300'}>{inr(Math.abs(net))} · {net > 0 ? 'owes you' : 'you owe'}</span>}
          </div>
        </div>
      </div>

      <div className="divide-y divide-slate-800">
        {rows.map(({ e, balance }) => (
          <div key={e.ID} className="flex items-center justify-between gap-2 py-2 text-sm">
            <div className="min-w-0">
              <p className="flex items-center gap-2">
                <Badge tone={e.Direction === 'out' ? 'red' : 'green'}>{e.Type}</Badge>
                <span className="text-slate-400">{fmtDate(e.Date)}</span>
                {e.Mode && <span className="text-xs text-slate-500">{e.Mode}</span>}
              </p>
              {e.Note && <p className="mt-0.5 truncate text-xs text-slate-500">{e.Note}</p>}
            </div>
            <div className="flex items-center gap-2">
              <div className="text-right">
                <span className={`block tabular-nums font-semibold ${e.Direction === 'out' ? 'text-rose-300' : 'text-emerald-400'}`}>{e.Direction === 'out' ? '−' : '+'}{inr(num(e.Amount))}</span>
                <span className="block text-[11px] text-slate-500">bal {balance === 0 ? 'Settled' : `${inr(Math.abs(balance))} ${balance > 0 ? 'owes you' : 'you owe'}`}</span>
              </div>
              {editable && (
                <div className="flex flex-col gap-1">
                  <button className="text-slate-500 hover:text-brand-300" title="Edit" onClick={() => setForm({ edit: e })}><Pencil size={14} /></button>
                  <button className="text-slate-500 hover:text-rose-300" title="Delete" onClick={() => setDel(e)}><Trash2 size={14} /></button>
                </div>
              )}
            </div>
          </div>
        ))}
        {rows.length === 0 && <p className="py-3 text-sm text-slate-500">No entries.</p>}
      </div>

      {form && <EntryModal seed={form} onClose={() => setForm(null)} onSaved={afterChange} />}
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
