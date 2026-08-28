import { useEffect, useMemo, useState } from 'react'
import { Link, useParams, useNavigate, useSearchParams } from 'react-router-dom'
import { ArrowLeft, Phone, Mail, HandCoins, Plus, Percent, IndianRupee, BookText, Pencil } from 'lucide-react'
import { repo, repayCustomer, updateCustomer } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Tabs, Modal, Field } from '../components/ui'
import CustomerRepayModal from '../components/CustomerRepayModal'
import CustomerInterestPayModal from '../components/CustomerInterestPayModal'
import LedgerTable from '../components/LedgerTable'
import ReminderButton from '../components/ReminderButton'
import { inr, phone, fmtDate, num, monthName, monthKey } from '../lib/format'

type TabKey = 'loans' | 'interest' | 'ledger'

export default function CustomerDetail() {
  const { stl = '' } = useParams()
  const id = decodeURIComponent(stl)
  const navigate = useNavigate()
  const role = useApp(s => s.user?.role)
  const finance = useApp(s => s.finance)
  const setFinance = useApp(s => s.setFinance)
  // "All finances" is view-only — switch to this customer's finance to transact.
  const viewOnly = finance === 'ALL'
  const editable = canEdit(role) && !viewOnly
  const isMd = role === 'md' && !viewOnly
  const [sp] = useSearchParams()
  const doParam = sp.get('do')
  const [tick, setTick] = useState(0)
  const [tab, setTab] = useState<TabKey>('loans')
  const [repayModal, setRepayModal] = useState(false)
  const [payInterest, setPayInterest] = useState(false)
  const [editProfile, setEditProfile] = useState(false)

  const { customer, loans, interest, ledger, totals } = useMemo(() => {
    const customer = repo.customer(id)
    const loans = repo.loansByCustomer(id)
    const interest = repo.interestByCustomer(id)
    const ledger = repo.ledgerByCustomer(id)
    const totals = {
      given: loans.reduce((s, l) => s + num(l.Loan_Amount), 0),
      outstanding: loans.reduce((s, l) => s + num(l.Outstand_Amount), 0),
      interestDue: interest.reduce((s, i) => s + num(i.Interest_Pending), 0),
    }
    return { customer, loans, interest, ledger, totals }
  }, [id, tick])

  // Opened from a row's Repay/Interest icon: auto-open the right action + tab.
  useEffect(() => {
    if (!editable) return
    if (doParam === 'repay') setRepayModal(true)
    if (doParam === 'interest') { setTab('interest'); setPayInterest(true) }
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
            <ReminderButton
              header={`${customer.Customer_STL_NO}-${customer.Customer_Name}`}
              phone={customer.Customer_Phone_No}
              items={interest.map(i => ({ month: i.Month, amount: num(i.Interest_Amount), pending: num(i.Interest_Pending) }))}
            />
            {editable && <>
              <button className="btn-ghost !py-1.5" onClick={() => setEditProfile(true)}>
                <Pencil size={15} /> Edit
              </button>
              <button className="btn-primary !py-1.5" onClick={giveLoan}>
                <Plus size={15} /> Give loan
              </button>
              {totals.outstanding > 0 && (
                <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setRepayModal(true)}>
                  <HandCoins size={15} /> Repay loan
                </button>
              )}
              {totals.interestDue > 0 && (
                <button className="btn-ghost !py-1.5 text-amber-300 ring-1 ring-inset ring-amber-500/30" onClick={() => { setTab('interest'); setPayInterest(true) }}>
                  <Percent size={15} /> Pay interest
                </button>
              )}
            </>}
          </div>
        }
      />

      {canEdit(role) && viewOnly && (
        <p className="mb-4 text-xs text-amber-300/80">
          Viewing all finances (read-only).{' '}
          <button className="font-semibold text-brand-300 underline hover:text-brand-200" onClick={() => setFinance(customer.Finance_Name)}>Switch to {customer.Finance_Name}</button>{' '}to give a loan, repay or pay interest.
        </p>
      )}

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span className="flex items-center gap-1.5"><Phone size={14} /> {phone(customer.Customer_Phone_No)}</span>
        {customer.Customer_Email && <span className="flex items-center gap-1.5"><Mail size={14} /> {customer.Customer_Email}</span>}
      </div>

      <div className="mb-6 grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Total loan given" value={inr(totals.given)} tone="blue" />
        <StatCard label="Outstanding loan" value={inr(totals.outstanding)} tone="amber" />
        <StatCard label="Interest paid" value={inr(num(customer.Total_Interest_Paid))} tone="green" />
        <StatCard label="Interest due" value={inr(totals.interestDue)} tone="red" />
      </div>

      <Tabs<TabKey>
        active={tab}
        onChange={setTab}
        tabs={[
          { key: 'loans', label: <span className="flex items-center gap-1.5"><HandCoins size={14} /> Loans</span>, badge: loans.length || '' },
          { key: 'interest', label: <span className="flex items-center gap-1.5"><Percent size={14} /> Interest</span>, badge: totals.interestDue > 0 ? '!' : '' },
          { key: 'ledger', label: <span className="flex items-center gap-1.5"><BookText size={14} /> Ledger</span>, badge: ledger.length || '' },
        ]}
      />

      {tab === 'loans' && (
        loans.length === 0 ? <EmptyState title="No loans for this customer" /> : (
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
        )
      )}

      {tab === 'interest' && (
        interest.length === 0 ? <EmptyState title="No interest postings yet" /> : (
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Month</Th><Th>Period</Th><Th right>Interest</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th>{editable && <Th>Collect</Th>}</tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {interest.slice().sort((a, b) => (monthKey(b.Month) - monthKey(a.Month)) || String(b.To_Date ?? '').localeCompare(String(a.To_Date ?? ''))).map((i, k) => (
                    <tr key={k} className="hover:bg-slate-800/40">
                      <Td className="text-slate-300">{monthName(i.Month)}</Td>
                      <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                      <Td right className="text-hd">{inr(num(i.Interest_Amount))}</Td>
                      <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                      <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                      <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                      {editable && (
                        <Td>
                          {num(i.Interest_Pending) > 0
                            ? <button title="Collect interest" className="btn-ghost !px-2.5 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setPayInterest(true)}><IndianRupee size={13} /> Pay</button>
                            : <span className="text-xs text-slate-600">—</span>}
                        </Td>
                      )}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        )
      )}

      {tab === 'ledger' && (
        <LedgerTable
          rows={ledger}
          canManage={isMd}
          emptyHint="Loan, repayment and interest movements appear here."
          onChanged={() => setTick(t => t + 1)}
        />
      )}

      {repayModal && (
        <CustomerRepayModal
          stl={customer.Customer_STL_NO}
          name={customer.Customer_Name}
          outstanding={totals.outstanding}
          pendingInterest={totals.interestDue}
          mode="repay"
          onClose={() => setRepayModal(false)}
          onSaved={() => { setRepayModal(false); setTick(t => t + 1) }}
        />
      )}

      {payInterest && (
        <CustomerInterestPayModal
          name={customer.Customer_Name}
          rows={interest}
          onPay={(amount, date, payType, note) => repayCustomer({ stl: customer.Customer_STL_NO, principal: 0, interest: amount, date, payType, note })}
          onClose={() => setPayInterest(false)}
          onSaved={() => { setPayInterest(false); setTick(t => t + 1) }}
        />
      )}

      {editProfile && (
        <EditCustomerModal
          customer={customer}
          onClose={() => setEditProfile(false)}
          onSaved={() => { setEditProfile(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// Edit the customer's own details (name / phone / email / Aadhaar / status).
function EditCustomerModal({ customer, onClose, onSaved }: { customer: any; onClose: () => void; onSaved: () => void }) {
  const [name, setName] = useState(customer.Customer_Name ?? '')
  const [phoneNo, setPhoneNo] = useState(String(customer.Customer_Phone_No ?? ''))
  const [email, setEmail] = useState(customer.Customer_Email ?? '')
  const [adhar, setAdhar] = useState(String(customer.Customer_Adhar_No ?? ''))
  const [status, setStatus] = useState(customer.Status ?? 'Active')
  const [busy, setBusy] = useState(false)
  const valid = name.trim().length > 0 && !busy

  async function save() {
    if (!valid) return
    setBusy(true)
    await updateCustomer(customer.Customer_STL_NO, {
      Customer_Name: name.trim(),
      Customer_Phone_No: phoneNo.trim() || undefined,
      Customer_Email: email.trim() || undefined,
      Customer_Adhar_No: adhar.trim() || undefined,
      Status: status,
    })
    onSaved()
  }

  return (
    <Modal title={`Edit — ${customer.Customer_Name}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid} onClick={save}>Save changes</button>
    </>}>
      <Field label="Customer name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Phone"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
        <Field label="Aadhaar no."><input className="input" value={adhar} onChange={e => setAdhar(e.target.value)} /></Field>
      </div>
      <Field label="Email"><input className="input" value={email} onChange={e => setEmail(e.target.value)} /></Field>
      <Field label="Status">
        <select className="input" value={status} onChange={e => setStatus(e.target.value)}>
          <option>Active</option><option>Inactive</option>
        </select>
      </Field>
    </Modal>
  )
}

function rateLabel(l: { Interest_Type?: string; Interest_Per_day_Per_Lakh?: number; Interest_Per_Month_Per_Lakh?: number }) {
  if (l.Interest_Type === 'Per_Month') return `₹${num(l.Interest_Per_Month_Per_Lakh)}/L·mo`
  return `₹${num(l.Interest_Per_day_Per_Lakh)}/L·day`
}
