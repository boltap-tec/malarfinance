import { useMemo, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import { PiggyBank, Plus, HandCoins, Percent, Trash2 } from 'lucide-react'
import { repo, addDeposit, deleteDeposit, missingRequired, FORM_FIELDS } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import {
  PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field, ConfirmModal,
} from '../components/ui'
import { inr, phone, num } from '../lib/format'
import { useCreateParam } from '../lib/useCreateParam'
import type { Deposit } from '../data/types'

export default function Deposits() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const isMd = role === 'md'
  const [open, setOpen] = useCreateParam()
  const [sp] = useSearchParams()
  const initialCode = sp.get('code') ?? ''
  const [tick, setTick] = useState(0)
  const [del, setDel] = useState<Deposit | null>(null)

  const { rows, total, outstanding } = useMemo(() => {
    const list = repo.deposits(financeFilter(finance)).slice().sort((a, b) => num(b.Outstand_Amount) - num(a.Outstand_Amount))
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

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-3">
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
                <tr><Th>Deposit no.</Th><Th>Depositor</Th><Th>Phone</Th><Th right>Amount</Th><Th>Rate/L·mo</Th><Th right>Outstanding</Th><Th>Status</Th>{canEdit(role) && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((d, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td><Link to={`/deposits/${encodeURIComponent(d.Deposit_No)}`} className="font-medium text-brand-300">{d.Deposit_No}</Link></Td>
                    <Td className="text-slate-200">{d.Depositer_Name}</Td>
                    <Td className="text-slate-400">{phone(d.Depositer_Phone_No)}</Td>
                    <Td right className="text-white">{inr(num(d.Deposit_Amount))}</Td>
                    <Td className="text-slate-300">₹{num(d.Interest_Per_Month_Per_Lakh)}</Td>
                    <Td right className="text-rose-300">{inr(num(d.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(d.Deposit_Status)}>{d.Deposit_Status ?? '—'}</Badge></Td>
                    {canEdit(role) && (
                      <Td>
                        <div className="flex gap-1.5">
                          {num(d.Outstand_Amount) > 0 && <Link title="Repay" to={`/deposits/${encodeURIComponent(d.Deposit_No)}?do=repay`} className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"><HandCoins size={13} /></Link>}
                          {repo.depositInterestPending(d.Deposit_No) > 0 && <Link title="Pay interest" to="/deposit-interest" className="btn-ghost !px-2 !py-1 text-xs text-amber-300 ring-1 ring-inset ring-amber-500/30"><Percent size={13} /></Link>}
                          {isMd && <button title="Delete" className="btn-ghost !px-2 !py-1 text-xs text-rose-300" onClick={() => setDel(d)}><Trash2 size={13} /></button>}
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

      {open && (
        <DepositForm
          finance={finance}
          initialCode={initialCode}
          onClose={() => setOpen(false)}
          onSaved={() => { setOpen(false); setTick(t => t + 1) }}
        />
      )}

      {del && (
        <ConfirmModal
          title="Delete deposit"
          message={<>Delete deposit <b className="text-white">{del.Deposit_No}</b> ({del.Depositer_Name}, {inr(num(del.Deposit_Amount))})?</>}
          onConfirm={async () => { await deleteDeposit(del); setDel(null); setTick(t => t + 1) }}
          onClose={() => setDel(null)}
        />
      )}
    </div>
  )
}

interface Depositor { code: string; name: string; phone?: number | string; email?: string; address?: string; out: number; count: number }

function DepositForm({ finance, initialCode, onClose, onSaved }: { finance: string; initialCode?: string; onClose: () => void; onSaved: () => void }) {
  const existing = repo.deposits(finance)
  const prefix = (finance.slice(0, 3) || 'Fin')

  // Distinct depositors already on record, so a repeat deposit links to the same DEP code.
  const depositors = useMemo(() => {
    const map = new Map<string, Depositor>()
    for (const d of existing) {
      const key = (d.Depositer_Name || '').toLowerCase()
      if (!key) continue
      const cur = map.get(key) ?? { code: d.Deposit_No, name: d.Depositer_Name, phone: d.Depositer_Phone_No, email: d.Depositer_Email, address: d.Depositer_Address, out: 0, count: 0 }
      cur.out += num(d.Outstand_Amount); cur.count++
      map.set(key, cur)
    }
    return [...map.values()]
  }, [existing])

  const preset = initialCode ? depositors.find(d => d.code === initialCode) ?? null : null
  const [mode, setMode] = useState<'existing' | 'new'>(preset || depositors.length ? 'existing' : 'new')
  const [q, setQ] = useState('')
  const [sel, setSel] = useState<Depositor | null>(preset)
  // New depositor
  const [name, setName] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const [email, setEmail] = useState('')
  const [address, setAddress] = useState('')
  const autoNum = existing.reduce((mx, d) => {
    const m = String(d.Deposit_No).match(/DEP(\d+)/i)
    return m ? Math.max(mx, Number(m[1])) : mx
  }, 0) + 1
  const [depNum, setDepNum] = useState(String(autoNum))
  // Deposit fields
  const [amount, setAmount] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [rate, setRate] = useState('')
  const [payType, setPayType] = useState('Cash')

  const matches = useMemo(() => {
    const s = q.trim().toLowerCase()
    return (s ? depositors.filter(d => d.name.toLowerCase().includes(s) || d.code.toLowerCase().includes(s) || String(d.phone ?? '').includes(s)) : depositors).slice(0, 8)
  }, [depositors, q])

  const newCode = `${prefix}-DEP${depNum.trim()}`
  const amt = num(amount)
  const depositorReady = mode === 'existing' ? !!sel : name.trim().length > 0 && depNum.trim().length > 0
  const missing = missingRequired('deposit', {
    name: mode === 'existing' ? (sel ? 'y' : '') : name,
    amount, date, rate,
    phone: mode === 'existing' ? (sel?.phone ?? '') : phoneNo,
    payType,
  })
  const missingLabels = missing.map(k => FORM_FIELDS.deposit.find(f => f.key === k)?.label ?? k)
  const valid = depositorReady && amt > 0 && missing.length === 0

  async function save() {
    const code = mode === 'existing' ? sel!.code : newCode
    const row: Deposit = {
      Finance_Name: finance,
      Deposit_Bought_Date: date,
      Deposit_No: code,
      Depositer_Name: mode === 'existing' ? sel!.name : name.trim(),
      Depositer_Phone_No: mode === 'existing' ? sel!.phone : (phoneNo || undefined),
      Depositer_Email: mode === 'existing' ? sel!.email : (email || undefined),
      Depositer_Address: mode === 'existing' ? sel!.address : (address || undefined),
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
      <div className="flex gap-1 rounded-xl bg-slate-800/60 p-1">
        {(['existing', 'new'] as const).map(m => (
          <button key={m} onClick={() => { setMode(m); setSel(null); setQ('') }}
            className={`flex-1 rounded-lg px-3 py-1.5 text-sm font-medium ${mode === m ? 'bg-brand-600 text-white' : 'text-slate-300'}`}>
            {m === 'existing' ? 'Existing depositor' : 'New depositor'}
          </button>
        ))}
      </div>

      {mode === 'existing' ? (
        sel ? (
          <div className="rounded-xl bg-slate-800/40 p-3">
            <div className="flex items-start justify-between">
              <div>
                <p className="font-semibold text-white">{sel.name}</p>
                <p className="text-xs text-slate-500">{sel.code} · {phone(sel.phone)} · {sel.count} deposit(s)</p>
              </div>
              <button onClick={() => setSel(null)} className="btn-ghost !py-1 text-xs">Change</button>
            </div>
            <p className="mt-2 text-xs text-amber-300">Linked · outstanding {inr(sel.out)}</p>
          </div>
        ) : (
          <>
            <Field label="Find depositor (name / phone / DEP no.)">
              <input className="input" placeholder="Type to search…" autoFocus value={q} onChange={e => setQ(e.target.value)} />
            </Field>
            <div className="max-h-44 space-y-1 overflow-y-auto">
              {matches.length === 0 && <p className="px-1 text-sm text-slate-500">No matching depositors.</p>}
              {matches.map(d => (
                <button key={d.code} type="button" onClick={() => setSel(d)}
                  className="flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm ring-1 ring-inset ring-transparent hover:bg-slate-800/60 hover:ring-brand-500/40">
                  <span><span className="font-medium text-slate-100">{d.name}</span><span className="ml-2 text-xs text-slate-500">{d.code} · {phone(d.phone)}</span></span>
                  <span className="text-xs text-amber-300">{inr(d.out)} out</span>
                </button>
              ))}
            </div>
          </>
        )
      ) : (
        <>
          <Field label="Depositor name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
          <div className="grid grid-cols-2 gap-3">
            <Field label="Phone"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
            <Field label="Email"><input className="input" value={email} onChange={e => setEmail(e.target.value)} /></Field>
          </div>
          <Field label="Address"><input className="input" value={address} onChange={e => setAddress(e.target.value)} /></Field>
          <Field label="Depositor no. (DEP)" hint="Only the number is editable; the next new depositor auto-continues.">
            <div className="flex items-center gap-2">
              <span className="rounded-xl border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-400">{prefix}-DEP</span>
              <input className="input" inputMode="numeric" value={depNum} onChange={e => setDepNum(e.target.value.replace(/\D/g, ''))} />
            </div>
          </Field>
        </>
      )}

      <div className="grid grid-cols-2 gap-3">
        <Field label="Amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Bought date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Rate (₹ / lakh / month)"><input className="input" inputMode="numeric" value={rate} onChange={e => setRate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
          </select>
        </Field>
      </div>
      {missingLabels.length > 0 && <p className="text-xs text-amber-300">Required: {missingLabels.join(', ')}</p>}
    </Modal>
  )
}
