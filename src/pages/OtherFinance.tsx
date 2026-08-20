import { useMemo, useState } from 'react'
import { Building2, Plus } from 'lucide-react'
import { repo, addOtherFinanceLoan } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import {
  PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field,
} from '../components/ui'
import { inr, fmtDate, num, phone } from '../lib/format'
import { useCreateParam } from '../lib/useCreateParam'
import type { OtherFinanceLoan } from '../data/types'

export default function OtherFinance() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const [open, setOpen] = useCreateParam()
  const [tick, setTick] = useState(0)

  const { rows, borrowed, outstanding } = useMemo(() => {
    const list = repo.otherFinanceLoans(financeFilter(finance))
      .slice()
      .sort((a, b) => new Date(b.Loan_Bought_Date ?? 0).getTime() - new Date(a.Loan_Bought_Date ?? 0).getTime())
    return {
      rows: list,
      borrowed: list.reduce((s, o) => s + num(o.Loan_Amount), 0),
      outstanding: list.reduce((s, o) => s + num(o.Outstand_Amount), 0),
    }
  }, [finance, tick])

  return (
    <div>
      <PageHeader
        title="Other-Finance Loans"
        subtitle="Money the firm has borrowed from other finance houses — your liabilities."
        action={canEdit(role) &&
          <button className="btn-primary" onClick={() => setOpen(true)} disabled={finance === 'ALL'}>
            <Plus size={16} /> Borrow
          </button>
        }
      />

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Lenders" value={rows.length} tone="blue" icon={<Building2 size={18} />} />
        <StatCard label="Total borrowed" value={inr(borrowed)} tone="slate" />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
      </div>

      {finance === 'ALL' && <p className="mb-3 text-xs text-amber-300/80">Pick a single finance in the switcher to add a borrowing.</p>}

      {rows.length === 0 ? <EmptyState title="No other-finance loans" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr>
                  <Th>Loan no.</Th><Th>Lender</Th><Th>Phone</Th><Th>Bought</Th>
                  <Th right>Amount</Th><Th>Rate</Th><Th right>Outstanding</Th><Th>Status</Th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((o, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{o.Loan_No}</Td>
                    <Td className="text-slate-200">{o.Loan_bought_Finance_Name}</Td>
                    <Td className="text-slate-400">{phone(o.Loan_bought_Finance_Phone_No)}</Td>
                    <Td className="text-slate-400">{fmtDate(o.Loan_Bought_Date)}</Td>
                    <Td right className="text-white">{inr(num(o.Loan_Amount))}</Td>
                    <Td className="whitespace-nowrap text-slate-300">
                      {o.Interest_Type === 'Per_Month'
                        ? `₹${num(o.Interest_Per_Month_Per_Lakh)}/L·mo`
                        : `₹${num(o.Interest_Per_day_Per_Lakh)}/L·day`}
                    </Td>
                    <Td right className="text-rose-300">{inr(num(o.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(o.Loan_Status)}>{o.Loan_Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {open && (
        <BorrowForm
          finance={finance}
          onClose={() => setOpen(false)}
          onSaved={() => { setOpen(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

function BorrowForm({ finance, onClose, onSaved }: { finance: string; onClose: () => void; onSaved: () => void }) {
  const existing = repo.otherFinanceLoans(finance)
  const prefix = (finance.slice(0, 3) || 'Fin')
  const [lender, setLender] = useState('')
  const [amount, setAmount] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [type, setType] = useState<'Per_Day' | 'Per_Month'>('Per_Day')
  const [rate, setRate] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const [payType, setPayType] = useState('Cash')

  const loanNo = `${prefix}-O-${existing.length + 1}-${lender || 'lender'}`
  const amt = num(amount)
  const valid = lender.trim() && amt > 0 && num(rate) >= 0

  async function save() {
    const row: OtherFinanceLoan = {
      Finance_Name: finance,
      Loan_Bought_Date: date,
      Loan_No: loanNo,
      Loan_bought_Finance_Name: lender.trim(),
      Loan_bought_Finance_Phone_No: phoneNo || undefined,
      Loan_Amount: amt,
      Interest_Type: type,
      Interest_Per_day_Per_Lakh: type === 'Per_Day' ? num(rate) : 0,
      Interest_Per_Month_Per_Lakh: type === 'Per_Month' ? num(rate) : 0,
      Repaid_Amount: 0,
      Outstand_Amount: amt,
      Loan_Status: 'Active',
      Payment_Type: payType,
    }
    await addOtherFinanceLoan(row)
    onSaved()
  }

  return (
    <Modal
      title="Borrow from another finance"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Save & post to ledger</button>
      </>}
    >
      <Field label="Lender finance name"><input className="input" value={lender} onChange={e => setLender(e.target.value)} placeholder="e.g. AKPR finance" /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Bought date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
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
        <Field label="Lender phone"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
          </select>
        </Field>
      </div>
      <Field label="Loan no. (auto)" hint="Generated from finance + count + lender."><input className="input opacity-70" value={loanNo} readOnly /></Field>
    </Modal>
  )
}
