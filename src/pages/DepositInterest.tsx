import { useMemo, useState } from 'react'
import { Percent } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

// Interest the finance OWES its depositors (a payable), from the Depositer_Interest schedule.
export default function DepositInterest() {
  const finance = useApp(s => s.finance)
  const [q, setQ] = useState('')

  const { rows, billed, paid, pending } = useMemo(() => {
    let list = repo.depositInterest(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter((i: any) =>
      String(i.Depositer_Name ?? '').toLowerCase().includes(s) ||
      String(i.Deposit_No ?? '').toLowerCase().includes(s) ||
      String(i.Month ?? '').toLowerCase().includes(s))
    return {
      rows: list,
      billed: list.reduce((s2: number, i: any) => s2 + num(i.Interest_Amount), 0),
      paid: list.reduce((s2: number, i: any) => s2 + num(i.Amount_Received), 0),
      pending: list.reduce((s2: number, i: any) => s2 + num(i.Interest_Pending), 0),
    }
  }, [finance, q])

  return (
    <div>
      <PageHeader title="Deposit Interest" subtitle="Interest you owe depositors — maintained like customer interest." />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Total interest" value={inr(billed)} tone="blue" icon={<Percent size={18} />} />
        <StatCard label="Paid" value={inr(paid)} tone="green" />
        <StatCard label="Pending" value={inr(pending)} tone="amber" />
      </div>

      <Card className="mb-4 !p-3">
        <input className="input" placeholder="Search depositor, DEP no., month…" value={q} onChange={e => setQ(e.target.value)} />
      </Card>

      {rows.length === 0 ? <EmptyState title="No deposit interest yet" hint="Pay interest from a depositor's page to record it." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Depositor</Th><Th>DEP no.</Th><Th>Period</Th><Th right>Interest</Th><Th right>Paid</Th><Th right>Pending</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.slice().reverse().slice(0, 300).map((i: any, k: number) => (
                  <tr key={k} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{i.Month}</Td>
                    <Td className="text-slate-200">{i.Depositer_Name}</Td>
                    <Td className="text-slate-400">{i.Deposit_No}</Td>
                    <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                    <Td right className="text-white">{inr(num(i.Interest_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                    <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                    <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
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
