import { useMemo, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Search, Plus, Users2, HandCoins, Percent } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, phone, num, balanceStatus } from '../lib/format'

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
    // Active first (a depositor with money still out), then by outstanding.
    list = list.slice().sort((a, b) =>
      (Number(b.out > 0) - Number(a.out > 0)) || (b.out - a.out),
    )
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

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-3">
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
                <tr><Th sticky>Depositor</Th><Th>DEP no.</Th><Th>Phone</Th><Th right>Deposits</Th><Th right>Total</Th><Th right>Outstanding</Th><Th>Status</Th>{canEdit(role) && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((d, i) => {
                  const intPending = repo.depositInterestPending(d.code)
                  return (
                  <tr key={i} className="group hover:bg-slate-800/40">
                    <Td sticky><Link to={`/deposits/${encodeURIComponent(d.code)}`} className="font-medium text-brand-300">{d.name}</Link><p className="text-xs text-slate-500">{d.finance}</p></Td>
                    <Td className="text-slate-400">{d.code}</Td>
                    <Td className="text-slate-400">{phone(d.phone)}</Td>
                    <Td right className="text-slate-300">{d.count}</Td>
                    <Td right className="text-hd">{inr(d.deposited)}</Td>
                    <Td right className={num(d.out) > 0 ? 'font-semibold text-rose-300' : 'text-slate-400'}>{inr(d.out)}</Td>
                    <Td><Badge tone={statusTone(balanceStatus(d.out))}>{balanceStatus(d.out)}</Badge></Td>
                    {canEdit(role) && (
                      <Td>
                        <div className="flex gap-1.5">
                          <button title="Add deposit" onClick={() => { setFinance(d.finance); navigate(`/deposits?new=1&code=${encodeURIComponent(d.code)}`) }} className="btn-ghost !px-2 !py-1 text-xs text-brand-300 ring-1 ring-inset ring-brand-500/30"><Plus size={13} /></button>
                          {num(d.out) > 0 && <Link title="Repay" to={`/deposits/${encodeURIComponent(d.code)}?do=repay`} className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"><HandCoins size={13} /></Link>}
                          {intPending > 0 && <Link title="Pay interest" to={`/deposits/${encodeURIComponent(d.code)}?do=interest`} className="btn-ghost !px-2 !py-1 text-xs text-amber-300 ring-1 ring-inset ring-amber-500/30"><Percent size={13} /></Link>}
                        </div>
                      </Td>
                    )}
                  </tr>
                )})}
              </tbody>
            </table>
          </div>
        </Card>
      )}
    </div>
  )
}
