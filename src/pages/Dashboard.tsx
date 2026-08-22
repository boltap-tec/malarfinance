import { useMemo, useState, type ReactNode } from 'react'
import { Link } from 'react-router-dom'
import {
  ResponsiveContainer, AreaChart, Area, XAxis, YAxis, Tooltip, CartesianGrid,
  PieChart, Pie, Cell,
} from 'recharts'
import {
  HandCoins, Percent, Users, PiggyBank, TrendingUp, ArrowRight, Building2,
  Boxes, Landmark, ChevronDown, Plus, type LucideIcon,
} from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter, canEdit, canSeeRoute, SHOW_OWN_CHIT_FUND, type AppUser } from '../store/app'
import { PageHeader, StatCard, Card, Badge } from '../components/ui'
import { inr, inrShort, fmtDate, num } from '../lib/format'

const STATUS_COLORS: Record<string, string> = {
  Active: '#34d399', Closed: '#64748b', Pending: '#fbbf24', Overdue: '#fb7185', Inactive: '#94a3b8',
}

// Wrap a KPI card in a link to its page — but only when the viewer's role may
// reach that page, so a partner never lands on a guarded redirect.
function kpiLink(user: AppUser | null, to: string, card: ReactNode): ReactNode {
  return canSeeRoute(user, to)
    ? <Link to={to} className="block transition hover:-translate-y-0.5">{card}</Link>
    : card
}

export default function Dashboard() {
  const finance = useApp(s => s.finance)
  const user = useApp(s => s.user)
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

    // Chit funds the finance runs — roll up dues to collect + payouts still owed.
    const chits = repo.chits(f)
    let chitDuePending = 0, chitCollected = 0, chitPayoutPending = 0
    for (const c of chits) {
      const s = repo.chitSummary(c.Chit_ID)
      chitDuePending += s.duePending; chitCollected += s.collected; chitPayoutPending += s.payoutPending
    }

    return {
      activeLoans: activeLoans.length, loanCount: loans.length,
      customers: customers.length, activeCustomers: customers.filter(c => (c.Status ?? '').toLowerCase() === 'active').length,
      outstandingLoan, totalGiven, interestCollected, interestPending, depositOutstanding,
      trend, statusData, recent,
      chitFunds: chits.length, chitDuePending, chitCollected, chitPayoutPending,
    }
  }, [f])

  return (
    <div>
      <PageHeader
        title="Dashboard"
        subtitle={finance === 'ALL' ? 'All finances combined' : finance}
      />

      {/* Grouped action hub — each box opens its sub-actions */}
      <ActionHub user={user} />

      <div className={`grid grid-cols-2 gap-3 ${SHOW_OWN_CHIT_FUND && data.chitFunds > 0 ? 'lg:grid-cols-5' : 'lg:grid-cols-4'}`}>
        {kpiLink(user, '/loans',
          <StatCard label="Outstanding loans" value={inrShort(data.outstandingLoan)} tone="blue"
            sub={`${data.activeLoans} active of ${data.loanCount}`} icon={<HandCoins size={18} />} />)}
        {kpiLink(user, '/customer-interest',
          <StatCard label="Interest pending" value={inrShort(data.interestPending)} tone="amber"
            sub={`${inrShort(data.interestCollected)} collected`} icon={<Percent size={18} />} />)}
        {kpiLink(user, '/customers',
          <StatCard label="Customers" value={data.customers} tone="green"
            sub={`${data.activeCustomers} active`} icon={<Users size={18} />} />)}
        {kpiLink(user, '/deposits',
          <StatCard label="Deposits payable" value={inrShort(data.depositOutstanding)} tone="red"
            sub="owed to depositors" icon={<PiggyBank size={18} />} />)}
        {SHOW_OWN_CHIT_FUND && data.chitFunds > 0 && kpiLink(user, '/chit/transactions',
          <StatCard label="Chit dues to collect" value={inrShort(data.chitDuePending)} tone="blue"
            sub={`${data.chitFunds} fund${data.chitFunds > 1 ? 's' : ''} · ${inrShort(data.chitPayoutPending)} payout due`} icon={<Boxes size={18} />} />)}
      </div>

      <div className="mt-4 grid gap-4 lg:grid-cols-3">
        <Card className="lg:col-span-2">
          <div className="mb-3 flex items-center justify-between">
            <h3 className="font-semibold text-hd">Interest — billed vs collected</h3>
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
          <h3 className="mb-3 font-semibold text-hd">Loan status</h3>
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
                <span className="font-semibold text-hd">{s.value}</span>
              </div>
            ))}
          </div>
        </Card>
      </div>

      <Card className="mt-4">
        <div className="mb-2 flex items-center justify-between">
          <h3 className="font-semibold text-hd">Recent transactions</h3>
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

// ── Grouped action hub ───────────────────────────────────────────────────────
interface SubAction { label: string; to: string; create?: boolean }
interface Group { title: string; icon: LucideIcon; tone: string; items: SubAction[] }

const GROUPS: Group[] = [
  {
    title: 'Loan Lending', icon: HandCoins, tone: 'text-brand-300 bg-brand-500/15 ring-brand-500/30',
    items: [
      { label: 'New loan', to: '/loans?new=1', create: true },
      { label: 'New customer', to: '/customers?new=1', create: true },
      { label: 'Collect interest', to: '/customer-interest' },
      { label: 'Post interest', to: '/interest' },
      { label: 'All loans', to: '/loans' },
    ],
  },
  {
    title: 'Deposits', icon: PiggyBank, tone: 'text-emerald-300 bg-emerald-500/15 ring-emerald-500/30',
    items: [
      { label: 'New deposit', to: '/deposits?new=1', create: true },
      { label: 'New depositor', to: '/depositors?new=1', create: true },
      { label: 'Deposit interest', to: '/deposit-interest' },
      { label: 'All deposits', to: '/deposits' },
    ],
  },
  {
    title: 'Other Finance', icon: Landmark, tone: 'text-amber-300 bg-amber-500/15 ring-amber-500/30',
    items: [
      { label: 'Borrow money', to: '/other-finance?new=1', create: true },
      { label: 'Add lender', to: '/other-finances?new=1', create: true },
      { label: 'Their interest', to: '/other-finance-interest' },
    ],
  },
  ...(SHOW_OWN_CHIT_FUND ? [{
    title: 'Chit', icon: Boxes, tone: 'text-brand-300 bg-brand-500/15 ring-brand-500/30',
    items: [
      { label: 'New chit fund', to: '/chit?new=1', create: true },
      { label: 'Post auction', to: '/chit/auctions' },
      { label: 'Collect dues', to: '/chit/transactions' },
      { label: 'Chit ledger', to: '/chit/ledger' },
      { label: 'Members', to: '/chit/members' },
    ],
  }] : []),
  {
    title: 'Organisation', icon: Users, tone: 'text-brand-300 bg-brand-500/15 ring-brand-500/30',
    items: [
      { label: 'Add finance', to: '/finances?new=1', create: true },
      { label: 'Partners', to: '/partners' },
      { label: 'Workers', to: '/workers' },
      { label: 'Messages', to: '/messages' },
    ],
  },
  {
    title: 'More', icon: Boxes, tone: 'text-slate-300 bg-slate-500/15 ring-slate-500/30',
    items: [
      { label: 'Hand exchange', to: '/hand' },
      { label: 'Chits', to: '/chits' },
      { label: 'Ledger', to: '/ledger' },
      { label: 'Activity log', to: '/logs' },
      { label: 'Settings', to: '/settings' },
    ],
  },
]

function ActionHub({ user }: { user: AppUser | null }) {
  const editor = canEdit(user?.role)
  const groups = GROUPS
    .map(g => ({
      ...g,
      items: g.items.filter(it => {
        const base = it.to.split('?')[0]
        if (it.create && !editor) return false
        return canSeeRoute(user, base)
      }),
    }))
    .filter(g => g.items.length > 0)

  if (groups.length === 0) return null
  return (
    <div className="mb-5 grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
      {groups.map((g, i) => <ActionGroup key={g.title} group={g} defaultOpen={i === 0} />)}
    </div>
  )
}

function ActionGroup({ group, defaultOpen }: { group: Group; defaultOpen?: boolean }) {
  const [open, setOpen] = useState(!!defaultOpen)
  const Icon = group.icon
  return (
    <div className="card overflow-hidden">
      <button onClick={() => setOpen(o => !o)} className="flex w-full items-center gap-3 p-4 text-left hover:bg-slate-800/40">
        <span className={`grid h-10 w-10 shrink-0 place-items-center rounded-xl ring-1 ring-inset ${group.tone}`}><Icon size={18} /></span>
        <span className="flex-1">
          <span className="block text-sm font-semibold text-hd">{group.title}</span>
          <span className="block text-xs text-slate-500">{group.items.length} action{group.items.length > 1 ? 's' : ''}</span>
        </span>
        <ChevronDown size={18} className={`text-slate-400 transition-transform ${open ? 'rotate-180' : ''}`} />
      </button>
      {open && (
        <div className="grid gap-1.5 border-t border-slate-800 p-2">
          {group.items.map(it => (
            <Link
              key={it.to}
              to={it.to}
              className="flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm text-slate-300 hover:bg-slate-800/70 hover:text-hd"
            >
              {it.create ? <Plus size={15} className="text-brand-400" /> : <ArrowRight size={15} className="text-slate-500" />}
              {it.label}
            </Link>
          ))}
        </div>
      )}
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
