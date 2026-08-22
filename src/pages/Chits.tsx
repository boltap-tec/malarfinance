import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Boxes, Building2, Plus } from 'lucide-react'
import { repo, addInvestedChit } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'
import type { InvestedChit } from '../data/types'

// A chit counts as completed when its status says so, or every month is paid.
function isChitCompleted(c: InvestedChit): boolean {
  if ((c.Chit_Status ?? '').toLowerCase() === 'completed') return true
  const total = Number(c.No_Months) || 0
  return total > 0 && (Number(c.No_Months_Completed) || 0) >= total
}

// One titled group (Running / Completed) of invested chits.
function InvestedSection({ title, tone, rows, empty, className }: {
  title: string; tone: string; rows: InvestedChit[]; empty?: string; className?: string
}) {
  return (
    <div className={className}>
      <div className="mb-2 flex items-center gap-2">
        <Boxes size={16} className={tone} />
        <h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">{title}</h2>
        <span className="rounded-full bg-slate-800/70 px-2 py-0.5 text-xs text-slate-400">{rows.length}</span>
      </div>
      {rows.length === 0 ? (
        <EmptyState title={empty ?? 'Nothing here.'} />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Chit</Th><Th>Company</Th><Th>Started</Th><Th right>Pot value</Th><Th right>Invested</Th><Th right>Months</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((c) => {
                  const s = repo.investedChitSummary(c.Chit_ID)
                  return (
                    <tr key={c.Chit_ID} className="hover:bg-slate-800/40">
                      <Td>
                        <Link to={`/chits/invested/${encodeURIComponent(c.Chit_ID)}`} className="font-medium text-brand-300 hover:underline">
                          {c.Chit_Name ?? c.Chit_ID}
                        </Link>
                        <p className="text-xs text-slate-500">{c.Chit_Invested_By}{c.Chit_Taken === 'Yes' ? ' · taken' : ''}</p>
                      </Td>
                      <Td className="text-slate-300"><span className="flex items-center gap-1.5"><Building2 size={14} className="text-slate-500" />{c.Chit_Invested_Company}</span></Td>
                      <Td className="text-slate-400">{fmtDate(c.Chit_Started_Date)}</Td>
                      <Td right className="text-hd">{inr(num(c.Total_Amount_Chit))}</Td>
                      <Td right className="text-emerald-400">{inr(s.invested)}</Td>
                      <Td right className="text-slate-300">{num(c.No_Months_Completed)}/{num(c.No_Months)}</Td>
                      <Td><Badge tone={statusTone(c.Chit_Status)}>{c.Chit_Status ?? '—'}</Badge></Td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </Card>
      )}
    </div>
  )
}

export default function Chits() {
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [tick, setTick] = useState(0)
  const [creating, setCreating] = useState(false)

  const invested = useMemo(() => repo.investedChits(), [tick])
  const { running, completed, contributed } = useMemo(() => {
    let contributed = 0
    const running: typeof invested = [], completed: typeof invested = []
    for (const c of invested) {
      contributed += repo.investedChitSummary(c.Chit_ID).invested
      ;(isChitCompleted(c) ? completed : running).push(c)
    }
    return { running, completed, contributed }
  }, [invested])

  return (
    <div>
      <PageHeader
        title="My Invested Chits"
        subtitle="Chits your finance has joined with other companies."
        action={editable && (
          <button className="btn-primary !py-1.5" onClick={() => setCreating(true)}><Plus size={15} /> New invested chit</button>
        )}
      />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Invested chits" value={invested.length} tone="blue" icon={<Boxes size={18} />} />
        <StatCard label="Running" value={running.length} tone="green" />
        <StatCard label="Contributed so far" value={inr(contributed)} tone="amber" />
      </div>

      {invested.length === 0 ? (
        <EmptyState title="No invested chits" hint={editable ? 'Use “New invested chit” to add one.' : undefined} />
      ) : (
        <>
          <InvestedSection title="Running" tone="text-emerald-400" rows={running} empty="No running chits." />
          {completed.length > 0 && <InvestedSection title="Completed" tone="text-slate-400" rows={completed} className="mt-8" />}
        </>
      )}

      {creating && (
        <AddInvestedChitModal
          onClose={() => setCreating(false)}
          onSaved={() => { setCreating(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// ── Add an invested chit (a chit you join at another company) ───────────────
function AddInvestedChitModal({ onClose, onSaved }: { onClose: () => void; onSaved: () => void }) {
  const [name, setName] = useState('')
  const [company, setCompany] = useState('')
  const [investedBy, setInvestedBy] = useState('')
  const [address, setAddress] = useState('')
  const [pot, setPot] = useState('')
  const [months, setMonths] = useState('')
  const [startDate, setStartDate] = useState(new Date().toISOString().slice(0, 10))
  const [busy, setBusy] = useState(false)

  const valid = name.trim() && company.trim() && num(pot) > 0 && num(months) > 0
  const chitId = `${(investedBy || 'Me').trim()}-${company.trim()}-${num(pot)}-${name.trim()}`

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await addInvestedChit({
      Chit_ID: chitId,
      Chit_Name: name.trim(),
      Chit_Invested_By: investedBy.trim() || undefined,
      Chit_Invested_Company: company.trim(),
      Chit_Invested_Company_Address: address.trim() || undefined,
      Total_Amount_Chit: num(pot),
      No_Months: num(months),
      Chit_Started_Date: startDate,
    })
    onSaved()
  }

  return (
    <Modal
      title="New invested chit"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>Add chit</button>
      </>}
    >
      <Field label="Chit name"><input className="input" value={name} onChange={e => setName(e.target.value)} placeholder="e.g. Ram1" /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Company running it"><input className="input" value={company} onChange={e => setCompany(e.target.value)} placeholder="e.g. Ramkumar_Chit" /></Field>
        <Field label="Invested by"><input className="input" value={investedBy} onChange={e => setInvestedBy(e.target.value)} placeholder="e.g. Arul" /></Field>
      </div>
      <Field label="Company address"><input className="input" value={address} onChange={e => setAddress(e.target.value)} /></Field>
      <div className="grid grid-cols-3 gap-3">
        <Field label="Pot value (₹)"><input type="number" className="input" value={pot} onChange={e => setPot(e.target.value)} placeholder="500000" /></Field>
        <Field label="Months"><input type="number" className="input" value={months} onChange={e => setMonths(e.target.value)} placeholder="20" /></Field>
        <Field label="Start date"><input type="date" className="input" value={startDate} onChange={e => setStartDate(e.target.value)} /></Field>
      </div>
    </Modal>
  )
}
