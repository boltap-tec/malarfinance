import { ReactNode, useEffect, useRef, useState } from 'react'
import { NavLink, useNavigate } from 'react-router-dom'
import {
  LogOut, Menu, X, Wallet, ChevronDown, LayoutGrid, Search,
  PanelLeftClose, PanelLeftOpen, Bell, RefreshCw, KeyRound, MessageSquare, Volume2, VolumeX,
  Palette, Check,
} from 'lucide-react'
import { useApp, canSeeRoute } from '../store/app'
import { repo, source, refresh, markNotificationsRead } from '../data/repository'
import { navGroups, bottomNav } from '../nav'
import { Modal, Field } from './ui'
import { playClick, playAction, isMuted, setMuted } from '../lib/sound'
import {
  THEMES, getTheme, setTheme, FONT_SIZES, getFontSize, setFontSize,
  type ThemeId, type FontSize,
} from '../lib/theme'
import CommandPalette from './CommandPalette'

// Pick and persist the colour theme + font size (saved per device until changed).
function ThemePicker() {
  const [open, setOpen] = useState(false)
  const [theme, setThemeState] = useState<ThemeId>(getTheme())
  const [font, setFontState] = useState<FontSize>(getFontSize())
  return (
    <div className="relative">
      <button title="Appearance" onClick={() => setOpen(o => !o)} className="grid h-9 w-9 place-items-center rounded-xl text-slate-300 hover:bg-slate-800/60">
        <Palette size={18} />
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-30" onClick={() => setOpen(false)} />
          <div className="absolute right-0 z-40 mt-2 w-56 overflow-hidden rounded-xl border border-slate-800 bg-slate-900 p-1.5 shadow-xl">
            <p className="px-2 py-1 text-[10px] font-semibold uppercase tracking-wider text-slate-500">Theme</p>
            {THEMES.map(t => (
              <button
                key={t.id}
                onClick={() => { setTheme(t.id); setThemeState(t.id); setOpen(false) }}
                className={`flex w-full items-center gap-2.5 rounded-lg px-2 py-2 text-sm hover:bg-slate-800/70 ${t.id === theme ? 'text-hd' : 'text-slate-300'}`}
              >
                <span className="h-5 w-5 shrink-0 rounded-full border border-black/10" style={{ background: t.surface }}>
                  <span className="block h-2 w-2 translate-x-1.5 translate-y-1.5 rounded-full" style={{ background: t.swatch }} />
                </span>
                {t.label}
                {t.id === theme && <Check size={15} className="ml-auto text-brand-400" />}
              </button>
            ))}
            <p className="mt-1 border-t border-slate-800 px-2 pb-1 pt-2 text-[10px] font-semibold uppercase tracking-wider text-slate-500">Font size</p>
            <div className="flex gap-1 p-1">
              {FONT_SIZES.map(fs => (
                <button
                  key={fs.id}
                  title={fs.label}
                  onClick={() => { setFontSize(fs.id); setFontState(fs.id) }}
                  className={`flex-1 rounded-lg py-1.5 font-semibold ${font === fs.id ? 'bg-brand-600 text-white' : 'bg-slate-800/60 text-slate-300'}`}
                  style={{ fontSize: Math.max(11, fs.px - 4) }}
                >A</button>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  )
}

function NavList({ onNavigate, collapsed }: { onNavigate?: () => void; collapsed?: boolean }) {
  const user = useApp(s => s.user)
  const groups = navGroups
    .map(g => ({ ...g, items: g.items.filter(it => canSeeRoute(user, it.to)) }))
    .filter(g => g.items.length > 0)
  return (
    <nav className="flex flex-col gap-4">
      {groups.map(group => (
        <div key={group.title}>
          {!collapsed && <p className="mb-1 px-3 text-[10px] font-semibold uppercase tracking-wider text-slate-500">{group.title}</p>}
          <div className="flex flex-col gap-1">
            {group.items.map(({ to, label, icon: Icon, end }) => (
              <NavLink
                key={to}
                to={to}
                end={end}
                onClick={onNavigate}
                title={collapsed ? label : undefined}
                className={({ isActive }) =>
                  `flex items-center gap-3 rounded-xl py-2 text-sm font-medium transition ${collapsed ? 'justify-center px-2' : 'px-3'} ${
                    isActive ? 'bg-brand-600 text-white shadow-lg shadow-brand-900/40' : 'text-slate-300 hover:bg-slate-800/70'
                  }`
                }
              >
                <Icon size={18} />
                {!collapsed && label}
              </NavLink>
            ))}
          </div>
        </div>
      ))}
    </nav>
  )
}

function FinanceSwitcher() {
  const { finance, setFinance, user } = useApp()
  const [open, setOpen] = useState(false)
  if (user?.role !== 'md') return <span className="hidden text-sm text-slate-400 sm:inline">{finance}</span>
  // Super MD may pick any finance or "All"; every other MD only their own.
  const options = user.isSuper ? ['ALL', ...(user.finances ?? [])] : (user.finances ?? [])
  // A single-finance MD has nothing to switch — just show the name.
  if (options.length <= 1) return <span className="hidden text-sm text-slate-400 sm:inline">{finance}</span>
  return (
    <div className="relative">
      <button onClick={() => setOpen(o => !o)} className="btn-ghost !py-1.5 text-xs">
        <Wallet size={14} /> {finance === 'ALL' ? 'All finances' : finance}
        <ChevronDown size={14} />
      </button>
      {open && (
        <div className="absolute right-0 z-30 mt-1 w-52 overflow-hidden rounded-xl border border-slate-800 bg-slate-900 shadow-xl">
          {options.map(f => (
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

function RefreshButton() {
  const [busy, setBusy] = useState(false)
  return (
    <button
      title="Refresh data"
      onClick={async () => { setBusy(true); await refresh() }}
      className="grid h-9 w-9 place-items-center rounded-xl text-slate-300 hover:bg-slate-800/60"
    >
      <RefreshCw size={18} className={busy ? 'animate-spin' : ''} />
    </button>
  )
}

function SoundToggle() {
  const [muted, setMutedState] = useState(isMuted())
  return (
    <button
      title={muted ? 'Sound off' : 'Sound on'}
      onClick={() => { const v = !muted; setMuted(v); setMutedState(v) }}
      className="grid h-9 w-9 place-items-center rounded-xl text-slate-300 hover:bg-slate-800/60"
    >
      {muted ? <VolumeX size={18} /> : <Volume2 size={18} />}
    </button>
  )
}

// A short beep via Web Audio (no asset needed, CSP-safe).
function playBeep() {
  try {
    const Ctx = (window.AudioContext || (window as any).webkitAudioContext)
    if (!Ctx) return
    const ctx = new Ctx()
    const osc = ctx.createOscillator()
    const gain = ctx.createGain()
    osc.connect(gain); gain.connect(ctx.destination)
    osc.type = 'sine'; osc.frequency.value = 880
    gain.gain.setValueAtTime(0.001, ctx.currentTime)
    gain.gain.exponentialRampToValueAtTime(0.2, ctx.currentTime + 0.02)
    gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.35)
    osc.start(); osc.stop(ctx.currentTime + 0.36)
    osc.onended = () => ctx.close()
  } catch { /* audio not available */ }
}

function NotificationBell() {
  const phone = useApp(s => s.user?.phone) ?? ''
  const [open, setOpen] = useState(false)
  const [tick, setTick] = useState(0)
  const prevUnread = useRef<number | null>(null)
  const items = repo.notifications(phone).slice(0, 20)
  const unread = repo.unreadCount(phone)

  // Poll so notifications raised elsewhere in this session surface with a beep.
  useEffect(() => {
    const id = setInterval(() => setTick(t => t + 1), 4000)
    return () => clearInterval(id)
  }, [])
  useEffect(() => {
    if (prevUnread.current !== null && unread > prevUnread.current) playBeep()
    prevUnread.current = unread
  }, [unread])

  return (
    <div className="relative">
      <button
        onClick={() => {
          const next = !open
          setOpen(next)
          if (next && unread > 0) { markNotificationsRead(phone); setTimeout(() => setTick(t => t + 1), 0) }
        }}
        className="relative grid h-9 w-9 place-items-center rounded-xl text-slate-300 hover:bg-slate-800/60"
        title="Notifications"
      >
        <Bell size={18} />
        {unread > 0 && (
          <span className="absolute -right-0.5 -top-0.5 grid h-4 min-w-4 place-items-center rounded-full bg-rose-500 px-1 text-[10px] font-bold text-white">
            {unread > 9 ? '9+' : unread}
          </span>
        )}
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-30" onClick={() => setOpen(false)} />
          <div className="absolute right-0 z-40 mt-2 w-80 overflow-hidden rounded-xl border border-slate-800 bg-slate-900 shadow-xl" data-tick={tick}>
            <div className="border-b border-slate-800 px-4 py-2.5 text-sm font-semibold text-hd">Notifications</div>
            <div className="max-h-80 overflow-y-auto">
              {items.length === 0 && <p className="px-4 py-6 text-center text-sm text-slate-500">No notifications.</p>}
              {items.map(n => (
                <div key={n.id} className="border-b border-slate-800/60 px-4 py-2.5">
                  <p className="text-sm font-medium text-slate-100">{n.Title}</p>
                  {n.Body && <p className="text-xs text-slate-400">{n.Body}</p>}
                  <p className="mt-0.5 text-[10px] text-slate-600">{new Date(n.Date).toLocaleString('en-IN')}</p>
                </div>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  )
}

function ChangePasswordButton() {
  const changePassword = useApp(s => s.changePassword)
  const [open, setOpen] = useState(false)
  const [pw, setPw] = useState('')
  const [pw2, setPw2] = useState('')
  const [done, setDone] = useState(false)
  const valid = pw.length >= 4 && pw === pw2

  return (
    <>
      <button title="Change password" onClick={() => { setOpen(true); setDone(false); setPw(''); setPw2('') }} className="grid h-9 w-9 place-items-center rounded-xl text-slate-300 hover:bg-slate-800/60">
        <KeyRound size={18} />
      </button>
      {open && (
        <Modal
          title="Change password"
          onClose={() => setOpen(false)}
          footer={<>
            <button className="btn-ghost" onClick={() => setOpen(false)}>Close</button>
            <button className="btn-primary" disabled={!valid} onClick={() => { changePassword(pw); setDone(true) }}>Save</button>
          </>}
        >
          {done ? (
            <p className="rounded-lg bg-emerald-500/10 px-3 py-2 text-sm text-emerald-300 ring-1 ring-emerald-500/30">Password updated. Use it next time you sign in.</p>
          ) : (
            <>
              <Field label="New password (min 4 chars)"><input className="input" type="password" value={pw} onChange={e => setPw(e.target.value)} /></Field>
              <Field label="Confirm password"><input className="input" type="password" value={pw2} onChange={e => setPw2(e.target.value)} /></Field>
              {pw2 && pw !== pw2 && <p className="text-xs text-rose-300">Passwords don't match.</p>}
            </>
          )}
        </Modal>
      )}
    </>
  )
}

export default function Layout({ children }: { children: ReactNode }) {
  const { user, logout } = useApp()
  const navigate = useNavigate()
  const [mobileOpen, setMobileOpen] = useState(false)
  const [paletteOpen, setPaletteOpen] = useState(false)
  const [syncError, setSyncError] = useState<string | null>(null)

  // Surface a Supabase write failure (e.g. RLS blocking, column mismatch).
  useEffect(() => {
    const onErr = (e: Event) => {
      setSyncError((e as CustomEvent).detail as string)
      window.setTimeout(() => setSyncError(null), 8000)
    }
    window.addEventListener('arul-sync-error', onErr)
    return () => window.removeEventListener('arul-sync-error', onErr)
  }, [])
  const [collapsed, setCollapsed] = useState(() => localStorage.getItem('arul-finance:sidebar') === 'collapsed')

  useEffect(() => {
    localStorage.setItem('arul-finance:sidebar', collapsed ? 'collapsed' : 'expanded')
  }, [collapsed])

  // Play a subtle sound on any button / menu-link / save action.
  useEffect(() => {
    const onClick = (e: MouseEvent) => {
      const el = (e.target as HTMLElement)?.closest?.('button, a[href], [role="button"], label.cursor-pointer') as HTMLElement | null
      if (!el || (el as HTMLButtonElement).disabled) return
      const important = el.classList.contains('btn-primary') || (el as HTMLButtonElement).type === 'submit'
      important ? playAction() : playClick()
    }
    document.addEventListener('click', onClick, true)
    return () => document.removeEventListener('click', onClick, true)
  }, [])

  // Global Ctrl/Cmd-K opens the command palette.
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k') {
        e.preventDefault()
        setPaletteOpen(o => !o)
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [])

  const brand = (
    <div className="flex items-center gap-2.5 px-1">
      <div className="grid h-9 w-9 place-items-center rounded-xl bg-gradient-to-br from-brand-400 to-brand-700 font-black text-white">₹</div>
      <div>
        <p className="text-sm font-bold leading-tight text-hd">Arul Finance</p>
        <p className="text-[11px] leading-tight text-slate-400">Management Suite</p>
      </div>
    </div>
  )

  return (
    <div className="min-h-screen bg-slate-950">
      <CommandPalette open={paletteOpen} onClose={() => setPaletteOpen(false)} />
      {syncError && (
        <div className="fixed inset-x-0 top-0 z-[60] flex justify-center p-2">
          <div className="max-w-lg rounded-xl bg-rose-600/95 px-4 py-2 text-sm text-white shadow-lg">
            Couldn’t save to the database — {syncError}. Changes are kept locally; check Supabase RLS / run phase3.sql.
          </div>
        </div>
      )}

      {/* Sidebar (desktop) */}
      <aside className={`fixed inset-y-0 left-0 hidden flex-col border-r border-slate-800 bg-slate-900/40 p-4 lg:flex ${collapsed ? 'w-20' : 'w-64'}`}>
        <div className="flex items-center justify-between">
          {collapsed
            ? <div className="mx-auto grid h-9 w-9 place-items-center rounded-xl bg-gradient-to-br from-brand-400 to-brand-700 font-black text-white">₹</div>
            : brand}
        </div>
        <button
          onClick={() => setCollapsed(c => !c)}
          title={collapsed ? 'Expand' : 'Collapse'}
          className="btn-ghost mt-4 !py-1.5 justify-center"
        >
          {collapsed ? <PanelLeftOpen size={16} /> : <><PanelLeftClose size={16} /> Collapse</>}
        </button>
        <div className="mt-4 flex-1 overflow-y-auto"><NavList collapsed={collapsed} /></div>
        <button onClick={() => { logout(); navigate('/login') }} title="Sign out" className={`btn-ghost mt-2 ${collapsed ? 'justify-center' : 'justify-start'}`}>
          <LogOut size={18} /> {!collapsed && 'Sign out'}
        </button>
      </aside>

      {/* Mobile drawer */}
      {mobileOpen && (
        <div className="fixed inset-0 z-40 lg:hidden">
          <div className="absolute inset-0 bg-black/60" onClick={() => setMobileOpen(false)} />
          <div className="absolute inset-y-0 left-0 flex w-72 flex-col border-r border-slate-800 bg-slate-900 p-4">
            <div className="flex items-center justify-between">{brand}<button onClick={() => setMobileOpen(false)}><X className="text-slate-400" /></button></div>
            <div className="mt-6 flex-1 overflow-y-auto"><NavList onNavigate={() => setMobileOpen(false)} /></div>
            {/* Secondary controls, kept off the top bar on phones. */}
            <div className="mt-2 flex items-center gap-1 border-t border-slate-800 pt-3 sm:hidden">
              <RefreshButton />
              <SoundToggle />
              <ChangePasswordButton />
              <DataSourceBadge />
            </div>
            <button onClick={() => { logout(); navigate('/login') }} className="btn-ghost mt-2 justify-start"><LogOut size={18} /> Sign out</button>
          </div>
        </div>
      )}

      {/* Main */}
      <div className={collapsed ? 'lg:pl-20' : 'lg:pl-64'}>
        <header className="sticky top-0 z-20 flex items-center justify-between border-b border-slate-800 bg-slate-950/80 px-4 py-3 backdrop-blur">
          <button className="lg:hidden" onClick={() => setMobileOpen(true)}><Menu className="text-slate-300" /></button>
          <button
            onClick={() => setPaletteOpen(true)}
            className="hidden items-center gap-2 rounded-xl border border-slate-800 bg-slate-900/60 px-3 py-1.5 text-sm text-slate-400 hover:bg-slate-800/60 lg:flex"
          >
            <Search size={15} /> Search…
            <kbd className="ml-6 rounded bg-slate-800 px-1.5 py-0.5 text-[10px]">Ctrl K</kbd>
          </button>
          <div className="flex items-center gap-1.5 sm:gap-2">
            <button onClick={() => setPaletteOpen(true)} className="grid h-9 w-9 place-items-center text-slate-300 lg:hidden"><Search size={20} /></button>
            {/* Secondary controls: on phones these live in the drawer to keep the bar uncluttered. */}
            <span className="hidden sm:contents"><RefreshButton /></span>
            <ThemePicker />
            <span className="hidden sm:contents"><SoundToggle /></span>
            <NavLink to="/messages" title="Messages" className={({ isActive }) => `grid h-9 w-9 place-items-center rounded-lg ${isActive ? 'text-brand-400' : 'text-slate-300 hover:bg-slate-800/60'}`}><MessageSquare size={20} /></NavLink>
            <NotificationBell />
            <span className="hidden sm:contents"><ChangePasswordButton /></span>
            <span className="hidden sm:contents"><DataSourceBadge /></span>
            <FinanceSwitcher />
            <div className="flex items-center gap-2">
              <div className="grid h-8 w-8 place-items-center rounded-full bg-brand-600 text-xs font-bold text-white">
                {user?.name?.[0]?.toUpperCase() ?? 'U'}
              </div>
              <div className="hidden sm:block">
                <p className="text-xs font-semibold text-hd">{user?.name}</p>
                <p className="text-[11px] capitalize text-slate-400">{user?.role}</p>
              </div>
            </div>
          </div>
        </header>

        <main className="mx-auto max-w-7xl px-4 py-6 pb-24 lg:pb-6">{children}</main>
      </div>

      {/* Mobile bottom nav */}
      <nav className="fixed inset-x-0 bottom-0 z-20 flex items-center justify-around border-t border-slate-800 bg-slate-950/95 py-1.5 backdrop-blur lg:hidden">
        {bottomNav.filter(n => canSeeRoute(user, n.to)).map(({ to, label, icon: Icon, end }) => (
          <NavLink key={to} to={to} end={end}
            className={({ isActive }) => `flex flex-col items-center gap-0.5 rounded-lg px-3 py-1 text-[10px] font-medium ${isActive ? 'text-brand-400' : 'text-slate-400'}`}>
            <Icon size={20} />{label}
          </NavLink>
        ))}
        <NavLink to="/menu"
          className={({ isActive }) => `flex flex-col items-center gap-0.5 rounded-lg px-3 py-1 text-[10px] font-medium ${isActive ? 'text-brand-400' : 'text-slate-400'}`}>
          <LayoutGrid size={20} />Menu
        </NavLink>
      </nav>
    </div>
  )
}
