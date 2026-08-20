import { useEffect, useMemo, useRef, useState, type KeyboardEvent as ReactKeyboardEvent } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Search, CornerDownLeft, HandCoins, PiggyBank, Building2, UserPlus, Percent, Wallet,
} from 'lucide-react'
import { repo } from '../data/repository'
import { navItems } from '../nav'
import { useApp, financeFilter } from '../store/app'
import { inr, num } from '../lib/format'

interface Cmd {
  id: string
  label: string
  hint?: string
  group: string
  icon?: any
  run: (nav: ReturnType<typeof useNavigate>) => void
}

const quickActions: Cmd[] = [
  { id: 'a-loan', label: 'New loan', group: 'Actions', icon: HandCoins, run: n => n('/loans?new=1') },
  { id: 'a-cust', label: 'New customer', group: 'Actions', icon: UserPlus, run: n => n('/customers?new=1') },
  { id: 'a-dep', label: 'New deposit', group: 'Actions', icon: PiggyBank, run: n => n('/deposits?new=1') },
  { id: 'a-oth', label: 'Borrow from finance', group: 'Actions', icon: Building2, run: n => n('/other-finance?new=1') },
  { id: 'a-int', label: 'Post monthly interest', group: 'Actions', icon: Percent, run: n => n('/interest') },
]

export default function CommandPalette({ open, onClose }: { open: boolean; onClose: () => void }) {
  const navigate = useNavigate()
  const finance = useApp(s => s.finance)
  const [q, setQ] = useState('')
  const [active, setActive] = useState(0)
  const inputRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    if (open) { setQ(''); setActive(0); setTimeout(() => inputRef.current?.focus(), 0) }
  }, [open])

  const results = useMemo<Cmd[]>(() => {
    const s = q.trim().toLowerCase()
    const pages: Cmd[] = navItems.map(n => ({
      id: `p-${n.to}`, label: n.label, hint: n.desc, group: 'Pages', icon: n.icon,
      run: nav => nav(n.to),
    }))

    let list: Cmd[] = [...quickActions, ...pages]

    if (s) {
      const f = financeFilter(finance)
      const custs: Cmd[] = repo.customers(f)
        .filter(c => c.Customer_Name?.toLowerCase().includes(s) ||
          c.Customer_STL_NO?.toLowerCase().includes(s) ||
          String(c.Customer_Phone_No ?? '').includes(s))
        .slice(0, 5)
        .map(c => ({
          id: `c-${c.Customer_STL_NO}`, label: c.Customer_Name, group: 'Customers', icon: Wallet,
          hint: `${c.Customer_STL_NO} · ${inr(num(c.Outstand_Loan))} out`,
          run: nav => nav(`/customers/${encodeURIComponent(c.Customer_STL_NO)}`),
        }))
      const loans: Cmd[] = repo.loans(f)
        .filter(l => l.Loan_No?.toLowerCase().includes(s) || l.Customer_Name?.toLowerCase().includes(s))
        .slice(0, 5)
        .map(l => ({
          id: `l-${l.Loan_No}`, label: `Loan ${l.Loan_No}`, group: 'Loans', icon: HandCoins,
          hint: `${l.Customer_Name} · ${inr(num(l.Outstand_Amount))} out`,
          run: nav => nav(`/loans/${encodeURIComponent(l.Loan_No)}`),
        }))
      list = [...list, ...custs, ...loans].filter(c =>
        c.label.toLowerCase().includes(s) || (c.hint ?? '').toLowerCase().includes(s) || c.group === 'Customers' || c.group === 'Loans')
    }
    return list.slice(0, 20)
  }, [q, finance])

  useEffect(() => { setActive(0) }, [q])

  if (!open) return null

  function choose(cmd?: Cmd) {
    if (!cmd) return
    onClose()
    cmd.run(navigate)
  }

  function onKey(e: ReactKeyboardEvent) {
    if (e.key === 'ArrowDown') { e.preventDefault(); setActive(a => Math.min(a + 1, results.length - 1)) }
    else if (e.key === 'ArrowUp') { e.preventDefault(); setActive(a => Math.max(a - 1, 0)) }
    else if (e.key === 'Enter') { e.preventDefault(); choose(results[active]) }
    else if (e.key === 'Escape') { e.preventDefault(); onClose() }
  }

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center p-4 pt-[10vh]">
      <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" onClick={onClose} />
      <div className="card relative z-10 w-full max-w-xl overflow-hidden p-0" onKeyDown={onKey}>
        <div className="flex items-center gap-3 border-b border-slate-800 px-4">
          <Search size={18} className="text-slate-500" />
          <input
            ref={inputRef}
            value={q}
            onChange={e => setQ(e.target.value)}
            placeholder="Search pages, actions, customers, loans…"
            className="w-full bg-transparent py-4 text-sm text-slate-100 placeholder:text-slate-500 focus:outline-none"
          />
          <kbd className="hidden rounded bg-slate-800 px-1.5 py-0.5 text-[10px] text-slate-400 sm:block">Esc</kbd>
        </div>
        <div className="max-h-[55vh] overflow-y-auto py-2">
          {results.length === 0 && <p className="px-4 py-6 text-center text-sm text-slate-500">No matches.</p>}
          {results.map((c, i) => (
            <button
              key={c.id}
              onMouseEnter={() => setActive(i)}
              onClick={() => choose(c)}
              className={`flex w-full items-center gap-3 px-4 py-2.5 text-left ${i === active ? 'bg-brand-600/20' : ''}`}
            >
              {c.icon && <c.icon size={16} className="shrink-0 text-slate-400" />}
              <span className="flex-1">
                <span className="text-sm text-slate-100">{c.label}</span>
                {c.hint && <span className="ml-2 text-xs text-slate-500">{c.hint}</span>}
              </span>
              <span className="text-[10px] uppercase tracking-wide text-slate-600">{c.group}</span>
              {i === active && <CornerDownLeft size={14} className="text-brand-300" />}
            </button>
          ))}
        </div>
      </div>
    </div>
  )
}
