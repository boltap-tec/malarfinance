import { Fragment, useMemo, useState } from 'react'
import { Percent, IndianRupee } from 'lucide-react'
import { repo, payDepositInterest } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import InterestPayModal from '../components/InterestPayModal'
import { inr, fmtDate, num, monthKey } from '../lib/format'

// Interest the finance OWES its depositors (a payable), from the Depositer_Interest schedule.
export default function DepositInterest() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [q, setQ] = useState('')
  const [tick, setTick] = useState(0)
  const [pay, setPay] = useState<any | null>(null)

  const { rows, monthTotals, billed, paid, pending } = useMemo(() => {
    let list = repo.depositInterest(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter((i: any) =>
      String(i.Depositer_Name ?? '').toLowerCase().includes(s) ||
      String(i.Deposit_No ?? '').toLowerCase().includes(s) ||
      String(i.Month ?? '').toLowerCase().includes(s))
    list = list.slice().sort((a: any, b: any) => monthKey(b.Month) - monthKey(a.Month) || num(b.Interest_Pending) - num(a.Interest_Pending))
    const monthTotals: Record<string, { interest: number; pending: number }> = {}
    for (const r of list) {
      const m = r.Month ?? '—'
      const t = monthTotals[m] ?? (monthTotals[m] = { interest: 0, pending: 0 })
      t.interest += num(r.Interest_Amount); t.pending += num(r.Interest_Pending)
    }
    return { monthTotals,
      rows: list,
      billed: list.reduce((s2: number, i: any) => s2 + num(i.Interest_Amount), 0),
      paid: list.reduce((s2: number, i: any) => s2 + num(i.Amount_Received), 0),
      pending: list.reduce((s2: number, i: any) => s2 + num(i.Interest_Pending), 0),
    }
  }, [finance, q, tick])

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
                <tr><Th>Depositor</Th><Th>DEP no.</Th><Th>Period</Th><Th right>Interest</Th><Th right>Paid</Th><Th right>Pending</Th><Th>Status</Th>{editable && <Th>Pay</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.slice(0, 300).map((i: any, k: number, arr: any[]) => (
                  <Fragment key={k}>
                    {(k === 0 || arr[k - 1].Month !== i.Month) && (
                      <tr className="bg-slate-900/80"><td colSpan={editable ? 8 : 7} className="px-3 py-1.5">
                        <div className="flex flex-wrap items-center justify-between gap-2">
                          <span className="text-xs font-semibold uppercase tracking-wide text-brand-300">{i.Month}</span>
                          <span className="text-xs text-slate-400">Interest <b className="text-white">{inr(monthTotals[i.Month ?? '—']?.interest ?? 0)}</b> · Pending <b className="text-amber-300">{inr(monthTotals[i.Month ?? '—']?.pending ?? 0)}</b></span>
                        </div>
                      </td></tr>
                    )}
                    <tr className="hover:bg-slate-800/40">
                      <Td className="text-slate-200">{i.Depositer_Name}</Td>
                      <Td className="text-slate-400">{i.Deposit_No}</Td>
                      <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                      <Td right className="text-white">{inr(num(i.Interest_Amount))}</Td>
                      <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                      <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                      <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                      {editable && (
                        <Td>
                          {num(i.Interest_Pending) > 0
                            ? <button className="btn-ghost !px-2.5 !py-1 text-xs text-amber-300 ring-1 ring-inset ring-amber-500/30"
                                onClick={() => setPay(i)}><IndianRupee size={13} /> Pay</button>
                            : <span className="text-xs text-slate-600">—</span>}
                        </Td>
                      )}
                    </tr>
                  </Fragment>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {pay && (
        <InterestPayModal
          title="Pay deposit interest"
          name={pay.Depositer_Name}
          code={pay.Deposit_No}
          month={pay.Month}
          pending={num(pay.Interest_Pending)}
          onPay={(amount, date, payType) => payDepositInterest(pay.ID, amount, date, payType)}
          onClose={() => setPay(null)}
          onSaved={() => { setPay(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}
