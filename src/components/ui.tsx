import { ReactNode } from 'react'

export function Card({ children, className = '' }: { children: ReactNode; className?: string }) {
  return <div className={`card p-4 sm:p-5 ${className}`}>{children}</div>
}

export function PageHeader({ title, subtitle, action }: { title: string; subtitle?: ReactNode; action?: ReactNode }) {
  return (
    <div className="mb-5 flex flex-wrap items-end justify-between gap-3">
      <div>
        <h1 className="text-2xl font-bold tracking-tight text-white">{title}</h1>
        {subtitle && <p className="mt-1 text-sm text-slate-400">{subtitle}</p>}
      </div>
      {action}
    </div>
  )
}

const toneMap: Record<string, string> = {
  green: 'bg-emerald-500/15 text-emerald-300 ring-emerald-500/30',
  red: 'bg-rose-500/15 text-rose-300 ring-rose-500/30',
  amber: 'bg-amber-500/15 text-amber-300 ring-amber-500/30',
  blue: 'bg-brand-500/15 text-brand-300 ring-brand-500/30',
  slate: 'bg-slate-500/15 text-slate-300 ring-slate-500/30',
}

export function Badge({ children, tone = 'slate' }: { children: ReactNode; tone?: keyof typeof toneMap }) {
  return (
    <span className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium ring-1 ring-inset ${toneMap[tone] ?? toneMap.slate}`}>
      {children}
    </span>
  )
}

export function statusTone(status?: string): keyof typeof toneMap {
  const s = (status ?? '').toLowerCase()
  if (['active', 'paid', 'closed'].includes(s)) return s === 'active' ? 'green' : s === 'paid' ? 'green' : 'slate'
  if (['pending', 'partial'].includes(s)) return 'amber'
  if (['inactive', 'overdue'].includes(s)) return 'red'
  return 'slate'
}

export function StatCard({
  label, value, sub, tone = 'blue', icon,
}: { label: string; value: ReactNode; sub?: ReactNode; tone?: keyof typeof toneMap; icon?: ReactNode }) {
  return (
    <div className="card p-4">
      <div className="flex items-start justify-between">
        <p className="label">{label}</p>
        {icon && <span className={`grid h-9 w-9 place-items-center rounded-xl ${toneMap[tone]}`}>{icon}</span>}
      </div>
      <p className="mt-2 text-2xl font-bold text-white">{value}</p>
      {sub && <p className="mt-1 text-xs text-slate-400">{sub}</p>}
    </div>
  )
}

export function EmptyState({ title, hint }: { title: string; hint?: string }) {
  return (
    <div className="card grid place-items-center gap-1 p-10 text-center">
      <p className="font-semibold text-slate-300">{title}</p>
      {hint && <p className="text-sm text-slate-500">{hint}</p>}
    </div>
  )
}

export function Th({ children, right }: { children: ReactNode; right?: boolean }) {
  return <th className={`px-3 py-2 text-xs font-semibold uppercase tracking-wide text-slate-400 ${right ? 'text-right' : 'text-left'}`}>{children}</th>
}
export function Td({ children, right, className = '' }: { children: ReactNode; right?: boolean; className?: string }) {
  return <td className={`px-3 py-2.5 text-sm ${right ? 'text-right tabular-nums' : ''} ${className}`}>{children}</td>
}
