import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Phone, Lock, ShieldCheck, Users, HardHat, ArrowLeft } from 'lucide-react'
import { useApp, type Role } from '../store/app'

const ROLES: { key: Role; label: string; hint: string; icon: typeof ShieldCheck }[] = [
  { key: 'md', label: 'MD', hint: 'Full control', icon: ShieldCheck },
  { key: 'partner', label: 'Partner', hint: 'Their loans', icon: Users },
  { key: 'worker', label: 'Worker', hint: 'Chosen menus', icon: HardHat },
]

export default function Login() {
  const login = useApp(s => s.login)
  const navigate = useNavigate()
  const [role, setRole] = useState<Role | null>(null)   // pick MD / Partner / Worker first
  const [phone, setPhone] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState<string | null>(null)

  const submit = (e: React.FormEvent) => {
    e.preventDefault()
    if (!role) return
    const err = login(role, phone, password)
    if (err) { setError(err); return }
    navigate('/')
  }
  const roleLabel = ROLES.find(r => r.key === role)?.label

  return (
    <div className="grid min-h-screen lg:grid-cols-2">
      {/* Brand panel — fixed dark gradient in every theme so the white text always reads */}
      <div className="relative hidden flex-col justify-between overflow-hidden bg-gradient-to-br from-[#1b3198] via-[#151d47] to-[#020617] p-10 lg:flex">
        <div className="flex items-center gap-3">
          <div className="grid h-11 w-11 place-items-center rounded-2xl bg-white/10 text-2xl font-black text-white">₹</div>
          <span className="text-lg font-bold text-white">Arul Finance</span>
        </div>
        <div>
          <h1 className="text-4xl font-extrabold leading-tight text-white">Run your finance house<br />from one screen.</h1>
          <p className="mt-4 max-w-md text-brand-100/80">
            Loans, automatic interest posting, deposits, chit funds and a live ledger —
            the whole operation, on web today and your phone tomorrow.
          </p>
          <div className="mt-8 flex gap-6 text-brand-100/70">
            <div><p className="text-2xl font-bold text-white">MD</p><p className="text-xs">Full control</p></div>
            <div><p className="text-2xl font-bold text-white">Partner</p><p className="text-xs">Their loans</p></div>
            <div><p className="text-2xl font-bold text-white">Worker</p><p className="text-xs">Chosen menus</p></div>
          </div>
        </div>
        <p className="text-xs text-brand-100/50">© {new Date().getFullYear()} Arul Finance · Management Suite</p>
      </div>

      {/* Form */}
      <div className="grid place-items-center bg-slate-950 p-6">
        <form onSubmit={submit} className="w-full max-w-sm">
          <div className="mb-8 lg:hidden">
            <div className="grid h-12 w-12 place-items-center rounded-2xl bg-gradient-to-br from-brand-400 to-brand-700 text-2xl font-black text-white">₹</div>
          </div>
          <h2 className="text-2xl font-bold text-hd">Sign in</h2>

          {!role ? (
            <>
              <p className="mt-1 text-sm text-slate-400">Who are you signing in as?</p>
              <div className="mt-6 grid gap-3">
                {ROLES.map(r => (
                  <button
                    key={r.key} type="button"
                    onClick={() => { setRole(r.key); setError(null) }}
                    className="flex items-center gap-3 rounded-2xl border border-slate-700 bg-slate-900 p-4 text-left hover:border-brand-500"
                  >
                    <span className="grid h-10 w-10 place-items-center rounded-xl bg-brand-500/15 text-brand-300"><r.icon size={20} /></span>
                    <span>
                      <span className="block text-sm font-semibold text-hd">{r.label}</span>
                      <span className="block text-xs text-slate-400">{r.hint}</span>
                    </span>
                  </button>
                ))}
              </div>
            </>
          ) : (
            <>
              <button type="button" onClick={() => { setRole(null); setError(null) }} className="mt-2 inline-flex items-center gap-1 text-xs text-slate-400 hover:text-slate-200">
                <ArrowLeft size={13} /> Signing in as <span className="font-semibold text-brand-300">{roleLabel}</span> — change
              </button>

              <div className="mt-5">
                <label className="label">Phone number</label>
                <div className="relative mt-1.5">
                  <Phone size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
                  <input
                    className="input pl-9" inputMode="tel" value={phone} autoFocus
                    onChange={e => { setPhone(e.target.value); setError(null) }}
                    placeholder="e.g. 9626262427"
                  />
                </div>
              </div>

              <div className="mt-4">
                <label className="label">PIN</label>
                <div className="relative mt-1.5">
                  <Lock size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
                  <input
                    className="input pl-9" type="password" inputMode="numeric" value={password}
                    onChange={e => { setPassword(e.target.value); setError(null) }}
                    placeholder="Default 1234"
                  />
                </div>
              </div>

              {error && <p className="mt-3 rounded-lg bg-rose-500/10 px-3 py-2 text-sm text-rose-300 ring-1 ring-rose-500/30">{error}</p>}

              <button className="btn-primary mt-6 w-full">Sign in</button>
              <p className="mt-4 text-center text-xs text-slate-500">
                First time? Your PIN is <span className="font-semibold text-slate-400">1234</span> — change it after signing in.
              </p>
            </>
          )}
        </form>
      </div>
    </div>
  )
}
