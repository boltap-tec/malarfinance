import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Boxes, Building2, Plus, Users, Coins } from 'lucide-react'
import { repo, addChit, nextChitId } from '../data/repository'
import { useApp, canEdit, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

export default function Chits() {
  const financeSel = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const finance = financeFilter(financeSel)
  const [tick, setTick] = useState(0)
  const [creating, setCreating] = useState(false)

  const chits = useMemo(() => repo.chits(finance), [finance, tick])
  const invested = useMemo(() => repo.raw('Invested_Chit'), [])
  const investedTrans = useMemo(() => repo.raw('Invested_Chit_Trans'), [])

  const run = useMemo(() => {
    let collected = 0, payoutPending = 0, open = 0
    for (const c of chits) {
      const s = repo.chitSummary(c.Chit_ID)
      collected += s.collected; payoutPending += s.payoutPending
      if ((c.Chit_Status ?? '').toLowerCase() === 'open') open++
    }
    return { collected, payoutPending, open }
  }, [chits])

  const totalInvested = investedTrans.reduce((s: number, t: any) => s + num(t.Chit_This_Month_Amount), 0)
  const activeChits = invested.filter((c: any) => (c.Chit_Status ?? '').toLowerCase() === 'active').length

  return (
    <div>
      <PageHeader
        title="Chit funds"
        subtitle="Chit funds your finance runs, plus chits you've invested in elsewhere."
        action={editable && (
          <button className="btn-primary !py-1.5" onClick={() => setCreating(true)}><Plus size={15} /> New chit</button>
        )}
      />

      {/* ── Chit funds you run ─────────────────────────────────────────────── */}
      <div className="mb-2 flex items-center gap-2">
        <Coins size={16} className="text-brand-400" />
        <h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Chit funds you run</h2>
      </div>

      <div className="mb-4 grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Chit funds" value={chits.length} tone="blue" icon={<Boxes size={18} />} />
        <StatCard label="Open" value={run.open} tone="green" />
        <StatCard label="Dues collected" value={inr(run.collected)} tone="amber" />
        <StatCard label="Payout pending" value={inr(run.payoutPending)} tone="red" />
      </div>

      {chits.length === 0 ? (
        <EmptyState title="No chit funds yet" hint={editable ? 'Use “New chit” to start one.' : undefined} />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr>
                  <Th>Chit</Th><Th>Started</Th><Th right>Pot</Th><Th right>Members</Th>
                  <Th right>Month</Th><Th right>Taken</Th><Th>Status</Th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {chits.map((c) => {
                  const members = repo.chitMembers(c.Chit_ID).length
                  return (
                    <tr key={c.Chit_ID} className="hover:bg-slate-800/40">
                      <Td>
                        <Link to={`/chits/${encodeURIComponent(c.Chit_ID)}`} className="font-medium text-brand-300 hover:underline">
                          Chit {c.Chit_Name}
                        </Link>
                        <p className="text-xs text-slate-500">{c.Finance_Name}</p>
                      </Td>
                      <Td className="text-slate-400">{fmtDate(c.Chit_From_Date)}</Td>
                      <Td right className="text-hd">{inr(num(c.Total_Amount))}</Td>
                      <Td right className="text-slate-300"><span className="inline-flex items-center gap-1"><Users size={13} className="text-slate-500" />{members}</span></Td>
                      <Td right className="text-slate-300">{num(c.No_Month_Completed)}/{num(c.Total_Month)}</Td>
                      <Td right className="text-slate-300">{num(c.Total_Member_Taken)}/{num(c.Total_Chit_Count) || num(c.No_Members)}</Td>
                      <Td><Badge tone={statusTone(c.Chit_Status)}>{c.Chit_Status ?? '—'}</Badge></Td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {/* ── Invested chit funds (chits you joined elsewhere) ───────────────── */}
      <div className="mb-2 mt-8 flex items-center gap-2">
        <Building2 size={16} className="text-slate-400" />
        <h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Invested chit funds</h2>
      </div>

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Invested chits" value={invested.length} tone="blue" icon={<Boxes size={18} />} />
        <StatCard label="Active" value={activeChits} tone="green" />
        <StatCard label="Contributed so far" value={inr(totalInvested)} tone="amber" />
      </div>

      {invested.length === 0 ? <EmptyState title="No invested chits" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Chit</Th><Th>Company</Th><Th>Started</Th><Th right>Total value</Th><Th right>Months</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {invested.map((c: any, i: number) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td>
                      <p className="font-medium text-slate-200">{c.Chit_Name ?? c.Chit_ID}</p>
                      <p className="text-xs text-slate-500">{c.Chit_Invested_By}</p>
                    </Td>
                    <Td className="text-slate-300"><span className="flex items-center gap-1.5"><Building2 size={14} className="text-slate-500" />{c.Chit_Invested_Company}</span></Td>
                    <Td className="text-slate-400">{fmtDate(c.Chit_Started_Date)}</Td>
                    <Td right className="text-hd">{inr(num(c.Total_Amount_Chit))}</Td>
                    <Td right className="text-slate-300">{num(c.No_Months_Completed)}/{num(c.No_Months)}</Td>
                    <Td><Badge tone={statusTone(c.Chit_Status)}>{c.Chit_Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {creating && (
        <CreateChitModal
          defaultFinance={financeSel !== 'ALL' ? financeSel : (repo.finances()[0]?.Finance_Name ?? '')}
          onClose={() => setCreating(false)}
          onSaved={() => { setCreating(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// ── Create a new chit fund ─────────────────────────────────────────────────
function CreateChitModal({ defaultFinance, onClose, onSaved }: { defaultFinance: string; onClose: () => void; onSaved: () => void }) {
  const finances = repo.finances()
  const [name, setName] = useState('')
  const [financeName, setFinanceName] = useState(defaultFinance)
  const [fromDate, setFromDate] = useState(new Date().toISOString().slice(0, 10))
  const [totalAmount, setTotalAmount] = useState('')
  const [totalMonth, setTotalMonth] = useState('')
  const [noMembers, setNoMembers] = useState('')
  const [pct, setPct] = useState('3')
  const [busy, setBusy] = useState(false)

  const commission = Math.round(num(pct) / 100 * num(totalAmount))
  const valid = name.trim() && financeName && num(totalAmount) > 0 && num(totalMonth) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await addChit({
      Chit_ID: nextChitId(financeName),
      Chit_Name: name.trim(),
      Chit_From_Date: fromDate,
      No_Members: num(noMembers),
      Total_Month: num(totalMonth),
      Total_Amount: num(totalAmount),
      Chit_Percentage: num(pct),
      Finance_Name: financeName,
      Chit_Status: 'Open',
    })
    onSaved()
  }

  return (
    <Modal
      title="New chit fund"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>Create chit</button>
      </>}
    >
      <Field label="Chit name"><input className="input" value={name} onChange={e => setName(e.target.value)} placeholder="e.g. A" /></Field>
      <Field label="Finance">
        <select className="input" value={financeName} onChange={e => setFinanceName(e.target.value)}>
          {finances.map(f => <option key={f.Finance_Name} value={f.Finance_Name}>{f.Finance_Name}</option>)}
        </select>
      </Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Start date"><input type="date" className="input" value={fromDate} onChange={e => setFromDate(e.target.value)} /></Field>
        <Field label="No. of members"><input type="number" className="input" value={noMembers} onChange={e => setNoMembers(e.target.value)} placeholder="25" /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Monthly pot (₹)" hint="Full auction amount"><input type="number" className="input" value={totalAmount} onChange={e => setTotalAmount(e.target.value)} placeholder="500000" /></Field>
        <Field label="Total months"><input type="number" className="input" value={totalMonth} onChange={e => setTotalMonth(e.target.value)} placeholder="20" /></Field>
      </div>
      <Field label="Commission %" hint={num(totalAmount) > 0 ? `Firm keeps ${inr(commission)} per full auction` : 'Charged on the pot'}>
        <input type="number" className="input" value={pct} onChange={e => setPct(e.target.value)} />
      </Field>
    </Modal>
  )
}
