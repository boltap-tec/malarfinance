import { ReactNode } from 'react'
import { X } from 'lucide-react'
import { inr, amountWords } from '../lib/format'

// Live helper under a money input: shows the value in Indian grouping (₹1,50,000)
// and spelled out in words, so large amounts are easy to confirm while typing.
export function AmountHint({ value }: { value: string | number }) {
  const n = typeof value === 'number' ? value : Number(String(value).replace(/[^\d.]/g, ''))
  if (!n || isNaN(n) || n <= 0) return null
  return (
    <p className="mt-1 text-xs text-slate-400">
      <span className="font-semibold text-slate-200 tabular-nums">{inr(n)}</span>
      <span className="text-slate-500"> · {amountWords(n)} rupees</span>
    </p>
  )
}

export function Card({ children, className = '' }: { children: ReactNode; className?: string }) {
  return <div className={`card p-4 sm:p-5 ${className}`}>{children}</div>
}

export function PageHeader({ title, subtitle, action }: { title: string; subtitle?: ReactNode; action?: ReactNode }) {
  return (
    <div className="mb-5 flex flex-wrap items-end justify-between gap-3">
      <div>
        <h1 className="text-2xl font-bold tracking-tight text-hd">{title}</h1>
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
    <div className="card min-w-0 p-3 sm:p-4">
      <div className="flex items-start justify-between gap-2">
        <p className="label min-w-0">{label}</p>
        {icon && <span className={`grid h-8 w-8 shrink-0 place-items-center rounded-xl sm:h-9 sm:w-9 ${toneMap[tone]}`}>{icon}</span>}
      </div>
      <p className="mt-1.5 break-words text-lg font-bold leading-tight tabular-nums text-hd sm:mt-2 sm:text-2xl">{value}</p>
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

// ── Form / modal primitives ──────────────────────────────────────────────────
export function Modal({
  title, onClose, children, footer,
}: { title: string; onClose: () => void; children: ReactNode; footer?: ReactNode }) {
  return (
    // Scroll-container pattern: the backdrop is a fixed, scrollable layer. A tall
    // dialog (or a short window) then scrolls the WHOLE card into view instead of
    // clipping its top off-screen; it still centers when it fits.
    <div className="fixed inset-0 z-50 overflow-y-auto bg-black/60 p-4 backdrop-blur-sm" onClick={onClose}>
      <div className="flex min-h-full items-center justify-center">
        <div className="card relative w-full max-w-lg min-w-0 p-5" onClick={e => e.stopPropagation()}>
          <div className="mb-4 flex items-center justify-between">
            <h3 className="text-lg font-bold text-hd">{title}</h3>
            <button onClick={onClose} className="text-slate-400 hover:text-slate-200"><X size={18} /></button>
          </div>
          <div className="space-y-3">{children}</div>
          {footer && <div className="mt-5 flex justify-end gap-2">{footer}</div>}
        </div>
      </div>
    </div>
  )
}

export function ConfirmModal({
  title, message, confirmLabel = 'Delete', danger = true, onConfirm, onClose,
}: { title: string; message: ReactNode; confirmLabel?: string; danger?: boolean; onConfirm: () => void; onClose: () => void }) {
  return (
    <Modal
      title={title}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className={`btn-primary ${danger ? '!bg-rose-600 hover:!bg-rose-500' : ''}`} onClick={onConfirm}>{confirmLabel}</button>
      </>}
    >
      <div className="text-sm text-slate-300">{message}</div>
      <p className="mt-2 text-xs text-slate-500">This is recorded in the Activity Log and can be restored from there.</p>
    </Modal>
  )
}

// A horizontal segmented control for switching between sections on a detail page.
// Scrolls sideways on narrow screens so it never pushes the layout off-screen.
export function Tabs<T extends string>({ tabs, active, onChange }: {
  tabs: { key: T; label: ReactNode; badge?: ReactNode }[]
  active: T
  onChange: (key: T) => void
}) {
  return (
    <div className="mb-4 flex gap-1 overflow-x-auto rounded-xl bg-slate-800/40 p-1">
      {tabs.map(t => (
        <button
          key={t.key}
          onClick={() => onChange(t.key)}
          className={`flex items-center gap-1.5 whitespace-nowrap rounded-lg px-3 py-1.5 text-sm font-medium transition ${
            active === t.key ? 'bg-slate-900 text-hd shadow' : 'text-slate-400 hover:text-slate-200'
          }`}
        >
          {t.label}
          {t.badge != null && t.badge !== '' && (
            <span className={`rounded-full px-1.5 py-0.5 text-[11px] tabular-nums ${active === t.key ? 'bg-brand-500/20 text-brand-300' : 'bg-slate-700/60 text-slate-300'}`}>{t.badge}</span>
          )}
        </button>
      ))}
    </div>
  )
}

export function Field({ label, children, hint }: { label: string; children: ReactNode; hint?: string }) {
  return (
    <label className="block">
      <span className="label">{label}</span>
      <div className="mt-1">{children}</div>
      {hint && <span className="mt-1 block text-xs text-slate-500">{hint}</span>}
    </label>
  )
}

export function Th({ children, right }: { children: ReactNode; right?: boolean }) {
  return <th className={`px-3 py-2 text-xs font-semibold uppercase tracking-wide text-slate-400 ${right ? 'text-right' : 'text-left'}`}>{children}</th>
}
export function Td({ children, right, className = '' }: { children: ReactNode; right?: boolean; className?: string }) {
  return <td className={`px-3 py-2.5 text-sm ${right ? 'text-right tabular-nums' : ''} ${className}`}>{children}</td>
}
