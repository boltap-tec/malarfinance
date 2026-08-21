import { useMemo, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Search, Plus, Landmark } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState } from '../components/ui'
import { inr, phone, num } from '../lib/format'

export default function OtherFinances() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const navigate = useNavigate()
  const [q, setQ] = useState('')

  const { rows, borrowed, outstanding } = useMemo(() => {
    let list = repo.otherFinances(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(l => l.name.toLowerCase().includes(s) || l.code.toLowerCase().includes(s) || String(l.phone ?? '').includes(s))
    list = list.slice().sort((a, b) => b.out - a.out)
    return {
      rows: list,
      borrowed: list.reduce((s2, l) => s2 + l.borrowed, 0),
      outstanding: list.reduce((s2, l) => s2 + l.out, 0),
    }
  }, [finance, q])

  return (
    <div>
      <PageHeader
        title="Other Finances"
        subtitle="Finance houses you borrow money from."
        action={canEdit(role) &&
          <button className="btn-primary" onClick={() => navigate('/other-finance?new=1')} disabled={finance === 'ALL'}>
            <Plus size={16} /> Borrow
          </button>}
      />

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-3">
        <StatCard label="Lenders" value={rows.length} tone="blue" icon={<Landmark size={18} />} />
        <StatCard label="Total borrowed" value={inr(borrowed)} tone="slate" />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
      </div>

      <Card className="mb-4 !p-3">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input pl-9" placeholder="Search finance, phone, FIN no.…" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </Card>

      {finance === 'ALL' && <p className="mb-3 text-xs text-amber-300/80">Pick a single finance to borrow.</p>}

      {rows.length === 0 ? <EmptyState title="No other finances" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Finance</Th><Th>FIN no.</Th><Th>Phone</Th><Th right>Loans</Th><Th right>Borrowed</Th><Th right>Outstanding</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((l, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td><Link to={`/other-finance/${encodeURIComponent(l.code)}`} className="font-medium text-brand-300">{l.name}</Link><p className="text-xs text-slate-500">{l.finance}</p></Td>
                    <Td className="text-slate-400">{l.code}</Td>
                    <Td className="text-slate-400">{phone(l.phone)}</Td>
                    <Td right className="text-slate-300">{l.count}</Td>
                    <Td right className="text-hd">{inr(l.borrowed)}</Td>
                    <Td right className={num(l.out) > 0 ? 'font-semibold text-rose-300' : 'text-slate-400'}>{inr(l.out)}</Td>
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
