import { ReactNode, useState } from 'react'
import { NavLink, useNavigate } from 'react-router-dom'
import {
  LayoutDashboard, Users, HandCoins, Percent, BookOpenText, PiggyBank,
  Boxes, Gem, LogOut, Menu, X, Wallet, ChevronDown,
} from 'lucide-react'
import { useApp } from '../store/app'
import { repo, source } from '../data/repository'

const nav = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard, end: true },
  { to: '/customers', label: 'Customers', icon: Users },
  { to: '/loans', label: 'Loans', icon: HandCoins },
  { to: '/interest', label: 'Interest', icon: Percent },
  { to: '/ledger', label: 'Ledger', icon: BookOpenText },
  { to: '/deposits', label: 'Deposits', icon: PiggyBank },
  { to: '/chits', label: 'Chits', icon: Boxes },
  { to: '/jewel', label: 'Jewel Loans', icon: Gem },
]

function NavList({ onNavigate }: { onNavigate?: () => void }) {
  return (
    <nav className="flex flex-col gap-1">
      {nav.map(({ to, label, icon: Icon, end }) => (
        <NavLink
          key={to}
          to={to}
          end={end}
          onClick={onNavigate}
          className={({ isActive }) =>
            `flex items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium transition ${
              isActive ? 'bg-brand-600 text-white shadow-lg shadow-brand-900/40' : 'text-slate-300 hover:bg-slate-800/70'
            }`
          }
        >
          <Icon size={18} />
          {label}
        </NavLink>
      ))}
    </nav>
  )
}

function FinanceSwitcher() {
  const { finance, setFinance, user } = useApp()
  const [open, setOpen] = useState(false)
  const finances = repo.finances()
  if (user?.role !== 'owner') return <span className="text-sm text-slate-400">{finance}</span>
  return (
    <div className="relative">
      <button onClick={() => setOpen(o => !o)} className="btn-ghost !py-1.5 text-xs">
        <Wallet size={14} /> {finance === 'ALL' ? 'All finances' : finance}
        <ChevronDown size={14} />
      </button>
      {open && (
        <div className="absolute right-0 z-30 mt-1 w-52 overflow-hidden rounded-xl border border-slate-800 bg-slate-900 shadow-xl">
          {['ALL', ...finances.map(f => f.Finance_Name)].map(f => (
            <button
              key={f}
              onClick={() => { setFinance(f); setOpen(false) }}
              className={`block w-full px-3 py-2 text-left text-sm hover:bg-slate-800 ${f === finance ? 'text-brand-300' : 'text-slate-300'}`}
            >
              {f === 'ALL' ? 'All finances' : f}
            </button>
          ))}
        </div>
      )}
    </div>
  )
}

function DataSourceBadge() {
  const live = source.live
  const configured = source.mode === 'supabase'
  const label = live ? 'Live · Supabase' : configured ? 'Demo · run migrate.sql' : 'Demo data'
  const cls = live
    ? 'bg-emerald-500/15 text-emerald-300 ring-emerald-500/30'
    : 'bg-amber-500/15 text-amber-300 ring-amber-500/30'
  return (
    <span className={`hidden items-center gap-1.5 rounded-full px-2.5 py-1 text-[11px] font-medium ring-1 ring-inset sm:inline-flex ${cls}`}>
      <span className={`h-1.5 w-1.5 rounded-full ${live ? 'bg-emerald-400' : 'bg-amber-400'}`} />
      {label}
    </span>
  )
}

export default function Layout({ children }: { children: ReactNode }) {
  const { user, logout } = useApp()
  const navigate = useNavigate()
  const [mobileOpen, setMobileOpen] = useState(false)

  const brand = (
    <div className="flex items-center gap-2.5 px-1">
      <div className="grid h-9 w-9 place-items-center rounded-xl bg-gradient-to-br from-brand-400 to-brand-700 font-black text-white">₹</div>
      <div>
        <p className="text-sm font-bold leading-tight text-white">Arul Finance</p>
        <p className="text-[11px] leading-tight text-slate-400">Management Suite</p>
      </div>
    </div>
  )

  return (
    <div className="min-h-screen bg-slate-950">
      {/* Sidebar (desktop) */}
      <aside className="fixed inset-y-0 left-0 hidden w-64 flex-col border-r border-slate-800 bg-slate-900/40 p-4 lg:flex">
        {brand}
        <div className="mt-6 flex-1"><NavList /></div>
        <button onClick={() => { logout(); navigate('/login') }} className="btn-ghost mt-2 justify-start">
          <LogOut size={18} /> Sign out
        </button>
      </aside>

      {/* Mobile drawer */}
      {mobileOpen && (
        <div className="fixed inset-0 z-40 lg:hidden">
          <div className="absolute inset-0 bg-black/60" onClick={() => setMobileOpen(false)} />
          <div className="absolute inset-y-0 left-0 flex w-72 flex-col border-r border-slate-800 bg-slate-900 p-4">
            <div className="flex items-center justify-between">{brand}<button onClick={() => setMobileOpen(false)}><X className="text-slate-400" /></button></div>
            <div className="mt-6 flex-1"><NavList onNavigate={() => setMobileOpen(false)} /></div>
            <button onClick={() => { logout(); navigate('/login') }} className="btn-ghost justify-start"><LogOut size={18} /> Sign out</button>
          </div>
        </div>
      )}

      {/* Main */}
      <div className="lg:pl-64">
        <header className="sticky top-0 z-20 flex items-center justify-between border-b border-slate-800 bg-slate-950/80 px-4 py-3 backdrop-blur">
          <button className="lg:hidden" onClick={() => setMobileOpen(true)}><Menu className="text-slate-300" /></button>
          <div className="hidden lg:block" />
          <div className="flex items-center gap-3">
            <DataSourceBadge />
            <FinanceSwitcher />
            <div className="flex items-center gap-2">
              <div className="grid h-8 w-8 place-items-center rounded-full bg-brand-600 text-xs font-bold text-white">
                {user?.name?.[0]?.toUpperCase() ?? 'U'}
              </div>
              <div className="hidden sm:block">
                <p className="text-xs font-semibold text-white">{user?.name}</p>
                <p className="text-[11px] capitalize text-slate-400">{user?.role}</p>
              </div>
            </div>
          </div>
        </header>

        <main className="mx-auto max-w-7xl px-4 py-6 pb-24 lg:pb-6">{children}</main>
      </div>

      {/* Mobile bottom nav */}
      <nav className="fixed inset-x-0 bottom-0 z-20 flex items-center justify-around border-t border-slate-800 bg-slate-950/95 py-1.5 backdrop-blur lg:hidden">
        {nav.slice(0, 5).map(({ to, label, icon: Icon, end }) => (
          <NavLink key={to} to={to} end={end}
            className={({ isActive }) => `flex flex-col items-center gap-0.5 rounded-lg px-3 py-1 text-[10px] font-medium ${isActive ? 'text-brand-400' : 'text-slate-400'}`}>
            <Icon size={20} />{label}
          </NavLink>
        ))}
      </nav>
    </div>
  )
}
