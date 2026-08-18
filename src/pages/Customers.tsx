import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Search } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, phone, num } from '../lib/format'

export default function Customers() {
  const finance = useApp(s => s.finance)
  const [q, setQ] = useState('')

  const rows = useMemo(() => {
    const list = repo.customers(financeFilter(finance))
    const s = q.trim().toLowerCase()
    return list.filter(c =>
      !s || c.Customer_Name?.toLowerCase().includes(s) || c.Customer_STL_NO?.toLowerCase().includes(s) ||
      String(c.Customer_Phone_No ?? '').includes(s),
    )
  }, [finance, q])

  return (
    <div>
      <PageHeader title="Customers" subtitle={`${rows.length} borrowers`} />

      <Card className="mb-4 !p-3">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input pl-9" placeholder="Search by name, STL no. or phone…" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No customers found" hint="Try a different search." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Customer</Th><Th>STL No.</Th><Th>Phone</Th><Th right>Outstanding loan</Th><Th right>Interest due</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(c => (
                  <tr key={c.Customer_STL_NO} className="hover:bg-slate-800/40">
                    <Td>
                      <Link to={`/customers/${encodeURIComponent(c.Customer_STL_NO)}`} className="font-medium text-brand-300 hover:text-brand-200">
                        {c.Customer_Name}
                      </Link>
                      <p className="text-xs text-slate-500">{c.Finance_Name}</p>
                    </Td>
                    <Td className="text-slate-300">{c.Customer_STL_NO}</Td>
                    <Td className="text-slate-400">{phone(c.Customer_Phone_No)}</Td>
                    <Td right className="font-semibold text-white">{inr(num(c.Outstand_Loan))}</Td>
                    <Td right className={num(c.Outstanding_Interest) > 0 ? 'font-semibold text-amber-400' : 'text-slate-400'}>{inr(num(c.Outstanding_Interest))}</Td>
                    <Td><Badge tone={statusTone(c.Status)}>{c.Status ?? '—'}</Badge></Td>
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
