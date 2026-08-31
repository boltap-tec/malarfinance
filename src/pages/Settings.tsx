import { useMemo, useState } from 'react'
import { Settings as Cog, RotateCcw, Check, ListChecks, Tags, X, Plus, Boxes, Download, CloudUpload } from 'lucide-react'
import {
  repo, getSettings, setSettings, revokeInterestForMonth, isRepayInterest, updateFinance, renumberCodes,
  getMandatory, setMandatory, FORM_FIELDS, type FormKind, type MandatoryConfig,
  getLedgerCategories, setLedgerCategories, type LedgerCategories,
  datasetSnapshot,
} from '../data/repository'
import { useApp } from '../store/app'
import { PageHeader, Card, EmptyState } from '../components/ui'
import { num, inr } from '../lib/format'

export default function Settings() {
  const role = useApp(s => s.user?.role)
  const s0 = getSettings()
  const [anyDate, setAnyDate] = useState(s0.postingAnyDate)
  const [dataLoadedDate, setDataLoadedDate] = useState(s0.dataLoadedDate)
  const [savedDates, setSavedDates] = useState(false)
  // Per-finance interest cut-over (Finance_Details.Interest_Posted_Upto). Replaces
  // the old single global "interest posted up to" so finances post independently.
  const [cutFinance, setCutFinance] = useState(repo.finances()[0]?.Finance_Name ?? '')
  const [cutDate, setCutDate] = useState(repo.finances()[0]?.Interest_Posted_Upto ?? '')
  const [cutSaved, setCutSaved] = useState(false)
  const [mand, setMand] = useState<MandatoryConfig>(getMandatory())
  const [renumberMsg, setRenumberMsg] = useState<string | null>(null)
  const [cats, setCats] = useState<LedgerCategories>(getLedgerCategories())
  const [multiTakers, setMultiTakers] = useState(s0.chitMultipleTakersPerMonth)
  const [perMemberComm, setPerMemberComm] = useState(s0.chitPerMemberCommission)

  function updateCats(kind: keyof LedgerCategories, next: string[]) {
    const updated = { ...cats, [kind]: next }
    setCats(updated); setLedgerCategories(updated)
  }

  // Manual on-demand backup: download every table as one JSON file.
  function downloadBackup() {
    const stamp = new Date().toISOString().slice(0, 10)
    const blob = new Blob([datasetSnapshot()], { type: 'application/json' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `arul-finance-backup-${stamp}.json`
    document.body.appendChild(a); a.click(); a.remove()
    setTimeout(() => URL.revokeObjectURL(url), 1000)
  }

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
    // Monthly postings across all three interest tables — partial-repayment
    // interest (kept on revoke) is excluded from the count.
    const all: any[] = [...repo.interest(finance), ...repo.depositInterest(finance), ...repo.otherFinanceInterest(finance)]
    for (const i of all) {
      if (!i.Month || isRepayInterest(i.ID)) continue
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
    setDone(`Removed ${n} monthly interest posting(s) for ${finance} · ${month} (partial-repayment interest kept). Restore any time from the Log.`)
    setMonth(''); setTick(t => t + 1)
  }

  // Save the selected finance's own interest cut-over onto its Finance_Details row.
  async function saveCutover() {
    if (!cutFinance) return
    await updateFinance(cutFinance, { Interest_Posted_Upto: cutDate || undefined })
    setCutSaved(true)
  }

  return (
    <div>
      <PageHeader title="Settings" subtitle="Interest posting configuration & corrections." />

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <h3 className="mb-3 flex items-center gap-2 font-semibold text-hd"><Cog size={16} /> Interest posting</h3>
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

          <div className="mt-4 border-t border-slate-800 pt-4">
            <label className="block max-w-xs">
              <span className="label">Data loaded on</span>
              <input type="date" className="input mt-1" value={dataLoadedDate} onChange={e => { setDataLoadedDate(e.target.value); setSavedDates(false) }} />
            </label>
            <button className="btn-ghost mt-3" onClick={() => { setSettings({ dataLoadedDate }); setSavedDates(true) }}>
              {savedDates ? <><Check size={15} /> Saved</> : 'Save date'}
            </button>
          </div>

          <div className="mt-4 border-t border-slate-800 pt-4">
            <span className="label">Interest posted up to <span className="text-slate-500">· per finance</span></span>
            <p className="mt-0.5 mb-2 text-xs text-slate-500">
              Each finance has its <b>own</b> cut-over — the date its interest was already settled before go-live. The Interest screen bills each finance from the day after <i>its</i> date, so finances post independently.
            </p>
            <div className="grid grid-cols-2 gap-3">
              <label className="block">
                <span className="label">Finance</span>
                <select className="input mt-1" value={cutFinance}
                  onChange={e => { const v = e.target.value; setCutFinance(v); setCutDate(repo.finances().find(f => f.Finance_Name === v)?.Interest_Posted_Upto ?? ''); setCutSaved(false) }}>
                  {repo.finances().map(f => <option key={f.Finance_Name} value={f.Finance_Name}>{f.Finance_Name}</option>)}
                </select>
              </label>
              <label className="block">
                <span className="label">Posted up to</span>
                <input type="date" className="input mt-1" value={cutDate} onChange={e => { setCutDate(e.target.value); setCutSaved(false) }} />
              </label>
            </div>
            <button className="btn-ghost mt-3" onClick={saveCutover}>
              {cutSaved ? <><Check size={15} /> Saved {cutFinance}</> : `Save ${cutFinance || 'finance'} cut-over`}
            </button>
          </div>
        </Card>

        <Card>
          <h3 className="mb-3 flex items-center gap-2 font-semibold text-hd"><RotateCcw size={16} /> Revoke a posted period</h3>
          <p className="mb-3 text-xs text-slate-500">Removes the <b>monthly interest postings</b> for a finance + month so you can re-post. Partial-repayment interest is kept. Fully reversible from the Log.</p>
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
        <h3 className="mb-1 flex items-center gap-2 font-semibold text-hd"><RotateCcw size={16} /> Renumber deposit & other-finance codes</h3>
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
        <h3 className="mb-1 flex items-center gap-2 font-semibold text-hd"><CloudUpload size={16} /> Backup</h3>
        <p className="mb-3 text-xs text-slate-500">
          Keep a copy of all your data. Download a full backup any time, or set up an automatic <b>daily backup to Google Drive</b> (runs in your Google account — no server needed).
        </p>
        <button className="btn-primary" onClick={downloadBackup}><Download size={15} /> Download backup now (JSON)</button>
        <div className="mt-4 rounded-xl border border-slate-800 bg-slate-800/30 p-3 text-xs text-slate-400">
          <p className="mb-1 font-semibold text-slate-300">Daily Google Drive backup</p>
          <p>Uses a Google Apps Script (file <code>scripts/GoogleDriveBackup.gs</code> in your project). Once set up, it saves a single Excel file (<code>.xlsx</code>, one tab per table) to your Drive every day automatically. Setup steps are in that file:</p>
          <a className="mt-1 inline-block break-all text-brand-300 hover:underline" href="https://drive.google.com/drive/folders/1WzovmeJLP_RxKqXuEVF4e4jAAJ3NFxJF" target="_blank" rel="noreferrer">
            Backup Drive folder →
          </a>
        </div>
      </Card>

      <Card className="mt-4">
        <h3 className="mb-1 flex items-center gap-2 font-semibold text-hd"><Boxes size={16} /> Chit fund options</h3>
        <p className="mb-3 text-xs text-slate-500">Rules for the chit funds you run — auctions, takers and payouts.</p>
        <div className="space-y-3">
          <label className="flex cursor-pointer items-start gap-3">
            <input type="checkbox" className="mt-0.5 accent-brand-500" checked={multiTakers}
              onChange={e => { setMultiTakers(e.target.checked); setSettings({ chitMultipleTakersPerMonth: e.target.checked }) }} />
            <span>
              <span className="text-sm font-medium text-slate-200">Allow multiple members to take one month</span>
              <span className="mt-0.5 block text-xs text-slate-500">On = more than one member can take the same month's chit (e.g. two half-shares, or several members). Off = one taker per month.</span>
            </span>
          </label>
          <label className="flex cursor-pointer items-start gap-3">
            <input type="checkbox" className="mt-0.5 accent-brand-500" checked={perMemberComm}
              onChange={e => { setPerMemberComm(e.target.checked); setSettings({ chitPerMemberCommission: e.target.checked }) }} />
            <span>
              <span className="text-sm font-medium text-slate-200">Use each member's own commission %</span>
              <span className="mt-0.5 block text-xs text-slate-500">On = each member can have their own commission (e.g. 2%, 3%, or none). When that member takes the chit, their payout = auction bid − (their % × pot). Off = the chit-wide commission % applies to everyone.</span>
            </span>
          </label>
        </div>
      </Card>

      <Card className="mt-4">
        <h3 className="mb-1 flex items-center gap-2 font-semibold text-hd"><Tags size={16} /> Expense & other-income categories</h3>
        <p className="mb-3 text-xs text-slate-500">Used by “Add expense” and “Add other income” on the Ledger, and grouped in the Profit summary.</p>
        <div className="grid gap-4 sm:grid-cols-2">
          <CategoryEditor title="Expense categories" items={cats.expense} onChange={next => updateCats('expense', next)} />
          <CategoryEditor title="Other-income categories" items={cats.income} onChange={next => updateCats('income', next)} />
        </div>
      </Card>

      <Card className="mt-4">
        <h3 className="mb-1 flex items-center gap-2 font-semibold text-hd"><ListChecks size={16} /> Mandatory fields</h3>
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

function CategoryEditor({ title, items, onChange }: { title: string; items: string[]; onChange: (next: string[]) => void }) {
  const [val, setVal] = useState('')
  const add = () => {
    const v = val.trim()
    if (!v || items.some(i => i.toLowerCase() === v.toLowerCase())) { setVal(''); return }
    onChange([...items, v]); setVal('')
  }
  return (
    <div>
      <p className="mb-2 text-sm font-semibold text-slate-300">{title}</p>
      <div className="mb-2 flex flex-wrap gap-1.5">
        {items.map(c => (
          <span key={c} className="inline-flex items-center gap-1 rounded-full bg-slate-800/70 px-2.5 py-1 text-xs text-slate-200 ring-1 ring-inset ring-slate-700">
            {c}
            <button className="text-slate-500 hover:text-rose-300" onClick={() => onChange(items.filter(i => i !== c))}><X size={12} /></button>
          </span>
        ))}
        {items.length === 0 && <span className="text-xs text-slate-500">No categories yet.</span>}
      </div>
      <div className="flex gap-2">
        <input className="input" value={val} placeholder="Add category…" onChange={e => setVal(e.target.value)} onKeyDown={e => { if (e.key === 'Enter') add() }} />
        <button className="btn-ghost shrink-0" onClick={add}><Plus size={15} /></button>
      </div>
    </div>
  )
}
