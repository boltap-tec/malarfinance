import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Boxes, Users, Plus } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, canEdit, financeFilter } from '../store/app'
import { useCreateParam } from '../lib/useCreateParam'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { CreateChitModal } from './ChitDetail'
import { inr, fmtDate, num } from '../lib/format'

export default function ChitFunds() {
  const financeSel = useApp(s => s.finance)
  const viewOnly = financeSel === 'ALL'  // combined view is read-only
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role) && !viewOnly
  const finance = financeFilter(financeSel)
  const [tick, setTick] = useState(0)
  const [creating, setCreating] = useCreateParam()

  const chits = useMemo(() => repo.chits(finance), [finance, tick])
  const totals = useMemo(() => {
    let collected = 0, payoutPending = 0, open = 0
    for (const c of chits) {
      const s = repo.chitSummary(c.Chit_ID)
      collected += s.collected; payoutPending += s.payoutPending
      if ((c.Chit_Status ?? '').toLowerCase() === 'open') open++
    }
    return { collected, payoutPending, open }
  }, [chits])

  return (
    <div>
      <PageHeader
        title="Chit funds"
        subtitle="Chit funds your finance runs — open a fund to manage members, auctions and dues."
        action={editable && <button className="btn-primary !py-1.5" onClick={() => setCreating(true)}><Plus size={15} /> New chit</button>}
      />

      {canEdit(role) && viewOnly && <p className="mb-4 text-xs text-amber-300/80">Viewing all finances (read-only). Pick a single finance in the switcher to run chit transactions.</p>}

      <div className="mb-4 grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Chit funds" value={chits.length} tone="blue" icon={<Boxes size={18} />} />
        <StatCard label="Open" value={totals.open} tone="green" />
        <StatCard label="Dues collected" value={inr(totals.collected)} tone="amber" />
        <StatCard label="Payout pending" value={inr(totals.payoutPending)} tone="red" />
      </div>

      {chits.length === 0 ? (
        <EmptyState title="No chit funds yet" hint={editable ? 'Use “New chit” to start one.' : undefined} />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Chit</Th><Th>Started</Th><Th right>Pot</Th><Th right>Members</Th><Th right>Month</Th><Th right>Taken</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {chits.map((c) => {
                  const members = repo.chitMembers(c.Chit_ID).length
                  return (
                    <tr key={c.Chit_ID} className="hover:bg-slate-800/40">
                      <Td>
                        <Link to={`/chit/${encodeURIComponent(c.Chit_ID)}`} className="font-medium text-brand-300 hover:underline">Chit {c.Chit_Name}</Link>
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
