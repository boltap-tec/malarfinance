import { useMemo, useState } from 'react'
import { Percent, IndianRupee } from 'lucide-react'
import { repo, payCustomerInterest } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import InterestPayModal from '../components/InterestPayModal'
import { inr, fmtDate, num, monthKey } from '../lib/format'

// Customer loan interest details, with a per-line "pay interest" action.
export default function CustomerInterest() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [q, setQ] = useState('')
  const [tick, setTick] = useState(0)
  const [pay, setPay] = useState<any | null>(null)

  const { rows, billed, paid, pending } = useMemo(() => {
    let list = repo.interest(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(i =>
      String(i.Customer_Name ?? '').toLowerCase().includes(s) ||
      String(i.Loan_No ?? '').toLowerCase().includes(s) ||
      String(i.Month ?? '').toLowerCase().includes(s))
    list = list.slice().sort((a, b) => monthKey(b.Month) - monthKey(a.Month) || num(b.Interest_Pending) - num(a.Interest_Pending))
    return {
      rows: list,
      billed: list.reduce((s2, i) => s2 + num(i.Interest_Amount), 0),
      paid: list.reduce((s2, i) => s2 + num(i.Amount_Received), 0),
      pending: list.reduce((s2, i) => s2 + num(i.Interest_Pending), 0),
    }
  }, [finance, q, tick])

  return (
    <div>
      <PageHeader title="Customer Interest" subtitle="Interest billed on customer loans — collect pending interest per line." />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Total interest" value={inr(billed)} tone="blue" icon={<Percent size={18} />} />
        <StatCard label="Collected" value={inr(paid)} tone="green" />
        <StatCard label="Pending" value={inr(pending)} tone="amber" />
      </div>

      <Card className="mb-4 !p-3">
        <input className="input" placeholder="Search customer, loan no., month…" value={q} onChange={e => setQ(e.target.value)} />
      </Card>

      {rows.length === 0 ? <EmptyState title="No customer interest yet" hint="Run Interest posting to generate lines." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Customer</Th><Th>Loan</Th><Th>Period</Th><Th right>Interest</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th>{editable && <Th>Collect</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.slice(0, 300).map((i, k) => (
                  <tr key={k} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{i.Month}</Td>
                    <Td className="text-slate-200">{i.Customer_Name}</Td>
                    <Td className="text-slate-400">{i.Loan_No}</Td>
                    <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                    <Td right className="text-white">{inr(num(i.Interest_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                    <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                    <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                    {editable && (
                      <Td>
                        {num(i.Interest_Pending) > 0
                          ? <button className="btn-ghost !px-2.5 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"
                              onClick={() => setPay(i)}><IndianRupee size={13} /> Pay</button>
                          : <span className="text-xs text-slate-600">—</span>}
                      </Td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {pay && (
        <InterestPayModal
          title="Collect customer interest"
          name={pay.Customer_Name}
          code={pay.Loan_No}
          month={pay.Month}
          pending={num(pay.Interest_Pending)}
          onPay={(amount, date, payType) => payCustomerInterest(pay.ID, amount, date, payType)}
          onClose={() => setPay(null)}
          onSaved={() => { setPay(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}
