import { useMemo } from 'react'
import { Boxes, Building2 } from 'lucide-react'
import { repo } from '../data/repository'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

export default function Chits() {
  const invested = useMemo(() => repo.raw('Invested_Chit'), [])
  const investedTrans = useMemo(() => repo.raw('Invested_Chit_Trans'), [])

  const totalInvested = investedTrans.reduce((s: number, t: any) => s + num(t.Chit_This_Month_Amount), 0)
  const activeChits = invested.filter((c: any) => (c.Chit_Status ?? '').toLowerCase() === 'active').length

  return (
    <div>
      <PageHeader title="Chit funds" subtitle="Chits your finance has invested in with other companies." />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Invested chits" value={invested.length} tone="blue" icon={<Boxes size={18} />} />
        <StatCard label="Active" value={activeChits} tone="green" />
        <StatCard label="Contributed so far" value={inr(totalInvested)} tone="amber" />
      </div>

      {invested.length === 0 ? <EmptyState title="No invested chits" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Chit</Th><Th>Company</Th><Th>Started</Th><Th right>Total value</Th><Th right>Months</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {invested.map((c: any, i: number) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td>
                      <p className="font-medium text-slate-200">{c.Chit_Name ?? c.Chit_ID}</p>
                      <p className="text-xs text-slate-500">{c.Chit_Invested_By}</p>
                    </Td>
                    <Td className="text-slate-300"><span className="flex items-center gap-1.5"><Building2 size={14} className="text-slate-500" />{c.Chit_Invested_Company}</span></Td>
                    <Td className="text-slate-400">{fmtDate(c.Chit_Started_Date)}</Td>
                    <Td right className="text-hd">{inr(num(c.Total_Amount_Chit))}</Td>
                    <Td right className="text-slate-300">{num(c.No_Months_Completed)}/{num(c.No_Months)}</Td>
                    <Td><Badge tone={statusTone(c.Chit_Status)}>{c.Chit_Status ?? '—'}</Badge></Td>
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
