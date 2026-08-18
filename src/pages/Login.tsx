import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { ShieldCheck, Users } from 'lucide-react'
import { useApp, Role } from '../store/app'

export default function Login() {
  const login = useApp(s => s.login)
  const navigate = useNavigate()
  const [name, setName] = useState('')
  const [role, setRole] = useState<Role>('owner')

  const submit = (e: React.FormEvent) => {
    e.preventDefault()
    login(name.trim() || (role === 'owner' ? 'Owner' : 'Partner'), role)
    navigate('/')
  }

  return (
    <div className="grid min-h-screen lg:grid-cols-2">
      {/* Brand panel */}
      <div className="relative hidden flex-col justify-between overflow-hidden bg-gradient-to-br from-brand-800 via-brand-900 to-slate-950 p-10 lg:flex">
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
            <div><p className="text-2xl font-bold text-white">40+</p><p className="text-xs">Customers</p></div>
            <div><p className="text-2xl font-bold text-white">58</p><p className="text-xs">Loans tracked</p></div>
            <div><p className="text-2xl font-bold text-white">Auto</p><p className="text-xs">Interest engine</p></div>
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
          <h2 className="text-2xl font-bold text-white">Welcome back</h2>
          <p className="mt-1 text-sm text-slate-400">Sign in to your finance dashboard.</p>

          <div className="mt-6 grid grid-cols-2 gap-3">
            {([['owner', 'Owner / MD', ShieldCheck], ['partner', 'Partner', Users]] as const).map(([r, label, Icon]) => (
              <button type="button" key={r} onClick={() => setRole(r)}
                className={`flex flex-col items-center gap-2 rounded-2xl border p-4 text-sm font-semibold transition ${
                  role === r ? 'border-brand-500 bg-brand-500/10 text-white' : 'border-slate-800 text-slate-400 hover:border-slate-700'
                }`}>
                <Icon size={22} />{label}
              </button>
            ))}
          </div>

          <div className="mt-5">
            <label className="label">Your name</label>
            <input className="input mt-1.5" value={name} onChange={e => setName(e.target.value)}
              placeholder={role === 'owner' ? 'e.g. Malarvizhi' : 'e.g. Arul Sampath'} />
          </div>

          <button className="btn-primary mt-6 w-full">Sign in</button>
          <p className="mt-4 text-center text-xs text-slate-500">
            Demo sign-in. Real login (email / OTP) connects when Supabase is wired up.
          </p>
        </form>
      </div>
    </div>
  )
}
