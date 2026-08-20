import { useMemo, useState } from 'react'
import { UserCog, Plus } from 'lucide-react'
import { repo, addWorker } from '../data/repository'
import { useApp } from '../store/app'
import { navItems } from '../nav'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { phone } from '../lib/format'
import type { Worker } from '../data/types'

// Menus an MD can grant a worker (everything except the launcher & MD-only pages).
const adminOnly = ['/', '/menu', '/messages', '/workers', '/logs', '/settings']
const grantable = navItems.filter(n => !adminOnly.includes(n.to))

export default function Workers() {
  const user = useApp(s => s.user)
  const [open, setOpen] = useState(false)
  const [tick, setTick] = useState(0)
  const rows = useMemo(() => repo.workers(), [tick])

  if (user?.role !== 'md') return <EmptyState title="Only the MD can manage workers" />

  return (
    <div>
      <PageHeader
        title="Workers"
        subtitle="Create staff logins and choose exactly which menus each can use."
        action={<button className="btn-primary" onClick={() => setOpen(true)}><Plus size={16} /> New worker</button>}
      />

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-3">
        <StatCard label="Workers" value={rows.length} tone="blue" icon={<UserCog size={18} />} />
      </div>

      {rows.length === 0 ? <EmptyState title="No workers yet" hint="Create one — they sign in with their phone and password 1234." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Worker</Th><Th>Phone</Th><Th>Finance</Th><Th>Allowed menus</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((w, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-200">{w.Worker_Name}</Td>
                    <Td className="text-slate-400">{phone(w.Phone_Number)}</Td>
                    <Td className="text-slate-300">{w.Finance_Name}</Td>
                    <Td>
                      <div className="flex flex-wrap gap-1">
                        {(w.Allowed_Menus ?? []).length === 0
                          ? <span className="text-xs text-slate-500">—</span>
                          : w.Allowed_Menus.map(m => (
                              <Badge key={m} tone="slate">{grantable.find(g => g.to === m)?.label ?? m}</Badge>
                            ))}
                      </div>
                    </Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {open && <WorkerForm mdName={user.name} onClose={() => setOpen(false)} onSaved={() => { setOpen(false); setTick(t => t + 1) }} />}
    </div>
  )
}

function WorkerForm({ mdName, onClose, onSaved }: { mdName: string; onClose: () => void; onSaved: () => void }) {
  const finances = repo.finances()
  const [name, setName] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const [finance, setFinance] = useState(finances[0]?.Finance_Name ?? '')
  const [menus, setMenus] = useState<string[]>([])

  const valid = name.trim() && phoneNo.trim() && finance

  function toggle(to: string) {
    setMenus(m => m.includes(to) ? m.filter(x => x !== to) : [...m, to])
  }

  async function save() {
    const w: Worker = {
      Worker_ID: `W-${Date.now().toString(36)}`,
      Finance_Name: finance,
      Worker_Name: name.trim(),
      Phone_Number: phoneNo.trim(),
      Allowed_Menus: menus,
      Status: 'Active',
      Created_By: mdName,
    }
    await addWorker(w)
    onSaved()
  }

  return (
    <Modal
      title="New worker"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Create worker</button>
      </>}
    >
      <Field label="Worker name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Phone (their login)"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
        <Field label="Finance">
          <select className="input" value={finance} onChange={e => setFinance(e.target.value)}>
            {finances.map(f => <option key={f.Finance_Name} value={f.Finance_Name}>{f.Finance_Name}</option>)}
          </select>
        </Field>
      </div>
      <div>
        <p className="label mb-1">Allowed menus</p>
        <div className="grid grid-cols-2 gap-2">
          {grantable.map(g => (
            <label key={g.to} className={`flex cursor-pointer items-center gap-2 rounded-lg px-3 py-2 text-sm ring-1 ring-inset ${menus.includes(g.to) ? 'bg-brand-600/20 ring-brand-500/40 text-white' : 'ring-slate-800 text-slate-300 hover:bg-slate-800/50'}`}>
              <input type="checkbox" className="accent-brand-500" checked={menus.includes(g.to)} onChange={() => toggle(g.to)} />
              {g.label}
            </label>
          ))}
        </div>
        <p className="mt-2 text-xs text-slate-500">Dashboard is always available. Worker signs in with this phone and password <span className="font-semibold">1234</span>.</p>
      </div>
    </Modal>
  )
}
