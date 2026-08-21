import { useEffect, useMemo, useState } from 'react'
import { Link, useParams, useNavigate, useSearchParams } from 'react-router-dom'
import { ArrowLeft, Phone, Mail, HandCoins, Plus, Percent } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import CustomerRepayModal from '../components/CustomerRepayModal'
import { inr, phone, fmtDate, num } from '../lib/format'

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
  const [repayModal, setRepayModal] = useState<'repay' | 'interest' | null>(null)

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

  // Opened from a row's Repay/Interest icon: auto-open the unified repay.
  useEffect(() => {
    if (!editable) return
    if (doParam === 'repay' || doParam === 'interest') setRepayModal(doParam)
  }, [doParam, editable]) // eslint-disable-line react-hooks/exhaustive-deps

  if (!customer) return <EmptyState title="Customer not found" />

  // Giving a loan needs a specific finance scope — adopt this customer's finance.
  const giveLoan = () => { setFinance(customer.Finance_Name); navigate(`/loans?new=1&stl=${encodeURIComponent(customer.Customer_STL_NO)}`) }

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
              {totals.outstanding > 0 && (
                <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setRepayModal('repay')}>
                  <HandCoins size={15} /> Repay loan
                </button>
              )}
              {totals.interestDue > 0 && (
                <button className="btn-ghost !py-1.5 text-amber-300 ring-1 ring-inset ring-amber-500/30" onClick={() => setRepayModal('interest')}>
                  <Percent size={15} /> Pay interest
                </button>
              )}
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

      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><HandCoins size={16} /> Loans</h3>
      {loans.length === 0 ? <EmptyState title="No loans for this customer" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Loan no.</Th><Th>Given</Th><Th right>Amount</Th><Th>Rate</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {loans.map(l => (
                  <tr key={l.Loan_No} className="hover:bg-slate-800/40">
                    <Td><Link to={`/loans/${encodeURIComponent(l.Loan_No)}`} className="font-medium text-brand-300">{l.Loan_No}</Link></Td>
                    <Td className="text-slate-400">{fmtDate(l.Loan_Given_Date)}</Td>
                    <Td right className="text-hd">{inr(num(l.Loan_Amount))}</Td>
                    <Td className="text-slate-300">{rateLabel(l)}</Td>
                    <Td right className="text-amber-300">{inr(num(l.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(l.Loan_Status)}>{l.Loan_Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      <h3 className="mb-2 mt-6 font-semibold text-hd">Interest history</h3>
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
                    <Td right className="text-hd">{inr(num(i.Interest_Amount))}</Td>
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

      {repayModal && (
        <CustomerRepayModal
          stl={customer.Customer_STL_NO}
          name={customer.Customer_Name}
          outstanding={totals.outstanding}
          pendingInterest={totals.interestDue}
          mode={repayModal}
          onClose={() => setRepayModal(null)}
          onSaved={() => { setRepayModal(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

function rateLabel(l: { Interest_Type?: string; Interest_Per_day_Per_Lakh?: number; Interest_Per_Month_Per_Lakh?: number }) {
  if (l.Interest_Type === 'Per_Month') return `₹${num(l.Interest_Per_Month_Per_Lakh)}/L·mo`
  return `₹${num(l.Interest_Per_day_Per_Lakh)}/L·day`
}
