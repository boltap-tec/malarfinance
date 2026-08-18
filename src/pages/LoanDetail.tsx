import { useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Calculator } from 'lucide-react'
import { repo } from '../data/repository'
import { computeInterest } from '../lib/interestEngine'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

export default function LoanDetail() {
  const { loanNo = '' } = useParams()
  const id = decodeURIComponent(loanNo)
  const loan = useMemo(() => repo.loan(id), [id])
  const interest = useMemo(() => repo.interestByLoan(id), [id])

  const today = new Date().toISOString().slice(0, 10)
  const monthStart = today.slice(0, 8) + '01'
  const [from, setFrom] = useState(monthStart)
  const [to, setTo] = useState(today)

  const preview = useMemo(() => (loan ? computeInterest(loan, from, to) : null), [loan, from, to])

  if (!loan) return <EmptyState title="Loan not found" />

  const billed = interest.reduce((s, i) => s + num(i.Interest_Amount), 0)
  const received = interest.reduce((s, i) => s + num(i.Amount_Received), 0)

  return (
    <div>
      <Link to="/loans" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Loans</Link>
      <PageHeader
        title={`Loan ${loan.Loan_No}`}
        subtitle={<Link to={`/customers/${encodeURIComponent(loan.Customer_STL_NO)}`} className="text-brand-300">{loan.Customer_Name} · {loan.Customer_STL_NO}</Link>}
        action={<Badge tone={statusTone(loan.Loan_Status)}>{loan.Loan_Status ?? '—'}</Badge>}
      />

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Loan amount" value={inr(num(loan.Loan_Amount))} tone="blue" />
        <StatCard label="Outstanding" value={inr(num(loan.Outstand_Amount))} tone="amber" />
        <StatCard label="Interest billed" value={inr(billed)} tone="slate" />
        <StatCard label="Interest received" value={inr(received)} tone="green" />
      </div>

      <div className="mt-4 grid gap-4 lg:grid-cols-3">
        <Card>
          <h3 className="mb-3 font-semibold text-white">Loan details</h3>
          <dl className="space-y-2 text-sm">
            <Row k="Given date" v={fmtDate(loan.Loan_Given_Date)} />
            <Row k="Interest type" v={loan.Interest_Type ?? '—'} />
            <Row k="Rate" v={loan.Interest_Type === 'Per_Month' ? `₹${num(loan.Interest_Per_Month_Per_Lakh)} / lakh / month` : `₹${num(loan.Interest_Per_day_Per_Lakh)} / lakh / day`} />
            <Row k="Referred partner" v={loan.Referred_Partner ?? '—'} />
            <Row k="Payment type" v={loan.Payment_Type ?? '—'} />
            <Row k="Repaid" v={inr(num(loan.Repaid_Amount))} />
          </dl>
        </Card>

        {/* Interest calculator — uses the exact engine ported from Apps Script */}
        <Card className="lg:col-span-2">
          <h3 className="mb-3 flex items-center gap-2 font-semibold text-white"><Calculator size={16} /> Interest calculator</h3>
          <div className="flex flex-wrap gap-3">
            <div>
              <label className="label">From</label>
              <input type="date" className="input mt-1" value={from} onChange={e => setFrom(e.target.value)} />
            </div>
            <div>
              <label className="label">To</label>
              <input type="date" className="input mt-1" value={to} onChange={e => setTo(e.target.value)} />
            </div>
          </div>
          {preview && (
            <div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
              <MiniStat k="Billing days" v={String(preview.noOfDays)} />
              <MiniStat k="Raw interest" v={inr(Math.round(preview.rawInterest))} />
              <MiniStat k="Rounded (₹10)" v={inr(preview.interest)} accent />
              <MiniStat k="Month" v={preview.month} />
            </div>
          )}
          <p className="mt-3 text-xs text-slate-500">
            Same formula as your Google Sheet engine: actual-from = later of loan date / from-date, inclusive days, rounded to nearest ₹10.
          </p>
        </Card>
      </div>

      <h3 className="mb-2 mt-6 font-semibold text-white">Interest schedule</h3>
      {interest.length === 0 ? <EmptyState title="No interest posted for this loan yet" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Period</Th><Th right>Days</Th><Th right>Interest</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {interest.slice().reverse().map((i, k) => (
                  <tr key={k} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{i.Month}</Td>
                    <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                    <Td right className="text-slate-400">{num(i.No_Days)}</Td>
                    <Td right className="text-white">{inr(num(i.Interest_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                    <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                    <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}
    </div>
  )
}

function Row({ k, v }: { k: string; v: string }) {
  return <div className="flex justify-between border-b border-slate-800/60 pb-2"><dt className="text-slate-400">{k}</dt><dd className="font-medium text-slate-200">{v}</dd></div>
}
function MiniStat({ k, v, accent }: { k: string; v: string; accent?: boolean }) {
  return (
    <div className="rounded-xl bg-slate-800/40 p-3">
      <p className="label">{k}</p>
      <p className={`mt-1 text-lg font-bold ${accent ? 'text-brand-300' : 'text-white'}`}>{v}</p>
    </div>
  )
}
