import { useMemo, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import { Search, Plus, Trash2 } from 'lucide-react'
import { repo, addLoan, addCustomer, deleteLoan, missingRequired, FORM_FIELDS } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, Badge, statusTone, Th, Td, EmptyState, Modal, Field, ConfirmModal, AmountHint } from '../components/ui'
import { inr, fmtDate, num, phone } from '../lib/format'
import { useCreateParam } from '../lib/useCreateParam'
import type { Loan, Customer } from '../data/types'

const FILTERS = ['All', 'Active', 'Closed'] as const

export default function Loans() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const [q, setQ] = useState('')
  const [filter, setFilter] = useState<typeof FILTERS[number]>('All')
  const isMd = role === 'md'
  const [open, setOpen] = useCreateParam()
  const [sp] = useSearchParams()
  const initialStl = sp.get('stl') ?? ''
  const [tick, setTick] = useState(0)
  const [del, setDel] = useState<Loan | null>(null)

  const { rows, totalOut, totalGiven } = useMemo(() => {
    let list = repo.loans(financeFilter(finance))
    if (filter !== 'All') list = list.filter(l => (l.Loan_Status ?? '').toLowerCase() === filter.toLowerCase())
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(l =>
      l.Loan_No?.toLowerCase().includes(s) || l.Customer_Name?.toLowerCase().includes(s) || l.Customer_STL_NO?.toLowerCase().includes(s))
    // Outstanding (active) loans first, then newest given.
    list = list.slice().sort((a, b) => {
      const ao = num(a.Outstand_Amount) > 0 ? 1 : 0, bo = num(b.Outstand_Amount) > 0 ? 1 : 0
      return ao !== bo ? bo - ao : new Date(b.Loan_Given_Date ?? 0).getTime() - new Date(a.Loan_Given_Date ?? 0).getTime()
    })
    return {
      rows: list,
      totalOut: list.reduce((s2, l) => s2 + num(l.Outstand_Amount), 0),
      totalGiven: list.reduce((s2, l) => s2 + num(l.Loan_Amount), 0),
    }
  }, [finance, q, filter, tick])

  return (
    <div>
      <PageHeader
        title="Loans"
        subtitle={`${rows.length} loans · ${inr(totalGiven)} given · ${inr(totalOut)} outstanding`}
        action={canEdit(role) &&
          <button className="btn-primary" onClick={() => setOpen(true)} disabled={finance === 'ALL'}>
            <Plus size={16} /> New loan
          </button>
        }
      />

      {canEdit(role) && finance === 'ALL' && <p className="mb-3 text-xs text-amber-300/80">Pick a single finance in the switcher to give a loan.</p>}

      <Card className="mb-4 !p-3">
        <div className="flex flex-wrap items-center gap-3">
          <div className="relative flex-1 min-w-[220px]">
            <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
            <input className="input pl-9" placeholder="Search loan no., customer, STL…" value={q} onChange={e => setQ(e.target.value)} />
          </div>
          <div className="flex gap-1 rounded-xl bg-slate-800/60 p-1">
            {FILTERS.map(fl => (
              <button key={fl} onClick={() => setFilter(fl)}
                className={`rounded-lg px-3 py-1.5 text-sm font-medium ${filter === fl ? 'bg-brand-600 text-white' : 'text-slate-300'}`}>{fl}</button>
            ))}
          </div>
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No loans found" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th sticky>Loan no.</Th><Th>Customer</Th><Th>Given</Th><Th right>Amount</Th><Th>Rate</Th><Th right>Outstanding</Th><Th>Status</Th>{isMd && <Th>Del</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(l => (
                  <tr key={l.Loan_No} className="group hover:bg-slate-800/40">
                    <Td sticky><Link to={`/loans/${encodeURIComponent(l.Loan_No)}`} className="font-medium text-brand-300">{l.Loan_No}</Link></Td>
                    <Td>
                      <p className="text-slate-200">{l.Customer_Name}</p>
                      <p className="text-xs text-slate-500">{l.Customer_STL_NO}</p>
                    </Td>
                    <Td className="text-slate-400">{fmtDate(l.Loan_Given_Date)}</Td>
                    <Td right className="text-hd">{inr(num(l.Loan_Amount))}</Td>
                    <Td className="text-slate-300 whitespace-nowrap">
                      {l.Interest_Type === 'Per_Month' ? `₹${num(l.Interest_Per_Month_Per_Lakh)}/L·mo` : `₹${num(l.Interest_Per_day_Per_Lakh)}/L·day`}
                    </Td>
                    <Td right className="text-amber-300">{inr(num(l.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(l.Loan_Status)}>{l.Loan_Status ?? '—'}</Badge></Td>
                    {isMd && <Td><button title="Delete loan" className="btn-ghost !px-2 !py-1 text-xs text-rose-300" onClick={() => setDel(l)}><Trash2 size={13} /></button></Td>}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {finance === 'ALL' && open === false && (
        <p className="mt-3 text-xs text-amber-300/80">Tip: pick a single finance in the switcher to create a loan.</p>
      )}

      {open && (
        <LoanForm
          finance={finance}
          initialStl={initialStl}
          onClose={() => setOpen(false)}
          onSaved={() => { setOpen(false); setTick(t => t + 1) }}
        />
      )}

      {del && (
        <ConfirmModal
          title="Delete loan"
          message={<>Delete loan <b className="text-hd">{del.Loan_No}</b> ({del.Customer_Name})?</>}
          onConfirm={async () => { await deleteLoan(del.Loan_No); setDel(null); setTick(t => t + 1) }}
          onClose={() => setDel(null)}
        />
      )}
    </div>
  )
}

function LoanForm({ finance, initialStl, onClose, onSaved }: { finance: string; initialStl?: string; onClose: () => void; onSaved: () => void }) {
  const customers = repo.customers(finance)
  const existingLoans = repo.loans(finance)
  const partners = repo.partners(finance)
  const prefix = (finance.slice(0, 3) || 'Fin')

  // Customer selection
  const [mode, setMode] = useState<'existing' | 'new'>(initialStl || customers.length ? 'existing' : 'new')
  const [q, setQ] = useState('')
  const [stl, setStl] = useState(initialStl && customers.some(c => c.Customer_STL_NO === initialStl) ? initialStl : '')
  // New-customer fields
  const [nName, setNName] = useState('')
  const [nPhone, setNPhone] = useState('')
  const [nEmail, setNEmail] = useState('')
  const [nAdhar, setNAdhar] = useState('')
  // Editable STL number — only the digits after the "<prefix>-STL" part.
  const computeAutoStl = () => customers.reduce((m, c) => {
    const n = Number(String(c.Customer_STL_NO).replace(/\D/g, ''))
    return isNaN(n) ? m : Math.max(m, n)
  }, 0) + 1
  const [stlNum, setStlNum] = useState(() => String(computeAutoStl()))

  // Loan fields
  const [amount, setAmount] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [type, setType] = useState<'Per_Day' | 'Per_Month'>('Per_Day')
  const [rate, setRate] = useState('')
  const [bonds, setBonds] = useState('')
  const [chqs, setChqs] = useState('')
  const [partner, setPartner] = useState('')
  const [payType, setPayType] = useState('Cash')
  const [remarks, setRemarks] = useState('')

  const cust = customers.find(c => c.Customer_STL_NO === stl)
  const matches = useMemo(() => {
    const s = q.trim().toLowerCase()
    const list = s
      ? customers.filter(c =>
          c.Customer_Name?.toLowerCase().includes(s) ||
          c.Customer_STL_NO?.toLowerCase().includes(s) ||
          String(c.Customer_Phone_No ?? '').includes(s))
      : customers
    return list.slice(0, 8)
  }, [customers, q])

  const newStl = `${prefix}-STL${stlNum.trim()}`
  const stlTaken = mode === 'new' && customers.some(c => c.Customer_STL_NO === newStl)
  const loanNo = `${prefix}-${existingLoans.length + 1}`
  const amt = num(amount)

  const customerReady = mode === 'existing'
    ? !!cust
    : nName.trim().length > 0 && stlNum.trim().length > 0 && !stlTaken
  const missing = missingRequired('loan', {
    date, customer: customerReady ? 'y' : '', amount, interestType: type, rate, bonds, chqs, partner, payType,
  })
  const missingLabels = missing.map(k => FORM_FIELDS.loan.find(f => f.key === k)?.label ?? k)
  const valid = customerReady && amt > 0 && num(rate) >= 0 && missing.length === 0

  async function save() {
    let stlNo: string, name: string, phoneNo: Customer['Customer_Phone_No']
    if (mode === 'new') {
      stlNo = newStl; name = nName.trim(); phoneNo = nPhone || undefined
      const c: Customer = {
        Finance_Name: finance,
        Customer_Name: name,
        Customer_STL_NO: stlNo,
        Customer_Phone_No: phoneNo,
        Customer_Email: nEmail || undefined,
        Customer_Adhar_No: nAdhar || undefined,
        Total_Loan_Given: 0,
        Outstand_Loan: 0,
        Total_Interest_Paid: 0,
        Outstanding_Interest: 0,
        Status: 'Active',
      }
      await addCustomer(c)
    } else {
      if (!cust) return
      stlNo = cust.Customer_STL_NO; name = cust.Customer_Name; phoneNo = cust.Customer_Phone_No
    }

    const loan: Loan = {
      Finance_Name: finance,
      Loan_Given_Date: date,
      Loan_No: loanNo,
      Customer_STL_NO: stlNo,
      Customer_Name: name,
      Customer_Phone_No: phoneNo,
      Loan_Amount: amt,
      Interest_Type: type,
      Interest_Per_day_Per_Lakh: type === 'Per_Day' ? num(rate) : 0,
      Interest_Per_Month_Per_Lakh: type === 'Per_Month' ? num(rate) : 0,
      No_Bond_Received: num(bonds) || undefined,
      No_Chq_Received: num(chqs) || undefined,
      Repaid_Amount: 0,
      Outstand_Amount: amt,
      Loan_Status: 'Active',
      Referred_Partner: partner || undefined,
      Payment_Type: payType,
      Remarks: remarks || undefined,
    }
    await addLoan(loan)
    onSaved()
  }

  return (
    <Modal
      title="New loan"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Disburse & post to ledger</button>
      </>}
    >
      {/* Existing vs new customer */}
      <div className="flex gap-1 rounded-xl bg-slate-800/60 p-1">
        {(['existing', 'new'] as const).map(m => (
          <button
            key={m}
            onClick={() => { setMode(m); setStl(''); setQ('') }}
            className={`flex-1 rounded-lg px-3 py-1.5 text-sm font-medium capitalize ${mode === m ? 'bg-brand-600 text-white' : 'text-slate-300'}`}
          >
            {m === 'existing' ? 'Existing customer' : 'New customer'}
          </button>
        ))}
      </div>

      {mode === 'existing' ? (
        cust ? (
          /* A customer is chosen — show it clearly with a Change button. */
          <div className="rounded-xl bg-slate-800/40 p-3">
            <div className="flex items-start justify-between">
              <div>
                <p className="font-semibold text-hd">{cust.Customer_Name}</p>
                <p className="text-xs text-slate-500">{cust.Customer_STL_NO} · {phone(cust.Customer_Phone_No)}</p>
              </div>
              <button onClick={() => setStl('')} className="btn-ghost !py-1 text-xs">Change</button>
            </div>
            <div className="mt-3 grid grid-cols-2 gap-3 text-sm">
              <div>
                <p className="label">Outstanding loan</p>
                <p className="mt-0.5 font-semibold text-hd">{inr(num(cust.Outstand_Loan))}</p>
              </div>
              <div>
                <p className="label">Outstanding interest</p>
                <p className="mt-0.5 font-semibold text-amber-300">{inr(num(cust.Outstanding_Interest))}</p>
              </div>
            </div>
          </div>
        ) : (
          <>
            <Field label="Find customer (name / phone / STL)">
              <input className="input" placeholder="Type to search…" autoFocus value={q} onChange={e => setQ(e.target.value)} />
            </Field>
            <div className="max-h-44 space-y-1 overflow-y-auto">
              {matches.length === 0 && <p className="px-1 text-sm text-slate-500">No matching customers.</p>}
              {matches.map(c => (
                <button
                  key={c.Customer_STL_NO}
                  type="button"
                  onClick={() => setStl(c.Customer_STL_NO)}
                  className="flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm ring-1 ring-inset ring-transparent hover:bg-slate-800/60 hover:ring-brand-500/40"
                >
                  <span>
                    <span className="font-medium text-slate-100">{c.Customer_Name}</span>
                    <span className="ml-2 text-xs text-slate-500">{c.Customer_STL_NO} · {phone(c.Customer_Phone_No)}</span>
                  </span>
                  <span className="text-xs text-amber-300">{inr(num(c.Outstand_Loan))} out</span>
                </button>
              ))}
            </div>
          </>
        )
      ) : (
        <>
          <Field label="Customer name"><input className="input" value={nName} onChange={e => setNName(e.target.value)} /></Field>
          <div className="grid grid-cols-2 gap-3">
            <Field label="Phone"><input className="input" inputMode="tel" value={nPhone} onChange={e => setNPhone(e.target.value)} /></Field>
            <Field label="Aadhaar no."><input className="input" value={nAdhar} onChange={e => setNAdhar(e.target.value)} /></Field>
          </div>
          <Field label="Email"><input className="input" value={nEmail} onChange={e => setNEmail(e.target.value)} /></Field>
          <Field label="STL number" hint={stlTaken ? undefined : 'The number after the code is editable; the next new customer auto-continues from the highest.'}>
            <div className="flex items-center gap-2">
              <span className="rounded-xl border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-400">{prefix}-STL</span>
              <input className="input" inputMode="numeric" value={stlNum} onChange={e => setStlNum(e.target.value.replace(/\D/g, ''))} />
            </div>
            {stlTaken && <span className="mt-1 block text-xs text-rose-300">{newStl} already exists — pick another number.</span>}
          </Field>
        </>
      )}

      <div className="grid grid-cols-2 gap-3">
        <Field label="Loan amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Given date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      <AmountHint value={amount} />
      <div className="grid grid-cols-2 gap-3">
        <Field label="Interest type">
          <select className="input" value={type} onChange={e => setType(e.target.value as any)}>
            <option value="Per_Day">Per day / lakh</option>
            <option value="Per_Month">Per month / lakh</option>
          </select>
        </Field>
        <Field label="Rate (₹ / lakh)"><input className="input" inputMode="numeric" value={rate} onChange={e => setRate(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Bonds received"><input className="input" inputMode="numeric" value={bonds} onChange={e => setBonds(e.target.value)} /></Field>
        <Field label="Cheques received"><input className="input" inputMode="numeric" value={chqs} onChange={e => setChqs(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Referred partner">
          <select className="input" value={partner} onChange={e => setPartner(e.target.value)}>
            <option value="">—</option>
            {partners.map(p => <option key={p.Partner_ID} value={p.Partner_ID}>{p.Partner_Name} · {p.Partner_ID}</option>)}
          </select>
        </Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
          </select>
        </Field>
      </div>
      <Field label="Remarks"><input className="input" value={remarks} onChange={e => setRemarks(e.target.value)} /></Field>
      <Field label="Loan no. (auto)"><input className="input opacity-70" value={loanNo} readOnly /></Field>
      {missingLabels.length > 0 && <p className="text-xs text-amber-300">Required: {missingLabels.join(', ')}</p>}
    </Modal>
  )
}
