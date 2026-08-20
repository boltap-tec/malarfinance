import { useMemo, useState } from 'react'
import { Settings as Cog, RotateCcw, Check, ListChecks } from 'lucide-react'
import {
  repo, getSettings, setSettings, revokeInterestForMonth, renumberCodes,
  getMandatory, setMandatory, FORM_FIELDS, type FormKind, type MandatoryConfig,
} from '../data/repository'
import { useApp } from '../store/app'
import { PageHeader, Card, EmptyState } from '../components/ui'
import { num, inr } from '../lib/format'

export default function Settings() {
  const role = useApp(s => s.user?.role)
  const s0 = getSettings()
  const [anyDate, setAnyDate] = useState(s0.postingAnyDate)
  const [dataLoadedDate, setDataLoadedDate] = useState(s0.dataLoadedDate)
  const [lastPostedDate, setLastPostedDate] = useState(s0.lastPostedDate)
  const [savedDates, setSavedDates] = useState(false)
  const [mand, setMand] = useState<MandatoryConfig>(getMandatory())
  const [renumberMsg, setRenumberMsg] = useState<string | null>(null)

  async function runRenumber() {
    const r = await renumberCodes()
    setRenumberMsg(`Renumbered ${r.deposits} deposit and ${r.other} other-finance codes to DEP/FIN format.`)
  }

  function toggleMand(kind: FormKind, key: string) {
    setMand(prev => {
      const set = new Set(prev[kind])
      set.has(key) ? set.delete(key) : set.add(key)
      const next = { ...prev, [kind]: [...set] }
      setMandatory(next)
      return next
    })
  }

  const finances = repo.finances()
  const [finance, setFinance] = useState(finances[0]?.Finance_Name ?? '')
  const [month, setMonth] = useState('')
  const [done, setDone] = useState<string | null>(null)
  const [tick, setTick] = useState(0)

  const months = useMemo(() => {
    const map = new Map<string, { count: number; total: number }>()
    for (const i of repo.interest(finance)) {
      if (!i.Month) continue
      const cur = map.get(i.Month) ?? { count: 0, total: 0 }
      cur.count++; cur.total += num(i.Interest_Amount)
      map.set(i.Month, cur)
    }
    return [...map.entries()].sort((a, b) => (a[0] < b[0] ? 1 : -1))
  }, [finance, tick])

  if (role !== 'md') return <EmptyState title="Only the MD can change settings" />

  async function revoke() {
    if (!finance || !month) return
    const n = await revokeInterestForMonth(finance, month)
    setDone(`Removed ${n} interest row(s) for ${finance} · ${month}. Restore any time from the Log.`)
    setMonth(''); setTick(t => t + 1)
  }

  return (
    <div>
      <PageHeader title="Settings" subtitle="Interest posting configuration & corrections." />

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <h3 className="mb-3 flex items-center gap-2 font-semibold text-white"><Cog size={16} /> Interest posting</h3>
          <label className="flex cursor-pointer items-start gap-3">
            <input type="checkbox" className="mt-0.5 accent-brand-500" checked={anyDate}
              onChange={e => { setAnyDate(e.target.checked); setSettings({ postingAnyDate: e.target.checked }) }} />
            <span>
              <span className="text-sm font-medium text-slate-200">Allow posting on any date (development)</span>
              <span className="mt-0.5 block text-xs text-slate-500">
                Off = posting only when the “To date” is a month end. A period already posted for a loan is never billed twice.
              </span>
            </span>
          </label>

          <div className="mt-4 grid grid-cols-2 gap-3 border-t border-slate-800 pt-4">
            <label className="block">
              <span className="label">Data loaded on</span>
              <input type="date" className="input mt-1" value={dataLoadedDate} onChange={e => { setDataLoadedDate(e.target.value); setSavedDates(false) }} />
            </label>
            <label className="block">
              <span className="label">Interest posted up to</span>
              <input type="date" className="input mt-1" value={lastPostedDate} onChange={e => { setLastPostedDate(e.target.value); setSavedDates(false) }} />
            </label>
          </div>
          <p className="mt-2 text-xs text-slate-500">
            When you import from an old source, set “posted up to” — the Interest screen then starts billing from the next day.
          </p>
          <button className="btn-ghost mt-3" onClick={() => { setSettings({ dataLoadedDate, lastPostedDate }); setSavedDates(true) }}>
            {savedDates ? <><Check size={15} /> Saved</> : 'Save dates'}
          </button>
        </Card>

        <Card>
          <h3 className="mb-3 flex items-center gap-2 font-semibold text-white"><RotateCcw size={16} /> Revoke a posted period</h3>
          <p className="mb-3 text-xs text-slate-500">Removes all interest rows for a finance + month. Fully reversible from the Log.</p>
          <div className="grid grid-cols-2 gap-3">
            <label className="block">
              <span className="label">Finance</span>
              <select className="input mt-1" value={finance} onChange={e => { setFinance(e.target.value); setMonth('') }}>
                {finances.map(f => <option key={f.Finance_Name} value={f.Finance_Name}>{f.Finance_Name}</option>)}
              </select>
            </label>
            <label className="block">
              <span className="label">Month</span>
              <select className="input mt-1" value={month} onChange={e => setMonth(e.target.value)}>
                <option value="">Select…</option>
                {months.map(([m, v]) => <option key={m} value={m}>{m} · {v.count} rows · {inr(v.total)}</option>)}
              </select>
            </label>
          </div>
          <button className="btn-primary mt-4 !bg-rose-600 hover:!bg-rose-500" disabled={!month} onClick={revoke}>
            <RotateCcw size={15} /> Revoke period
          </button>
          {done && (
            <div className="mt-3 flex items-center gap-2 rounded-xl bg-emerald-500/10 px-3 py-2 text-sm text-emerald-300 ring-1 ring-emerald-500/30">
              <Check size={15} /> {done}
            </div>
          )}
        </Card>
      </div>

      <Card className="mt-4">
        <h3 className="mb-1 flex items-center gap-2 font-semibold text-white"><RotateCcw size={16} /> Renumber deposit & other-finance codes</h3>
        <p className="mb-3 text-xs text-slate-500">
          Converts legacy codes (e.g. <code>Mal-D-1-Name</code>, <code>Mal-O-1-Name</code>) to the clean
          <code> DEP / FIN</code> scheme — one code per depositor / lender — and updates every reference.
        </p>
        <button className="btn-primary" onClick={runRenumber}>Renumber now</button>
        {renumberMsg && (
          <div className="mt-3 flex items-center gap-2 rounded-xl bg-emerald-500/10 px-3 py-2 text-sm text-emerald-300 ring-1 ring-emerald-500/30">
            <Check size={15} /> {renumberMsg}
          </div>
        )}
      </Card>

      <Card className="mt-4">
        <h3 className="mb-1 flex items-center gap-2 font-semibold text-white"><ListChecks size={16} /> Mandatory fields</h3>
        <p className="mb-3 text-xs text-slate-500">Tick the columns that must be filled before a loan, deposit or other-finance entry can be saved.</p>
        <div className="grid gap-4 sm:grid-cols-3">
          {(['loan', 'deposit', 'other'] as FormKind[]).map(kind => (
            <div key={kind}>
              <p className="mb-2 text-sm font-semibold capitalize text-slate-300">{kind === 'other' ? 'Other-finance' : kind}</p>
              <div className="space-y-1.5">
                {FORM_FIELDS[kind].map(f => (
                  <label key={f.key} className="flex cursor-pointer items-center gap-2 text-sm text-slate-300">
                    <input type="checkbox" className="accent-brand-500" checked={mand[kind].includes(f.key)} onChange={() => toggleMand(kind, f.key)} />
                    {f.label}
                  </label>
                ))}
              </div>
            </div>
          ))}
        </div>
      </Card>
    </div>
  )
}
