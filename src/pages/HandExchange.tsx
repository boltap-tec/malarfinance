import { useMemo, useState } from 'react'
import { Handshake, Plus, ArrowUpRight, ArrowDownLeft, Trash2 } from 'lucide-react'
import { repo, addHandEntry, deleteHandEntry } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState, Modal, Field, ConfirmModal } from '../components/ui'
import type { HandExchange } from '../data/types'
import { inr, fmtDate, phone as fmtPhone, num } from '../lib/format'

// Type → money direction. Give/Return leave your hand; Get/Borrow come in.
const TYPES: { value: HandExchange['Type']; label: string; dir: 'out' | 'in'; hint: string }[] = [
  { value: 'Give', label: 'Give (I gave)', dir: 'out', hint: 'Money you handed out — they owe you' },
  { value: 'Get', label: 'Get (I received)', dir: 'in', hint: 'Money you received back from them' },
  { value: 'Borrow', label: 'Borrow (I took)', dir: 'in', hint: 'Money you took — you owe them' },
  { value: 'Return', label: 'Return (I repaid)', dir: 'out', hint: 'Money you paid back to them' },
]

export default function HandExchange() {
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [tick, setTick] = useState(0)
  const [entry, setEntry] = useState<{ person?: string; phone?: number | string; type?: HandExchange['Type'] } | null>(null)
  const [openPerson, setOpenPerson] = useState<string | null>(null)

  const people = useMemo(() => repo.handPeople(), [tick])
  const summary = useMemo(() => repo.handSummary(), [tick])
  const refresh = () => { setEntry(null); setTick(t => t + 1) }

  return (
    <div>
      <PageHeader
        title="Hand exchange"
        subtitle="Personal money you give and take with people you know — kept entirely out of your finance records."
        action={editable && <button className="btn-primary !py-1.5" onClick={() => setEntry({})}><Plus size={15} /> New entry</button>}
      />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="They owe you" value={inr(summary.theyOwe)} tone="green" icon={<ArrowDownLeft size={18} />} />
        <StatCard label="You owe" value={inr(summary.youOwe)} tone="red" icon={<ArrowUpRight size={18} />} />
        <StatCard label="People" value={people.length} tone="blue" icon={<Handshake size={18} />} />
      </div>

      {people.length === 0 ? <EmptyState title="No hand-exchange records yet" hint={editable ? 'Use “New entry” to record giving or taking money.' : undefined} /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Person</Th><Th>Last</Th><Th right>Entries</Th><Th right>Net balance</Th>{editable && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {people.map(p => (
                  <tr key={p.name} className="hover:bg-slate-800/40">
                    <Td>
                      <button className="text-left font-medium text-brand-300 hover:underline" onClick={() => setOpenPerson(p.name)}>{p.name}</button>
                      {p.phone && <p className="text-xs text-slate-500">{fmtPhone(p.phone)}</p>}
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
                          <button title="Give" onClick={() => setEntry({ person: p.name, phone: p.phone, type: 'Give' })} className="btn-ghost !px-2 !py-1 text-xs text-rose-300 ring-1 ring-inset ring-rose-500/30"><ArrowUpRight size={13} /> Give</button>
                          <button title="Get" onClick={() => setEntry({ person: p.name, phone: p.phone, type: 'Get' })} className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"><ArrowDownLeft size={13} /> Get</button>
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
      {openPerson && <PersonModal person={openPerson} editable={editable} onClose={() => setOpenPerson(null)} onChanged={() => setTick(t => t + 1)} onAdd={(type) => { setOpenPerson(null); setEntry({ person: openPerson, type }) }} />}
    </div>
  )
}

// Record a give / get / borrow / return, for an existing or brand-new person.
function EntryModal({ seed, onClose, onSaved }: { seed: { person?: string; phone?: number | string; type?: HandExchange['Type'] }; onClose: () => void; onSaved: () => void }) {
  const known = repo.handPeople()
  const isNewDefault = !seed.person
  const [personMode, setPersonMode] = useState<'existing' | 'new'>(isNewDefault && known.length ? 'existing' : (known.length ? 'existing' : 'new'))
  const [person, setPerson] = useState(seed.person ?? (known[0]?.name ?? ''))
  const [newName, setNewName] = useState('')
  const [newPhone, setNewPhone] = useState('')
  const [type, setType] = useState<HandExchange['Type']>(seed.type ?? 'Give')
  const [amount, setAmount] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [mode, setMode] = useState('Cash')
  const [note, setNote] = useState('')
  const [busy, setBusy] = useState(false)

  const usingNew = personMode === 'new' || known.length === 0
  const finalName = (usingNew ? newName : person).trim()
  const valid = finalName.length > 0 && num(amount) > 0
  const dir = TYPES.find(t => t.value === type)?.dir ?? 'out'

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await addHandEntry({
      Date: date, Person: finalName, Person_Phone: usingNew && newPhone ? newPhone : seed.phone,
      Amount: num(amount), Direction: dir, Type: type, Mode: mode, Note: note.trim() || undefined,
    })
    onSaved()
  }

  return (
    <Modal
      title="Hand-exchange entry"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>Record</button>
      </>}
    >
      {/* Person: pick existing, or add a new one with details */}
      {known.length > 0 && !seed.person && (
        <div className="flex gap-2 text-sm">
          <button className={`btn-ghost !py-1 ${personMode === 'existing' ? 'ring-1 ring-brand-500/40 text-brand-200' : ''}`} onClick={() => setPersonMode('existing')}>Existing person</button>
          <button className={`btn-ghost !py-1 ${personMode === 'new' ? 'ring-1 ring-brand-500/40 text-brand-200' : ''}`} onClick={() => setPersonMode('new')}>New person</button>
        </div>
      )}
      {!usingNew && !seed.person && (
        <Field label="Person">
          <select className="input" value={person} onChange={e => setPerson(e.target.value)}>
            {known.map(p => <option key={p.name} value={p.name}>{p.name}</option>)}
          </select>
        </Field>
      )}
      {seed.person && <div className="rounded-xl bg-slate-800/40 p-3 text-sm text-slate-300">Person: <b className="text-hd">{seed.person}</b></div>}
      {usingNew && !seed.person && (
        <div className="grid grid-cols-2 gap-3">
          <Field label="Name"><input className="input" autoFocus value={newName} onChange={e => setNewName(e.target.value)} /></Field>
          <Field label="Phone (optional)"><input className="input" inputMode="tel" value={newPhone} onChange={e => setNewPhone(e.target.value)} /></Field>
        </div>
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

// One person's full history + quick add.
function PersonModal({ person, editable, onClose, onChanged, onAdd }: { person: string; editable: boolean; onClose: () => void; onChanged: () => void; onAdd: (type: HandExchange['Type']) => void }) {
  const [tick, setTick] = useState(0)
  const [del, setDel] = useState<HandExchange | null>(null)
  const history = useMemo(() => repo.handHistory(person), [person, tick])
  const net = history.reduce((s, e) => s + (e.Direction === 'out' ? num(e.Amount) : -num(e.Amount)), 0)

  return (
    <Modal
      title={person}
      onClose={onClose}
      footer={editable ? <>
        <button className="btn-ghost text-rose-300 ring-1 ring-inset ring-rose-500/30" onClick={() => onAdd('Give')}><ArrowUpRight size={15} /> Give</button>
        <button className="btn-ghost text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => onAdd('Get')}><ArrowDownLeft size={15} /> Get</button>
        <button className="btn-ghost" onClick={() => onAdd('Borrow')}>Borrow</button>
        <button className="btn-primary" onClick={onClose}>Close</button>
      </> : <button className="btn-primary" onClick={onClose}>Close</button>}
    >
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <div className="flex justify-between">
          <span className="text-slate-400">Net balance</span>
          {net === 0 ? <span className="text-slate-400">Settled</span>
            : <span className={net > 0 ? 'font-semibold text-emerald-400' : 'font-semibold text-rose-300'}>{inr(Math.abs(net))} · {net > 0 ? 'owes you' : 'you owe'}</span>}
        </div>
      </div>
      <div className="divide-y divide-slate-800">
        {history.map(e => (
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
              <span className={`tabular-nums font-semibold ${e.Direction === 'out' ? 'text-rose-300' : 'text-emerald-400'}`}>{e.Direction === 'out' ? '−' : '+'}{inr(num(e.Amount))}</span>
              {editable && <button className="text-slate-500 hover:text-rose-300" title="Delete" onClick={() => setDel(e)}><Trash2 size={14} /></button>}
            </div>
          </div>
        ))}
        {history.length === 0 && <p className="py-3 text-sm text-slate-500">No entries.</p>}
      </div>

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
