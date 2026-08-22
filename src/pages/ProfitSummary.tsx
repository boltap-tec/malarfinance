import { useMemo } from 'react'
import { TrendingUp, Wallet, Clock } from 'lucide-react'
import { repo, EXPENSE_NATURE, OTHER_INCOME_NATURE } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState } from '../components/ui'
import { inr, num, monthKey } from '../lib/format'

interface MonthRow {
  month: string           // "MM-YYYY"
  cust: number; dep: number; other: number; income: number; expense: number
  unreceived: number
}

const MONTHS = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
const monthLabel = (m: string) => { const [mm, yy] = m.split('-'); return `${MONTHS[Number(mm)] ?? mm} ${yy}` }
const profitOf = (r: MonthRow) => r.cust - r.dep - r.other + r.income - r.expense
const ledgerMonth = (d?: string) => { if (!d) return ''; const [y, m] = String(d).split('-'); return m && y ? `${m}-${y}` : '' }

export default function ProfitSummary() {
  const finance = useApp(s => s.finance)
  const f = financeFilter(finance)

  const { years, totals } = useMemo(() => {
    const map = new Map<string, MonthRow>()
    const get = (m: string) => { let r = map.get(m); if (!r) { r = { month: m, cust: 0, dep: 0, other: 0, income: 0, expense: 0, unreceived: 0 }; map.set(m, r) } return r }

    for (const i of repo.interest(f)) if (i.Month) { const r = get(i.Month); r.cust += num(i.Interest_Amount); r.unreceived += num(i.Interest_Pending) }
    for (const i of repo.depositInterest(f)) if (i.Month) get(i.Month).dep += num(i.Interest_Amount)
    for (const i of repo.otherFinanceInterest(f)) if (i.Month) get(i.Month).other += num(i.Interest_Amount)
    for (const t of repo.ledger(f)) {
      const m = ledgerMonth(t.Date_Transaction); if (!m) continue
      if (t.Nature_Transaction === OTHER_INCOME_NATURE) get(m).income += num(t.Receipt_Amount)
      if (t.Nature_Transaction === EXPENSE_NATURE) get(m).expense += num(t.Payment_Amount)
    }

    const rows = [...map.values()].sort((a, b) => monthKey(b.month) - monthKey(a.month))
    const byYear = new Map<string, MonthRow[]>()
    for (const r of rows) { const y = r.month.split('-')[1] ?? '—'; const arr = byYear.get(y) ?? []; arr.push(r); byYear.set(y, arr) }
    const years = [...byYear.entries()].sort((a, b) => Number(b[0]) - Number(a[0]))

    const totals = rows.reduce((s, r) => ({
      profit: s.profit + profitOf(r), unreceived: s.unreceived + r.unreceived,
    }), { profit: 0, unreceived: 0 })
    return { years, totals }
  }, [f])

  return (
    <div>
      <PageHeader
        title="Finance profit"
        subtitle={`Profit by month & year${finance === 'ALL' ? ' · all finances' : ` · ${finance}`}. Interest earned − interest paid + other income − expenses.`}
      />

      <div className="mb-4 grid grid-cols-1 gap-3 sm:grid-cols-3">
        <StatCard label="Total profit" value={inr(totals.profit)} tone="blue" icon={<TrendingUp size={18} />} />
        <StatCard label="Unreceived interest" value={inr(totals.unreceived)} tone="amber" icon={<Clock size={18} />} sub="customer interest still pending" />
        <StatCard label="Profit at present" value={inr(totals.profit - totals.unreceived)} tone="green" icon={<Wallet size={18} />} sub="realised after unreceived" />
      </div>

      {years.length === 0 ? <EmptyState title="No profit data yet" hint="Post interest and record income/expense to see the summary." /> : (
        <div className="space-y-5">
          {years.map(([year, rows]) => {
            const yt = rows.reduce((s, r) => ({
              cust: s.cust + r.cust, dep: s.dep + r.dep, other: s.other + r.other,
              income: s.income + r.income, expense: s.expense + r.expense,
              profit: s.profit + profitOf(r), unreceived: s.unreceived + r.unreceived,
            }), { cust: 0, dep: 0, other: 0, income: 0, expense: 0, profit: 0, unreceived: 0 })
            return (
              <div key={year}>
                <div className="mb-2 flex items-center justify-between">
                  <h2 className="text-sm font-semibold uppercase tracking-wide text-brand-300">{year}</h2>
                  <span className="text-sm text-slate-400">Profit <b className="text-hd">{inr(yt.profit)}</b> · At present <b className="text-emerald-300">{inr(yt.profit - yt.unreceived)}</b></span>
                </div>
                <Card className="!p-0 overflow-hidden">
                  <div className="overflow-x-auto">
                    <table className="w-full">
                      <thead className="border-b border-slate-800 bg-slate-900/60">
                        <tr>
                          <Th>Month</Th><Th right>Cust. int</Th><Th right>Dep. int</Th><Th right>Other fin.</Th>
                          <Th right>Other income</Th><Th right>Expense</Th><Th right>Profit</Th>
                          <Th right>Unreceived</Th><Th right>At present</Th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-800">
                        {rows.map(r => {
                          const p = profitOf(r)
                          return (
                            <tr key={r.month} className="hover:bg-slate-800/40">
                              <Td className="font-medium text-slate-200">{monthLabel(r.month)}</Td>
                              <Td right className="text-emerald-400">{inr(r.cust)}</Td>
                              <Td right className="text-rose-300">{r.dep ? `−${inr(r.dep)}` : '—'}</Td>
                              <Td right className="text-rose-300">{r.other ? `−${inr(r.other)}` : '—'}</Td>
                              <Td right className="text-emerald-400">{r.income ? inr(r.income) : '—'}</Td>
                              <Td right className="text-rose-300">{r.expense ? `−${inr(r.expense)}` : '—'}</Td>
                              <Td right className={p >= 0 ? 'font-semibold text-hd' : 'font-semibold text-rose-300'}>{inr(p)}</Td>
                              <Td right className="text-amber-400">{r.unreceived ? inr(r.unreceived) : '—'}</Td>
                              <Td right className="font-medium text-emerald-300">{inr(p - r.unreceived)}</Td>
                            </tr>
                          )
                        })}
                        <tr className="border-t border-slate-700 bg-slate-900/70 font-semibold">
                          <Td className="text-slate-300">Year total</Td>
                          <Td right className="text-emerald-400">{inr(yt.cust)}</Td>
                          <Td right className="text-rose-300">{yt.dep ? `−${inr(yt.dep)}` : '—'}</Td>
                          <Td right className="text-rose-300">{yt.other ? `−${inr(yt.other)}` : '—'}</Td>
                          <Td right className="text-emerald-400">{yt.income ? inr(yt.income) : '—'}</Td>
                          <Td right className="text-rose-300">{yt.expense ? `−${inr(yt.expense)}` : '—'}</Td>
                          <Td right className="text-hd">{inr(yt.profit)}</Td>
                          <Td right className="text-amber-400">{yt.unreceived ? inr(yt.unreceived) : '—'}</Td>
                          <Td right className="text-emerald-300">{inr(yt.profit - yt.unreceived)}</Td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </Card>
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
