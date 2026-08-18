import { useMemo, useState } from 'react'
import { Zap, Check, Percent } from 'lucide-react'
import { repo, appendInterestRows } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { previewPosting, toInterestRow, InterestPreview } from '../lib/interestEngine'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

export default function Interest() {
  const finance = useApp(s => s.finance)
  const f = financeFilter(finance)

  const today = new Date()
  const firstOfMonth = new Date(today.getFullYear(), today.getMonth(), 1).toISOString().slice(0, 10)
  const endOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0).toISOString().slice(0, 10)

  const [from, setFrom] = useState(firstOfMonth)
  const [to, setTo] = useState(endOfMonth)
  const [posted, setPosted] = useState<number | null>(null)
  const [tab, setTab] = useState<'run' | 'history'>('run')

  const loans = useMemo(() => repo.loans(f), [f])
  const preview = useMemo<InterestPreview[]>(() => previewPosting(loans, from, to), [loans, from, to])
  const previewTotal = preview.reduce((s, p) => s + p.interest, 0)

  const history = useMemo(() => repo.interest(f), [f, posted])
  const totals = useMemo(() => ({
    billed: history.reduce((s, i) => s + num(i.Interest_Amount), 0),
    collected: history.reduce((s, i) => s + num(i.Amount_Received), 0),
    pending: history.reduce((s, i) => s + num(i.Interest_Pending), 0),
  }), [history])

  async function runPosting() {
    const rows = preview.map(toInterestRow)
    await appendInterestRows(rows)
    setPosted(rows.length)
  }

  return (
    <div>
      <PageHeader title="Interest engine" subtitle="Auto-generate monthly interest for every active loan — preview, then post." />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Total billed" value={inr(totals.billed)} tone="blue" icon={<Percent size={18} />} />
        <StatCard label="Collected" value={inr(totals.collected)} tone="green" />
        <StatCard label="Pending" value={inr(totals.pending)} tone="amber" />
      </div>

      <div className="mb-4 flex gap-1 rounded-xl bg-slate-800/60 p-1 w-fit">
        {(['run', 'history'] as const).map(t => (
          <button key={t} onClick={() => setTab(t)}
            className={`rounded-lg px-4 py-1.5 text-sm font-medium capitalize ${tab === t ? 'bg-brand-600 text-white' : 'text-slate-300'}`}>
            {t === 'run' ? 'Run posting' : 'History'}
          </button>
        ))}
      </div>

      {tab === 'run' ? (
        <>
          <Card className="mb-4">
            <div className="flex flex-wrap items-end gap-4">
              <div>
                <label className="label">From date</label>
                <input type="date" className="input mt-1" value={from} onChange={e => { setFrom(e.target.value); setPosted(null) }} />
              </div>
              <div>
                <label className="label">To date</label>
                <input type="date" className="input mt-1" value={to} onChange={e => { setTo(e.target.value); setPosted(null) }} />
              </div>
              <div className="flex-1" />
              <div className="text-right">
                <p className="label">Projected interest</p>
                <p className="text-2xl font-bold text-brand-300">{inr(previewTotal)}</p>
                <p className="text-xs text-slate-500">{preview.length} active loans</p>
              </div>
              <button className="btn-primary" onClick={runPosting} disabled={preview.length === 0}>
                <Zap size={16} /> Post interest
              </button>
            </div>
            {posted !== null && (
              <div className="mt-4 flex items-center gap-2 rounded-xl bg-emerald-500/10 px-4 py-3 text-sm text-emerald-300 ring-1 ring-emerald-500/30">
                <Check size={16} /> Posted {posted} interest rows for this period. They now appear in each loan and in History.
              </div>
            )}
          </Card>

          {preview.length === 0 ? <EmptyState title="No active loans to bill in this window" hint="Adjust the dates or activate loans." /> : (
            <Card className="!p-0 overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead className="border-b border-slate-800 bg-slate-900/60">
                    <tr><Th>Loan</Th><Th>Customer</Th><Th>Type</Th><Th right>Days</Th><Th right>Raw</Th><Th right>Interest (₹10)</Th></tr>
                  </thead>
                  <tbody className="divide-y divide-slate-800">
                    {preview.map((p, i) => (
                      <tr key={i} className="hover:bg-slate-800/40">
                        <Td className="font-medium text-brand-300">{p.loan.Loan_No}</Td>
                        <Td>
                          <p className="text-slate-200">{p.loan.Customer_Name}</p>
                          <p className="text-xs text-slate-500">{p.loan.Customer_STL_NO}</p>
                        </Td>
                        <Td><Badge tone="slate">{p.loan.Interest_Type}</Badge></Td>
                        <Td right className="text-slate-400">{p.noOfDays}</Td>
                        <Td right className="text-slate-400">{inr(Math.round(p.rawInterest))}</Td>
                        <Td right className="font-semibold text-white">{inr(p.interest)}</Td>
                      </tr>
                    ))}
                  </tbody>
                  <tfoot>
                    <tr className="border-t border-slate-700 bg-slate-900/60">
                      <Td className="font-semibold text-slate-300">Total</Td><Td>{''}</Td><Td>{''}</Td><Td>{''}</Td><Td>{''}</Td>
                      <Td right className="text-lg font-bold text-brand-300">{inr(previewTotal)}</Td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            </Card>
          )}
        </>
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Customer</Th><Th>Loan</Th><Th right>Interest</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {history.slice().reverse().slice(0, 200).map((i, k) => (
                  <tr key={k} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{i.Month}</Td>
                    <Td className="text-slate-200">{i.Customer_Name}</Td>
                    <Td className="text-slate-400">{i.Loan_No}</Td>
                    <Td right className="text-white">{inr(num(i.Interest_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                    <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                    <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {history.length === 0 && <div className="p-6"><EmptyState title="No interest history yet" hint="Run a posting to generate rows." /></div>}
        </Card>
      )}
    </div>
  )
}
