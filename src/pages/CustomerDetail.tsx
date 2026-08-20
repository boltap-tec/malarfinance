import { useEffect, useMemo, useState } from 'react'
import { Link, useParams, useNavigate, useSearchParams } from 'react-router-dom'
import { ArrowLeft, Phone, Mail, HandCoins, Plus, Percent } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal } from '../components/ui'
import RepayModal from '../components/RepayModal'
import { inr, phone, fmtDate, num } from '../lib/format'
import type { Loan } from '../data/types'

export default function CustomerDetail() {
  const { stl = '' } = useParams()
  const id = decodeURIComponent(stl)
  const navigate = useNavigate()
  const role = useApp(s => s.user?.role)
  const setFinance = useApp(s => s.setFinance)
  const editable = canEdit(role)
  const [sp] = useSearchParams()
  const doParam = sp.get('do')
  const [tick, setTick] = useState(0)
  const [repay, setRepay] = useState<{ loan: Loan; interestOnly: boolean } | null>(null)
  const [chooser, setChooser] = useState<{ interestOnly: boolean } | null>(null)

  const { customer, loans, interest, totals } = useMemo(() => {
    const customer = repo.customer(id)
    const loans = repo.loansByCustomer(id)
    const interest = repo.interestByCustomer(id)
    const totals = {
      given: loans.reduce((s, l) => s + num(l.Loan_Amount), 0),
      outstanding: loans.reduce((s, l) => s + num(l.Outstand_Amount), 0),
      interestDue: interest.reduce((s, i) => s + num(i.Interest_Pending), 0),
    }
    return { customer, loans, interest, totals }
  }, [id, tick])

  // Opened from a row's Repay/Interest icon: auto-open the action for the
  // outstanding loan so the customer's details are already loaded.
  useEffect(() => {
    if (!editable || !doParam) return
    const outstanding = loans.filter(l => num(l.Outstand_Amount) > 0)
    if (outstanding.length) setRepay({ loan: outstanding[0], interestOnly: doParam === 'interest' })
  }, [doParam, editable]) // eslint-disable-line react-hooks/exhaustive-deps

  if (!customer) return <EmptyState title="Customer not found" />

  // Giving a loan needs a specific finance scope — adopt this customer's finance.
  const giveLoan = () => { setFinance(customer.Finance_Name); navigate(`/loans?new=1&stl=${encodeURIComponent(customer.Customer_STL_NO)}`) }

  // Repay / pay-interest from the header: use the single outstanding loan, else
  // let the user pick which one.
  const outstandingLoans = loans.filter(l => num(l.Outstand_Amount) > 0)
  const startRepay = (interestOnly: boolean) => {
    if (outstandingLoans.length === 1) setRepay({ loan: outstandingLoans[0], interestOnly })
    else if (outstandingLoans.length > 1) setChooser({ interestOnly })
  }

  return (
    <div>
      <Link to="/customers" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Customers</Link>
      <PageHeader
        title={customer.Customer_Name}
        subtitle={`${customer.Customer_STL_NO} · ${customer.Finance_Name}`}
        action={
          <div className="flex items-center gap-2">
            <Badge tone={statusTone(customer.Status)}>{customer.Status ?? '—'}</Badge>
            {editable && <>
              <button className="btn-primary !py-1.5" onClick={giveLoan}>
                <Plus size={15} /> Give loan
              </button>
              <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" disabled={outstandingLoans.length === 0} onClick={() => startRepay(false)}>
                <HandCoins size={15} /> Repay loan
              </button>
              <button className="btn-ghost !py-1.5 text-amber-300 ring-1 ring-inset ring-amber-500/30" disabled={outstandingLoans.length === 0} onClick={() => startRepay(true)}>
                <Percent size={15} /> Pay interest
              </button>
            </>}
          </div>
        }
      />

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span className="flex items-center gap-1.5"><Phone size={14} /> {phone(customer.Customer_Phone_No)}</span>
        {customer.Customer_Email && <span className="flex items-center gap-1.5"><Mail size={14} /> {customer.Customer_Email}</span>}
      </div>

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Total loan given" value={inr(totals.given)} tone="blue" />
        <StatCard label="Outstanding loan" value={inr(totals.outstanding)} tone="amber" />
        <StatCard label="Interest paid" value={inr(num(customer.Total_Interest_Paid))} tone="green" />
        <StatCard label="Interest due" value={inr(totals.interestDue)} tone="red" />
      </div>

      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-white"><HandCoins size={16} /> Loans</h3>
      {loans.length === 0 ? <EmptyState title="No loans for this customer" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Loan no.</Th><Th>Given</Th><Th right>Amount</Th><Th>Rate</Th><Th right>Outstanding</Th><Th>Status</Th>{editable && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {loans.map(l => (
                  <tr key={l.Loan_No} className="hover:bg-slate-800/40">
                    <Td><Link to={`/loans/${encodeURIComponent(l.Loan_No)}`} className="font-medium text-brand-300">{l.Loan_No}</Link></Td>
                    <Td className="text-slate-400">{fmtDate(l.Loan_Given_Date)}</Td>
                    <Td right className="text-white">{inr(num(l.Loan_Amount))}</Td>
                    <Td className="text-slate-300">{rateLabel(l)}</Td>
                    <Td right className="text-amber-300">{inr(num(l.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(l.Loan_Status)}>{l.Loan_Status ?? '—'}</Badge></Td>
                    {editable && (
                      <Td>
                        {num(l.Outstand_Amount) > 0 ? (
                          <div className="flex gap-1.5">
                            <button className="btn-ghost !px-2.5 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setRepay({ loan: l, interestOnly: false })}><HandCoins size={13} /> Repay</button>
                            <button className="btn-ghost !px-2.5 !py-1 text-xs text-amber-300 ring-1 ring-inset ring-amber-500/30" onClick={() => setRepay({ loan: l, interestOnly: true })}><Percent size={13} /> Interest</button>
                          </div>
                        ) : <span className="text-xs text-slate-600">—</span>}
                      </Td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      <h3 className="mb-2 mt-6 font-semibold text-white">Interest history</h3>
      {interest.length === 0 ? <EmptyState title="No interest postings yet" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Period</Th><Th right>Interest</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {interest.slice().reverse().map((i, k) => (
                  <tr key={k} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{i.Month}</Td>
                    <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
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

      {chooser && (
        <Modal title={chooser.interestOnly ? 'Pay interest — pick a loan' : 'Repay — pick a loan'} onClose={() => setChooser(null)}>
          <div className="space-y-1.5">
            {outstandingLoans.map(l => (
              <button key={l.Loan_No} onClick={() => { setRepay({ loan: l, interestOnly: chooser.interestOnly }); setChooser(null) }}
                className="flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm ring-1 ring-inset ring-transparent hover:bg-slate-800/60 hover:ring-brand-500/40">
                <span className="text-slate-100">{l.Loan_No} <span className="text-xs text-slate-500">· {fmtDate(l.Loan_Given_Date)}</span></span>
                <span className="text-amber-300">{inr(num(l.Outstand_Amount))} out</span>
              </button>
            ))}
          </div>
        </Modal>
      )}

      {repay && (
        <RepayModal
          loan={repay.loan}
          interestOnly={repay.interestOnly}
          onClose={() => setRepay(null)}
          onSaved={() => { setRepay(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

function rateLabel(l: { Interest_Type?: string; Interest_Per_day_Per_Lakh?: number; Interest_Per_Month_Per_Lakh?: number }) {
  if (l.Interest_Type === 'Per_Month') return `₹${num(l.Interest_Per_Month_Per_Lakh)}/L·mo`
  return `₹${num(l.Interest_Per_day_Per_Lakh)}/L·day`
}
