import { Link } from 'react-router-dom'
import { navGroups } from '../nav'
import { PageHeader } from '../components/ui'

// Indane-style grouped tile launcher — keeps the menu compact on mobile.
export default function Menu() {
  return (
    <div>
      <PageHeader title="Menu" subtitle="All modules, grouped." />
      <div className="space-y-6">
        {navGroups.map(group => (
          <section key={group.title}>
            <h2 className="mb-2 text-sm font-semibold tracking-tight text-slate-300">{group.title}</h2>
            <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">
              {group.items.map(({ to, label, icon: Icon, desc }) => (
                <Link
                  key={to}
                  to={to}
                  className="card flex flex-col gap-2 p-4 transition hover:border-brand-600/50 hover:bg-slate-800/60"
                >
                  <span className="grid h-11 w-11 place-items-center rounded-xl bg-brand-500/15 text-brand-300 ring-1 ring-inset ring-brand-500/30">
                    <Icon size={20} />
                  </span>
                  <span className="text-sm font-semibold text-white">{label}</span>
                  {desc && <span className="text-xs text-slate-500">{desc}</span>}
                </Link>
              ))}
            </div>
          </section>
        ))}
      </div>
    </div>
  )
}
