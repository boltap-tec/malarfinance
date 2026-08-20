import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Search, Plus } from 'lucide-react'
import { repo, addCustomer } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { inr, phone, num } from '../lib/format'
import { useCreateParam } from '../lib/useCreateParam'
import type { Customer } from '../data/types'

export default function Customers() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const [q, setQ] = useState('')
  const [open, setOpen] = useCreateParam()
  const [tick, setTick] = useState(0)

  const rows = useMemo(() => {
    const list = repo.customers(financeFilter(finance))
    const s = q.trim().toLowerCase()
    return list.filter(c =>
      !s || c.Customer_Name?.toLowerCase().includes(s) || c.Customer_STL_NO?.toLowerCase().includes(s) ||
      String(c.Customer_Phone_No ?? '').includes(s),
    )
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
                <tr><Th>Customer</Th><Th>STL No.</Th><Th>Phone</Th><Th right>Outstanding loan</Th><Th right>Interest due</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map(c => (
                  <tr key={c.Customer_STL_NO} className="hover:bg-slate-800/40">
                    <Td>
                      <Link to={`/customers/${encodeURIComponent(c.Customer_STL_NO)}`} className="font-medium text-brand-300 hover:text-brand-200">
                        {c.Customer_Name}
                      </Link>
                      <p className="text-xs text-slate-500">{c.Finance_Name}</p>
                    </Td>
                    <Td className="text-slate-300">{c.Customer_STL_NO}</Td>
                    <Td className="text-slate-400">{phone(c.Customer_Phone_No)}</Td>
                    <Td right className="font-semibold text-white">{inr(num(c.Outstand_Loan))}</Td>
                    <Td right className={num(c.Outstanding_Interest) > 0 ? 'font-semibold text-amber-400' : 'text-slate-400'}>{inr(num(c.Outstanding_Interest))}</Td>
                    <Td><Badge tone={statusTone(c.Status)}>{c.Status ?? '—'}</Badge></Td>
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
