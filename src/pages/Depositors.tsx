import { useMemo, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Search, Plus, Users2 } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState } from '../components/ui'
import { inr, phone, num } from '../lib/format'

export default function Depositors() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const setFinance = useApp(s => s.setFinance)
  const navigate = useNavigate()
  const [q, setQ] = useState('')

  const { rows, deposited, outstanding } = useMemo(() => {
    let list = repo.depositors(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(d => d.name.toLowerCase().includes(s) || d.code.toLowerCase().includes(s) || String(d.phone ?? '').includes(s))
    list = list.slice().sort((a, b) => b.out - a.out)
    return {
      rows: list,
      deposited: list.reduce((s2, d) => s2 + d.deposited, 0),
      outstanding: list.reduce((s2, d) => s2 + d.out, 0),
    }
  }, [finance, q])

  return (
    <div>
      <PageHeader
        title="Depositors"
        subtitle="People who have deposited money with you."
        action={canEdit(role) &&
          <button className="btn-primary" onClick={() => navigate('/deposits?new=1')} disabled={finance === 'ALL'}>
            <Plus size={16} /> New deposit
          </button>}
      />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Depositors" value={rows.length} tone="blue" icon={<Users2 size={18} />} />
        <StatCard label="Total deposited" value={inr(deposited)} tone="slate" />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
      </div>

      <Card className="mb-4 !p-3">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input pl-9" placeholder="Search depositor, phone, DEP no.…" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </Card>

      {finance === 'ALL' && <p className="mb-3 text-xs text-amber-300/80">Pick a single finance to add a deposit.</p>}

      {rows.length === 0 ? <EmptyState title="No depositors" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Depositor</Th><Th>DEP no.</Th><Th>Phone</Th><Th right>Deposits</Th><Th right>Total</Th><Th right>Outstanding</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((d, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td><Link to={`/deposits/${encodeURIComponent(d.code)}`} className="font-medium text-brand-300">{d.name}</Link><p className="text-xs text-slate-500">{d.finance}</p></Td>
                    <Td className="text-slate-400">{d.code}</Td>
                    <Td className="text-slate-400">{phone(d.phone)}</Td>
                    <Td right className="text-slate-300">{d.count}</Td>
                    <Td right className="text-white">{inr(d.deposited)}</Td>
                    <Td right className={num(d.out) > 0 ? 'font-semibold text-rose-300' : 'text-slate-400'}>{inr(d.out)}</Td>
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
