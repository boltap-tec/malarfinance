import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Search } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

const FILTERS = ['All', 'Active', 'Closed'] as const

export default function Loans() {
  const finance = useApp(s => s.finance)
  const [q, setQ] = useState('')
  const [filter, setFilter] = useState<typeof FILTERS[number]>('All')

  const { rows, totalOut, totalGiven } = useMemo(() => {
    let list = repo.loans(financeFilter(finance))
    if (filter !== 'All') list = list.filter(l => (l.Loan_Status ?? '').toLowerCase() === filter.toLowerCase())
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(l =>
      l.Loan_No?.toLowerCase().includes(s) || l.Customer_Name?.toLowerCase().includes(s) || l.Customer_STL_NO?.toLowerCase().includes(s))
    list = list.slice().sort((a, b) => new Date(b.Loan_Given_Date ?? 0).getTime() - new Date(a.Loan_Given_Date ?? 0).getTime())
    return {
      rows: list,
      totalOut: list.reduce((s2, l) => s2 + num(l.Outstand_Amount), 0),
      totalGiven: list.reduce((s2, l) => s2 + num(l.Loan_Amount), 0),
    }
  }, [finance, q, filter])

  return (
    <div>
      <PageHeader title="Loans" subtitle={`${rows.length} loans · ${inr(totalGiven)} given · ${inr(totalOut)} outstanding`} />

      <Card className="mb-4 !p-3">
        <div className="flex flex-wrap items-center gap-3">
          <div className="relative flex-1 min-w-[220px]">
            <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
            <input className="input pl-9" placeholder="Search loan no., customer, STL…" value={q} onChange={e => setQ(e.target.value)} />
          </div>
          <div className="flex gap-1 rounded-xl bg-slate-800/60 p-1">
            {FILTERS.map(fl => (
              <button key={fl} onClick={() => setFilter(fl)}
                className={`rounded-lg px-3 py-1.5 text-sm font-medium ${filter === fl ? 'bg-brand-600 text-white' : 'text-slate-300'}`}>{fl}</button>
            ))}
          </div>
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No loans found" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Loan no.</Th><Th>Customer</Th><Th>Given</Th><Th right>Amount</Th><Th>Rate</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(l => (
                  <tr key={l.Loan_No} className="hover:bg-slate-800/40">
                    <Td><Link to={`/loans/${encodeURIComponent(l.Loan_No)}`} className="font-medium text-brand-300">{l.Loan_No}</Link></Td>
                    <Td>
                      <p className="text-slate-200">{l.Customer_Name}</p>
                      <p className="text-xs text-slate-500">{l.Customer_STL_NO}</p>
                    </Td>
                    <Td className="text-slate-400">{fmtDate(l.Loan_Given_Date)}</Td>
                    <Td right className="text-white">{inr(num(l.Loan_Amount))}</Td>
                    <Td className="text-slate-300 whitespace-nowrap">
                      {l.Interest_Type === 'Per_Month' ? `₹${num(l.Interest_Per_Month_Per_Lakh)}/L·mo` : `₹${num(l.Interest_Per_day_Per_Lakh)}/L·day`}
                    </Td>
                    <Td right className="text-amber-300">{inr(num(l.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(l.Loan_Status)}>{l.Loan_Status ?? '—'}</Badge></Td>
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
