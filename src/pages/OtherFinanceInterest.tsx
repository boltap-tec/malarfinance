import { useMemo, useState } from 'react'
import { ReceiptText } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

// Interest the finance has PAID to other finances it borrowed from
// (recorded in the ledger as Other_Finance_Interest payments).
export default function OtherFinanceInterest() {
  const finance = useApp(s => s.finance)
  const [q, setQ] = useState('')

  const { rows, total } = useMemo(() => {
    let list = repo.otherFinanceInterest(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(t =>
      String(t.Customer_Name ?? '').toLowerCase().includes(s) ||
      String(t.Loan_No ?? '').toLowerCase().includes(s) ||
      String(t.Description ?? '').toLowerCase().includes(s))
    list = list.slice().sort((a, b) => new Date(b.Date_Transaction ?? 0).getTime() - new Date(a.Date_Transaction ?? 0).getTime())
    return { rows: list, total: list.reduce((s2, t) => s2 + num(t.Payment_Amount) + num(t.Interest_Amount), 0) }
  }, [finance, q])

  const totalPaid = rows.reduce((s, t) => s + num(t.Payment_Amount), 0)

  return (
    <div>
      <PageHeader title="Other Finance Interest" subtitle="Interest you have paid to the finances you borrowed from." />

      <div className="mb-4 grid grid-cols-2 gap-3">
        <StatCard label="Interest paid" value={inr(totalPaid)} tone="red" icon={<ReceiptText size={18} />} />
        <StatCard label="Entries" value={rows.length} tone="slate" />
      </div>

      <Card className="mb-4 !p-3">
        <input className="input" placeholder="Search finance, FIN no., description…" value={q} onChange={e => setQ(e.target.value)} />
      </Card>

      {rows.length === 0 ? <EmptyState title="No other-finance interest yet" hint="Pay interest from an other-finance page to record it." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Date</Th><Th>Finance</Th><Th>FIN no.</Th><Th>Description</Th><Th right>Interest paid</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.slice(0, 300).map((t, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-400">{fmtDate(t.Date_Transaction)}</Td>
                    <Td className="text-slate-200">{t.Customer_Name ?? '—'}</Td>
                    <Td className="text-slate-400">{t.Loan_No ?? '—'}</Td>
                    <Td className="text-slate-400">{t.Description ?? '—'}</Td>
                    <Td right className="text-rose-300">{inr(num(t.Payment_Amount))}</Td>
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
