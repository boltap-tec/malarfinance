import { useMemo, useState } from 'react'
import { Search, ArrowDownLeft, ArrowUpRight } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState, Badge } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

export default function Ledger() {
  const finance = useApp(s => s.finance)
  const [q, setQ] = useState('')

  const { rows, receipts, payments } = useMemo(() => {
    let list = repo.ledger(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(t =>
      [t.Description, t.Customer_Name, t.Nature_Transaction, t.STL_No, t.Loan_No, t.Ref_ID]
        .some(v => String(v ?? '').toLowerCase().includes(s)))
    list = list.slice().sort((a, b) => new Date(b.Date_Transaction ?? 0).getTime() - new Date(a.Date_Transaction ?? 0).getTime())
    return {
      rows: list.slice(0, 300),
      receipts: list.reduce((s2, t) => s2 + num(t.Receipt_Amount), 0),
      payments: list.reduce((s2, t) => s2 + num(t.Payment_Amount), 0),
    }
  }, [finance, q])

  return (
    <div>
      <PageHeader title="Transaction ledger" subtitle="Every receipt and payment across the business." />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Total receipts" value={inr(receipts)} tone="green" icon={<ArrowDownLeft size={18} />} />
        <StatCard label="Total payments" value={inr(payments)} tone="red" icon={<ArrowUpRight size={18} />} />
        <StatCard label="Net" value={inr(receipts - payments)} tone="blue" />
      </div>

      <Card className="mb-4 !p-3">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input pl-9" placeholder="Search ledger…" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No transactions" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Date</Th><Th>Nature</Th><Th>Description</Th><Th right>Receipt</Th><Th right>Payment</Th><Th>Mode</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((t, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="whitespace-nowrap text-slate-400">{fmtDate(t.Date_Transaction)}</Td>
                    <Td><Badge tone="slate">{t.Nature_Transaction ?? '—'}</Badge></Td>
                    <Td>
                      <p className="text-slate-200">{t.Description ?? '—'}</p>
                      <p className="text-xs text-slate-500">{t.Customer_Name ?? t.STL_No ?? ''}</p>
                    </Td>
                    <Td right className="text-emerald-400">{num(t.Receipt_Amount) ? inr(num(t.Receipt_Amount)) : ''}</Td>
                    <Td right className="text-rose-400">{num(t.Payment_Amount) ? inr(num(t.Payment_Amount)) : ''}</Td>
                    <Td className="text-slate-400">{t.Payment_Type ?? '—'}</Td>
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
