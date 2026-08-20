import { useMemo, useState } from 'react'
import { PiggyBank, Plus } from 'lucide-react'
import { repo, addDeposit } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import {
  PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field,
} from '../components/ui'
import { inr, phone, num } from '../lib/format'
import { useCreateParam } from '../lib/useCreateParam'
import type { Deposit } from '../data/types'

export default function Deposits() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const [open, setOpen] = useCreateParam()
  const [tick, setTick] = useState(0)

  const { rows, total, outstanding } = useMemo(() => {
    const list = repo.deposits(financeFilter(finance))
    return {
      rows: list,
      total: list.reduce((s, d) => s + num(d.Deposit_Amount), 0),
      outstanding: list.reduce((s, d) => s + num(d.Outstand_Amount), 0),
    }
  }, [finance, tick])

  return (
    <div>
      <PageHeader
        title="Deposits"
        subtitle="Money taken from depositors — your interest-paying liabilities."
        action={canEdit(role) &&
          <button className="btn-primary" onClick={() => setOpen(true)} disabled={finance === 'ALL'}>
            <Plus size={16} /> New deposit
          </button>
        }
      />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Depositors" value={rows.length} tone="blue" icon={<PiggyBank size={18} />} />
        <StatCard label="Total deposited" value={inr(total)} tone="slate" />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
      </div>

      {finance === 'ALL' && <p className="mb-3 text-xs text-amber-300/80">Pick a single finance in the switcher to add a deposit.</p>}

      {rows.length === 0 ? <EmptyState title="No deposits" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Deposit no.</Th><Th>Depositor</Th><Th>Phone</Th><Th right>Amount</Th><Th>Rate/L·mo</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((d, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{d.Deposit_No}</Td>
                    <Td className="text-slate-200">{d.Depositer_Name}</Td>
                    <Td className="text-slate-400">{phone(d.Depositer_Phone_No)}</Td>
                    <Td right className="text-white">{inr(num(d.Deposit_Amount))}</Td>
                    <Td className="text-slate-300">₹{num(d.Interest_Per_Month_Per_Lakh)}</Td>
                    <Td right className="text-rose-300">{inr(num(d.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(d.Deposit_Status)}>{d.Deposit_Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {open && (
        <DepositForm
          finance={finance}
          onClose={() => setOpen(false)}
          onSaved={() => { setOpen(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

function DepositForm({ finance, onClose, onSaved }: { finance: string; onClose: () => void; onSaved: () => void }) {
  const existing = repo.deposits(finance)
  const prefix = (finance.slice(0, 3) || 'Fin')
  const [name, setName] = useState('')
  const [amount, setAmount] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [rate, setRate] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const [payType, setPayType] = useState('Cash')

  const depositNo = `${prefix}-D-${existing.length + 1}-${name || 'depositor'}`
  const amt = num(amount)
  const valid = name.trim() && amt > 0

  async function save() {
    const row: Deposit = {
      Finance_Name: finance,
      Deposit_Bought_Date: date,
      Deposit_No: depositNo,
      Depositer_Name: name.trim(),
      Depositer_Phone_No: phoneNo || undefined,
      Deposit_Amount: amt,
      Interest_Type: 'Per_Month',
      Interest_Per_Month_Per_Lakh: num(rate),
      Repaid_Amount: 0,
      Outstand_Amount: amt,
      Deposit_Status: 'Active',
      Payment_Type: payType,
    }
    await addDeposit(row)
    onSaved()
  }

  return (
    <Modal
      title="New deposit"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Save & post to ledger</button>
      </>}
    >
      <Field label="Depositor name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Bought date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Rate (₹ / lakh / month)"><input className="input" inputMode="numeric" value={rate} onChange={e => setRate(e.target.value)} /></Field>
        <Field label="Depositor phone"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
      </div>
      <Field label="Payment type">
        <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
          <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
        </select>
      </Field>
      <Field label="Deposit no. (auto)"><input className="input opacity-70" value={depositNo} readOnly /></Field>
    </Modal>
  )
}
