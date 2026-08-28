import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { UserPlus } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, canEdit, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState } from '../components/ui'
import { AddMemberModal } from './ChitDetail'
import { inr, phone, num } from '../lib/format'

export default function ChitMembers() {
  const financeSel = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role) && financeSel !== 'ALL'  // combined view is read-only
  const finance = financeFilter(financeSel)
  const [tick, setTick] = useState(0)
  const [adding, setAdding] = useState(false)

  const chits = useMemo(() => repo.chits(finance), [finance, tick])
  const [fund, setFund] = useState<string>('')
  const activeFund = fund || chits[0]?.Chit_ID || ''
  const members = useMemo(() => activeFund ? repo.chitMembers(activeFund) : [], [activeFund, tick])

  const shares = members.reduce((s, m) => s + num(m.Member_Percentage), 0)
  const taken = members.filter(m => m.Chit_Taken === 'Taken').length

  return (
    <div>
      <PageHeader
        title="Chit members"
        subtitle="Everyone enrolled in a chit fund you run."
        action={
          <div className="flex items-center gap-2">
            {chits.length > 0 && (
              <select className="input !w-auto !py-1.5 text-sm" value={activeFund} onChange={e => setFund(e.target.value)}>
                {chits.map(c => <option key={c.Chit_ID} value={c.Chit_ID}>Chit {c.Chit_Name}</option>)}
              </select>
            )}
            {editable && activeFund && <button className="btn-primary !py-1.5" onClick={() => setAdding(true)}><UserPlus size={15} /> Add member</button>}
          </div>
        }
      />

      {!activeFund ? <EmptyState title="No chit funds yet" hint="Create a chit fund first." /> : (
        <>
          <div className="mb-4 grid grid-cols-3 gap-3">
            <StatCard label="Members" value={members.length} tone="blue" />
            <StatCard label="Total shares" value={shares} tone="slate" />
            <StatCard label="Have taken" value={taken} tone="green" />
          </div>

          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Member</Th><Th>Phone</Th><Th right>Share</Th><Th>Chit</Th><Th right>Taken amount</Th><Th right>Payout pending</Th></tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {members.map(m => (
                    <tr key={m.Member_ID} className="hover:bg-slate-800/40">
                      <Td>
                        <Link to={`/chit/member/${encodeURIComponent(m.Member_ID)}`} className="text-brand-300 hover:underline">{m.Member_Name}</Link>
                        {m.Member_Type && m.Member_Type !== 'Member' && <p className="text-xs text-slate-500">{m.Member_Type}</p>}
                      </Td>
                      <Td className="text-slate-400">{phone(m.Member_Phone_No)}</Td>
                      <Td right className="text-slate-400">{num(m.Member_Percentage)}</Td>
                      <Td><Badge tone={m.Chit_Taken === 'Taken' ? 'green' : 'slate'}>{m.Chit_Taken === 'Taken' ? 'Taken' : 'Not taken'}</Badge></Td>
                      <Td right className="text-slate-300">{num(m.Chit_Taken_Amount) ? inr(num(m.Chit_Taken_Amount)) : '—'}</Td>
                      <Td right className="text-rose-300">{num(m.Remaining_Amount) ? inr(num(m.Remaining_Amount)) : '—'}</Td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </>
      )}

      {adding && activeFund && (
        <AddMemberModal chitId={activeFund} onClose={() => setAdding(false)} onSaved={() => { setAdding(false); setTick(t => t + 1) }} />
      )}
    </div>
  )
}
