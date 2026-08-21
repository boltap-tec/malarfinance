import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Phone, Lock, ShieldCheck, Users } from 'lucide-react'
import { useApp, CHOOSE_ROLE, type Role } from '../store/app'

export default function Login() {
  const login = useApp(s => s.login)
  const navigate = useNavigate()
  const [phone, setPhone] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [choose, setChoose] = useState(false) // phone is both MD and partner

  const attempt = (prefer?: Role) => {
    const err = login(phone, password, prefer)
    if (err === CHOOSE_ROLE) { setChoose(true); setError(null); return }
    if (err) { setError(err); return }
    navigate('/')
  }
  const submit = (e: React.FormEvent) => { e.preventDefault(); attempt() }

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
          <p className="mt-1 text-sm text-slate-400">Use your registered phone number.</p>

          {choose && (
            <div className="mt-5 rounded-2xl border border-brand-500/40 bg-brand-500/10 p-4">
              <p className="text-sm font-semibold text-hd">This number is both an MD and a partner.</p>
              <p className="mt-0.5 text-xs text-slate-400">How do you want to sign in?</p>
              <div className="mt-3 grid grid-cols-2 gap-2">
                <button type="button" onClick={() => attempt('md')} className="flex flex-col items-center gap-1 rounded-xl border border-slate-700 bg-slate-900 py-3 text-sm font-semibold text-hd hover:border-brand-500">
                  <ShieldCheck size={20} /> As MD
                </button>
                <button type="button" onClick={() => attempt('partner')} className="flex flex-col items-center gap-1 rounded-xl border border-slate-700 bg-slate-900 py-3 text-sm font-semibold text-hd hover:border-brand-500">
                  <Users size={20} /> As Partner
                </button>
              </div>
              <button type="button" onClick={() => setChoose(false)} className="mt-2 w-full text-center text-xs text-slate-500 hover:text-slate-300">Back</button>
            </div>
          )}

          <div className={`mt-6 ${choose ? 'pointer-events-none opacity-40' : ''}`}>
            <label className="label">Phone number</label>
            <div className="relative mt-1.5">
              <Phone size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
              <input
                className="input pl-9" inputMode="tel" value={phone}
                onChange={e => { setPhone(e.target.value); setError(null) }}
                placeholder="e.g. 9626262427"
              />
            </div>
          </div>

          <div className="mt-4">
            <label className="label">Password</label>
            <div className="relative mt-1.5">
              <Lock size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
              <input
                className="input pl-9" type="password" value={password}
                onChange={e => { setPassword(e.target.value); setError(null) }}
                placeholder="Default 1234"
              />
            </div>
          </div>

          {error && <p className="mt-3 rounded-lg bg-rose-500/10 px-3 py-2 text-sm text-rose-300 ring-1 ring-rose-500/30">{error}</p>}

          <button className="btn-primary mt-6 w-full">Sign in</button>
          <p className="mt-4 text-center text-xs text-slate-500">
            First time? Your password is <span className="font-semibold text-slate-400">1234</span> — change it after signing in.
          </p>
        </form>
      </div>
    </div>
  )
}
