import { useMemo } from 'react'
import { PiggyBank } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, phone, num } from '../lib/format'

export default function Deposits() {
  const finance = useApp(s => s.finance)
  const { rows, total, outstanding } = useMemo(() => {
    const list = repo.deposits(financeFilter(finance))
    return {
      rows: list,
      total: list.reduce((s, d) => s + num(d.Deposit_Amount), 0),
      outstanding: list.reduce((s, d) => s + num(d.Outstand_Amount), 0),
    }
  }, [finance])

  return (
    <div>
      <PageHeader title="Deposits" subtitle="Money taken from depositors — your interest-paying liabilities." />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Depositors" value={rows.length} tone="blue" icon={<PiggyBank size={18} />} />
        <StatCard label="Total deposited" value={inr(total)} tone="slate" />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
      </div>

      {rows.length === 0 ? <EmptyState title="No deposits" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Deposit no.</Th><Th>Depositor</Th><Th>Phone</Th><Th right>Amount</Th><Th>Rate/L·mo</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((d, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{d.Deposit_No}</Td>
                    <Td className="text-slate-200">{d.Depositer_Name}</Td>
                    <Td className="text-slate-400">{phone(d.Depositer_Phone_No)}</Td>
                    <Td right className="text-white">{inr(num(d.Deposit_Amount))}</Td>
                    <Td className="text-slate-300">₹{num(d.Interest_Per_Month_Per_Lakh)}</Td>
                    <Td right className="text-rose-300">{inr(num(d.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(d.Deposit_Status)}>{d.Deposit_Status ?? '—'}</Badge></Td>
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
