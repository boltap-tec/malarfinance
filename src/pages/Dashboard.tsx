import { useMemo } from 'react'
import { Link } from 'react-router-dom'
import {
  ResponsiveContainer, AreaChart, Area, XAxis, YAxis, Tooltip, CartesianGrid,
  PieChart, Pie, Cell,
} from 'recharts'
import { HandCoins, Percent, Users, PiggyBank, TrendingUp, ArrowRight } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, StatCard, Card, Badge } from '../components/ui'
import { inr, inrShort, fmtDate, num } from '../lib/format'

const STATUS_COLORS: Record<string, string> = {
  Active: '#34d399', Closed: '#64748b', Pending: '#fbbf24', Overdue: '#fb7185', Inactive: '#94a3b8',
}

export default function Dashboard() {
  const finance = useApp(s => s.finance)
  const f = financeFilter(finance)

  const data = useMemo(() => {
    const loans = repo.loans(f)
    const customers = repo.customers(f)
    const interest = repo.interest(f)
    const deposits = repo.deposits(f)
    const ledger = repo.ledger(f)

    const activeLoans = loans.filter(l => (l.Loan_Status ?? '').toLowerCase() === 'active')
    const outstandingLoan = loans.reduce((s, l) => s + num(l.Outstand_Amount), 0)
    const totalGiven = loans.reduce((s, l) => s + num(l.Loan_Amount), 0)

    const interestCollected = interest.reduce((s, i) => s + num(i.Amount_Received), 0)
    const interestPending = interest.reduce((s, i) => s + num(i.Interest_Pending), 0)

    const depositOutstanding = deposits.reduce((s, d) => s + num(d.Outstand_Amount), 0)

    // Monthly interest trend (billed vs collected) by Month "MM-YYYY"
    const byMonth = new Map<string, { billed: number; collected: number }>()
    for (const i of interest) {
      const m = i.Month ?? '—'
      const cur = byMonth.get(m) ?? { billed: 0, collected: 0 }
      cur.billed += num(i.Interest_Amount)
      cur.collected += num(i.Amount_Received)
      byMonth.set(m, cur)
    }
    const trend = [...byMonth.entries()]
      .map(([m, v]) => ({ month: m, ...v, key: monthKey(m) }))
      .sort((a, b) => a.key - b.key)
      .slice(-8)
      .map(({ month, billed, collected }) => ({ month, billed: Math.round(billed), collected: Math.round(collected) }))

    // Loan status distribution
    const statusMap = new Map<string, number>()
    for (const l of loans) {
      const s = l.Loan_Status ?? 'Unknown'
      statusMap.set(s, (statusMap.get(s) ?? 0) + 1)
    }
    const statusData = [...statusMap.entries()].map(([name, value]) => ({ name, value }))

    const recent = [...ledger]
      .sort((a, b) => (new Date(b.Date_Transaction ?? 0).getTime()) - (new Date(a.Date_Transaction ?? 0).getTime()))
      .slice(0, 8)

    return {
      activeLoans: activeLoans.length, loanCount: loans.length,
      customers: customers.length, activeCustomers: customers.filter(c => (c.Status ?? '').toLowerCase() === 'active').length,
      outstandingLoan, totalGiven, interestCollected, interestPending, depositOutstanding,
      trend, statusData, recent,
    }
  }, [f])

  return (
    <div>
      <PageHeader
        title="Dashboard"
        subtitle={finance === 'ALL' ? 'All finances combined' : finance}
      />

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Outstanding loans" value={inrShort(data.outstandingLoan)} tone="blue"
          sub={`${data.activeLoans} active of ${data.loanCount}`} icon={<HandCoins size={18} />} />
        <StatCard label="Interest pending" value={inrShort(data.interestPending)} tone="amber"
          sub={`${inrShort(data.interestCollected)} collected`} icon={<Percent size={18} />} />
        <StatCard label="Customers" value={data.customers} tone="green"
          sub={`${data.activeCustomers} active`} icon={<Users size={18} />} />
        <StatCard label="Deposits payable" value={inrShort(data.depositOutstanding)} tone="red"
          sub="owed to depositors" icon={<PiggyBank size={18} />} />
      </div>

      <div className="mt-4 grid gap-4 lg:grid-cols-3">
        <Card className="lg:col-span-2">
          <div className="mb-3 flex items-center justify-between">
            <h3 className="font-semibold text-white">Interest — billed vs collected</h3>
            <Badge tone="blue"><TrendingUp size={12} className="mr-1" /> last 8 months</Badge>
          </div>
          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={data.trend} margin={{ left: -18, right: 8, top: 8 }}>
                <defs>
                  <linearGradient id="gBilled" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#3563f5" stopOpacity={0.5} />
                    <stop offset="95%" stopColor="#3563f5" stopOpacity={0} />
                  </linearGradient>
                  <linearGradient id="gColl" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#34d399" stopOpacity={0.5} />
                    <stop offset="95%" stopColor="#34d399" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                <XAxis dataKey="month" tick={{ fill: '#94a3b8', fontSize: 11 }} axisLine={false} tickLine={false} />
                <YAxis tick={{ fill: '#94a3b8', fontSize: 11 }} axisLine={false} tickLine={false} tickFormatter={(v) => inrShort(v)} />
                <Tooltip contentStyle={tooltipStyle} formatter={(v: number) => inr(v)} />
                <Area type="monotone" dataKey="billed" stroke="#3563f5" fill="url(#gBilled)" strokeWidth={2} name="Billed" />
                <Area type="monotone" dataKey="collected" stroke="#34d399" fill="url(#gColl)" strokeWidth={2} name="Collected" />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </Card>

        <Card>
          <h3 className="mb-3 font-semibold text-white">Loan status</h3>
          <div className="h-48">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie data={data.statusData} dataKey="value" nameKey="name" innerRadius={44} outerRadius={72} paddingAngle={3}>
                  {data.statusData.map((s, i) => <Cell key={i} fill={STATUS_COLORS[s.name] ?? '#64748b'} />)}
                </Pie>
                <Tooltip contentStyle={tooltipStyle} />
              </PieChart>
            </ResponsiveContainer>
          </div>
          <div className="mt-2 space-y-1.5">
            {data.statusData.map(s => (
              <div key={s.name} className="flex items-center justify-between text-sm">
                <span className="flex items-center gap-2 text-slate-300">
                  <span className="h-2.5 w-2.5 rounded-full" style={{ background: STATUS_COLORS[s.name] ?? '#64748b' }} />{s.name}
                </span>
                <span className="font-semibold text-white">{s.value}</span>
              </div>
            ))}
          </div>
        </Card>
      </div>

      <Card className="mt-4">
        <div className="mb-2 flex items-center justify-between">
          <h3 className="font-semibold text-white">Recent transactions</h3>
          <Link to="/ledger" className="flex items-center gap-1 text-sm text-brand-400 hover:text-brand-300">View ledger <ArrowRight size={14} /></Link>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <tbody className="divide-y divide-slate-800">
              {data.recent.map((t, i) => {
                const receipt = num(t.Receipt_Amount), payment = num(t.Payment_Amount)
                return (
                  <tr key={i} className="text-sm">
                    <td className="py-2.5 pr-3">
                      <p className="font-medium text-slate-200">{t.Description ?? t.Nature_Transaction ?? '—'}</p>
                      <p className="text-xs text-slate-500">{t.Customer_Name ?? t.STL_No ?? ''} · {fmtDate(t.Date_Transaction)}</p>
                    </td>
                    <td className="py-2.5 text-right tabular-nums">
                      {receipt > 0 && <span className="font-semibold text-emerald-400">+{inr(receipt)}</span>}
                      {payment > 0 && <span className="font-semibold text-rose-400">−{inr(payment)}</span>}
                    </td>
                  </tr>
                )
              })}
              {data.recent.length === 0 && <tr><td className="py-6 text-center text-sm text-slate-500">No transactions yet.</td></tr>}
            </tbody>
          </table>
        </div>
      </Card>
    </div>
  )
}

const tooltipStyle = { background: '#0f172a', border: '1px solid #1e293b', borderRadius: 12, color: '#e2e8f0', fontSize: 12 }

function monthKey(m: string): number {
  // "MM-YYYY" -> sortable number
  const [mm, yyyy] = m.split('-')
  const y = Number(yyyy), mo = Number(mm)
  if (!y || !mo) return 0
  return y * 100 + mo
}
