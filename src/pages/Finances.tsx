import { useState } from 'react'
import { Plus, Building2, Check } from 'lucide-react'
import { repo, addFinance } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { useCreateParam } from '../lib/useCreateParam'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { inr, fmtDate, phone as fmtPhone, num } from '../lib/format'
import type { Finance } from '../data/types'

const empty = { Finance_Name: '', MD_Name: '', Phone_Number: '', Initial_Capital_Partner: '', No_Partners: '', Date_Opened: new Date().toISOString().slice(0, 10) }

export default function Finances() {
  const role = useApp(s => s.user?.role)
  const editor = canEdit(role) && role === 'md' // only the MD manages finances
  const [open, setOpen] = useCreateParam()
  const [tick, setTick] = useState(0)
  const [form, setForm] = useState({ ...empty })
  const [err, setErr] = useState<string | null>(null)

  const finances = repo.finances()
  const totalCapital = finances.reduce((s, f) => s + num(f.Initial_Capital_Partner), 0)

  const set = (k: keyof typeof empty, v: string) => setForm(p => ({ ...p, [k]: v }))

  async function save() {
    const name = form.Finance_Name.trim()
    if (!name) { setErr('Finance name is required.'); return }
    if (finances.some(f => f.Finance_Name.toLowerCase() === name.toLowerCase())) { setErr('A finance with this name already exists.'); return }
    const fin: Finance = {
      Finance_Name: name,
      MD_Name: form.MD_Name.trim() || undefined,
      Phone_Number: form.Phone_Number.trim() || undefined,
      Initial_Capital_Partner: num(form.Initial_Capital_Partner),
      No_Partners: num(form.No_Partners),
      Date_Opened: form.Date_Opened || undefined,
    }
    await addFinance(fin)
    setForm({ ...empty }); setErr(null); setOpen(false); setTick(t => t + 1)
  }

  return (
    <div>
      <PageHeader
        title="Finances"
        subtitle="The finance companies you run."
        action={editor &&
          <button className="btn-primary" onClick={() => { setForm({ ...empty }); setErr(null); setOpen(true) }}>
            <Plus size={16} /> New finance
          </button>}
      />

      <div className="mb-4 grid grid-cols-2 gap-3 lg:grid-cols-3" data-tick={tick}>
        <StatCard label="Finances" value={finances.length} tone="blue" icon={<Building2 size={18} />} />
        <StatCard label="Total start capital" value={inr(totalCapital)} tone="green" />
        <StatCard label="Partners" value={repo.partners().length} tone="amber" />
      </div>

      {finances.length === 0 ? <EmptyState title="No finances yet" hint={editor ? 'Add your first finance company.' : undefined} /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Finance</Th><Th>MD</Th><Th>Phone</Th><Th>Opened</Th><Th right>Start capital</Th><Th right>Partners</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {finances.map(f => (
                  <tr key={f.Finance_Name} className="hover:bg-slate-800/40">
                    <Td><span className="flex items-center gap-2 font-medium text-hd"><Building2 size={15} className="text-slate-500" />{f.Finance_Name}</span></Td>
                    <Td className="text-slate-300">{f.MD_Name ?? '—'}</Td>
                    <Td className="text-slate-400">{fmtPhone(f.Phone_Number)}</Td>
                    <Td className="text-slate-400">{fmtDate(f.Date_Opened)}</Td>
                    <Td right className="text-hd">{inr(num(f.Initial_Capital_Partner))}</Td>
                    <Td right><Badge tone="slate">{num(f.No_Partners)}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {open && editor && (
        <Modal
          title="New finance"
          onClose={() => setOpen(false)}
          footer={<>
            <button className="btn-ghost" onClick={() => setOpen(false)}>Cancel</button>
            <button className="btn-primary" onClick={save}><Check size={16} /> Save finance</button>
          </>}
        >
          <Field label="Finance name *"><input className="input" value={form.Finance_Name} onChange={e => { set('Finance_Name', e.target.value); setErr(null) }} placeholder="e.g. Malar Finance" /></Field>
          <div className="grid grid-cols-2 gap-3">
            <Field label="MD / owner name"><input className="input" value={form.MD_Name} onChange={e => set('MD_Name', e.target.value)} placeholder="e.g. Malarvizhi" /></Field>
            <Field label="Phone number" hint="Used as the MD login for this finance">
              <input className="input" inputMode="tel" value={form.Phone_Number} onChange={e => set('Phone_Number', e.target.value)} placeholder="e.g. 9626262427" />
            </Field>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <Field label="Start capital (₹)"><input className="input" inputMode="numeric" value={form.Initial_Capital_Partner} onChange={e => set('Initial_Capital_Partner', e.target.value)} placeholder="e.g. 300000" /></Field>
            <Field label="No. of partners"><input className="input" inputMode="numeric" value={form.No_Partners} onChange={e => set('No_Partners', e.target.value)} placeholder="e.g. 1" /></Field>
          </div>
          <Field label="Date opened"><input type="date" className="input" value={form.Date_Opened} onChange={e => set('Date_Opened', e.target.value)} /></Field>
          {err && <p className="rounded-lg bg-rose-500/10 px-3 py-2 text-sm text-rose-300 ring-1 ring-rose-500/30">{err}</p>}
        </Modal>
      )}
    </div>
  )
}
