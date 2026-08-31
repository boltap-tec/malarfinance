import { useMemo, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Search, Plus, HandCoins, Percent, Users } from 'lucide-react'
import { repo, addCustomer, customerRisk } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import ReminderButton from '../components/ReminderButton'
import { inr, phone, num, balanceStatus } from '../lib/format'
import { useCreateParam } from '../lib/useCreateParam'
import type { Customer } from '../data/types'

export default function Customers() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const setFinance = useApp(s => s.setFinance)
  const navigate = useNavigate()
  const [q, setQ] = useState('')
  const [open, setOpen] = useCreateParam()
  const [tick, setTick] = useState(0)

  // Giving a loan needs a specific finance — adopt the customer's finance first.
  const giveLoan = (c: Customer) => { setFinance(c.Finance_Name); navigate(`/loans?new=1&stl=${encodeURIComponent(c.Customer_STL_NO)}`) }

  const { rows, outLoan, outInterest, pendMap } = useMemo(() => {
    const list = repo.customers(financeFilter(finance))
    // Live pending interest per customer, summed straight from the interest rows —
    // so posted interest shows immediately without depending on the stored roll-up.
    const pendMap = new Map<string, number>()
    for (const r of repo.interest(financeFilter(finance))) pendMap.set(r.Customer_STL_NO, (pendMap.get(r.Customer_STL_NO) ?? 0) + num(r.Interest_Pending))
    const s = q.trim().toLowerCase()
    const filtered = list.filter(c =>
      !s || c.Customer_Name?.toLowerCase().includes(s) || c.Customer_STL_NO?.toLowerCase().includes(s) ||
      String(c.Customer_Phone_No ?? '').includes(s),
    ).sort((a, b) =>
      (Number(num(b.Outstand_Loan) > 0) - Number(num(a.Outstand_Loan) > 0)) ||   // active (owing) customers first
      (num(b.Outstand_Loan) - num(a.Outstand_Loan)),
    )
    return {
      rows: filtered, pendMap,
      outLoan: filtered.reduce((s2, c) => s2 + num(c.Outstand_Loan), 0),
      outInterest: filtered.reduce((s2, c) => s2 + (pendMap.get(c.Customer_STL_NO) ?? 0), 0),
    }
  }, [finance, q, tick])

  return (
    <div>
      <PageHeader
        title="Customers"
        subtitle={`${rows.length} borrowers`}
        action={canEdit(role) &&
          <button className="btn-primary" onClick={() => setOpen(true)} disabled={finance === 'ALL'}>
            <Plus size={16} /> New customer
          </button>
        }
      />

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-3">
        <StatCard label="Customers" value={rows.length} tone="blue" icon={<Users size={18} />} />
        <StatCard label="Outstanding loan" value={inr(outLoan)} tone="amber" />
        <StatCard label="Outstanding interest" value={inr(outInterest)} tone="red" />
      </div>

      <Card className="mb-4 !p-3">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input pl-9" placeholder="Search by name, STL no. or phone…" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No customers found" hint="Try a different search." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th sticky>Customer</Th><Th>STL No.</Th><Th right>Outstanding loan</Th><Th right>Outstanding interest</Th><Th>Risk</Th><Th>Status</Th>{canEdit(role) && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(c => (
                  <tr key={c.Customer_STL_NO} className="group hover:bg-slate-800/40">
                    <Td sticky>
                      <Link to={`/customers/${encodeURIComponent(c.Customer_STL_NO)}`} className="font-medium text-brand-300 hover:text-brand-200">
                        {c.Customer_Name}
                      </Link>
                      <p className="text-xs text-slate-500">{c.Finance_Name}</p>
                    </Td>
                    <Td className="text-slate-300">{c.Customer_STL_NO}</Td>
                    <Td right className="font-semibold text-hd">{inr(num(c.Outstand_Loan))}</Td>
                    <Td right className={(pendMap.get(c.Customer_STL_NO) ?? 0) > 0 ? 'font-semibold text-amber-400' : 'text-slate-400'}>{inr(pendMap.get(c.Customer_STL_NO) ?? 0)}</Td>
                    <Td><RiskBadge stl={c.Customer_STL_NO} /></Td>
                    <Td><Badge tone={statusTone(balanceStatus(c.Outstand_Loan))}>{balanceStatus(c.Outstand_Loan)}</Badge></Td>
                    {canEdit(role) && (
                      <Td>
                        <div className="flex gap-1.5">
                          <button title="Give loan" onClick={() => giveLoan(c)} className="btn-ghost !px-2 !py-1 text-xs text-brand-300 ring-1 ring-inset ring-brand-500/30"><Plus size={13} /></button>
                          {num(c.Outstand_Loan) > 0 && <Link title="Repay" to={`/customers/${encodeURIComponent(c.Customer_STL_NO)}?do=repay`} className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"><HandCoins size={13} /></Link>}
                          {(pendMap.get(c.Customer_STL_NO) ?? 0) > 0 && <Link title="Interest" to={`/customers/${encodeURIComponent(c.Customer_STL_NO)}?do=interest`} className="btn-ghost !px-2 !py-1 text-xs text-amber-300 ring-1 ring-inset ring-amber-500/30"><Percent size={13} /></Link>}
                          <ReminderButton
                            label="" className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"
                            header={`${c.Customer_STL_NO}-${c.Customer_Name}`}
                            phone={c.Customer_Phone_No}
                            items={repo.interestByCustomer(c.Customer_STL_NO).map(r => ({ month: r.Month, amount: num(r.Interest_Amount), pending: num(r.Interest_Pending) }))}
                          />
                        </div>
                      </Td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {finance === 'ALL' && <p className="mt-3 text-xs text-amber-300/80">Pick a single finance in the switcher to add a customer.</p>}

      {open && (
        <CustomerForm
          finance={finance}
          onClose={() => setOpen(false)}
          onSaved={() => { setOpen(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// Risk from unpaid interest months: <3 = low (green), 3–5 = medium (amber), 6+ = high (red).
function RiskBadge({ stl }: { stl: string }) {
  const { level, months } = customerRisk(stl)
  const tone = level === 'high' ? 'red' : level === 'medium' ? 'amber' : 'green'
  const label = level === 'high' ? `High · ${months}m` : level === 'medium' ? `Medium · ${months}m` : 'Low'
  return <Badge tone={tone}>{label}</Badge>
}

function CustomerForm({ finance, onClose, onSaved }: { finance: string; onClose: () => void; onSaved: () => void }) {
  const existing = repo.customers(finance)
  const prefix = (finance.slice(0, 3) || 'Fin')
  const [name, setName] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const [email, setEmail] = useState('')
  const [adhar, setAdhar] = useState('')
  const autoNum = existing.reduce((m, c) => {
    const n = Number(String(c.Customer_STL_NO).replace(/\D/g, ''))
    return isNaN(n) ? m : Math.max(m, n)
  }, 0) + 1
  const [stlNum, setStlNum] = useState(String(autoNum))

  const stl = `${prefix}-STL${stlNum.trim()}`
  const stlTaken = existing.some(c => c.Customer_STL_NO === stl)
  const valid = name.trim().length > 0 && stlNum.trim().length > 0 && !stlTaken

  async function save() {
    const c: Customer = {
      Finance_Name: finance,
      Customer_Name: name.trim(),
      Customer_STL_NO: stl,
      Customer_Phone_No: phoneNo || undefined,
      Customer_Email: email || undefined,
      Customer_Adhar_No: adhar || undefined,
      Total_Loan_Given: 0,
      Outstand_Loan: 0,
      Total_Interest_Paid: 0,
      Outstanding_Interest: 0,
      Status: 'Active',
    }
    await addCustomer(c)
    onSaved()
  }

  return (
    <Modal
      title="New customer (STL)"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Save customer</button>
      </>}
    >
      <Field label="Customer name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Phone"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
        <Field label="Aadhaar no."><input className="input" value={adhar} onChange={e => setAdhar(e.target.value)} /></Field>
      </div>
      <Field label="Email"><input className="input" value={email} onChange={e => setEmail(e.target.value)} /></Field>
      <Field label="STL number" hint={stlTaken ? undefined : 'Only the number is editable; the next customer auto-continues from the highest.'}>
        <div className="flex items-center gap-2">
          <span className="rounded-xl border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-400">{prefix}-STL</span>
          <input className="input" inputMode="numeric" value={stlNum} onChange={e => setStlNum(e.target.value.replace(/\D/g, ''))} />
        </div>
        {stlTaken && <span className="mt-1 block text-xs text-rose-300">{stl} already exists — pick another number.</span>}
      </Field>
    </Modal>
  )
}
