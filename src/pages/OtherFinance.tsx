import { useMemo, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import { Building2, Plus, HandCoins, Percent } from 'lucide-react'
import { repo, addOtherFinanceLoan, missingRequired, FORM_FIELDS } from '../data/repository'
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
  const [sp] = useSearchParams()
  const initialCode = sp.get('code') ?? ''
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
                  <Th right>Amount</Th><Th>Rate</Th><Th right>Outstanding</Th><Th>Status</Th>{canEdit(role) && <Th>Actions</Th>}
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((o, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td><Link to={`/other-finance/${encodeURIComponent(o.Loan_No)}`} className="font-medium text-brand-300">{o.Loan_No}</Link></Td>
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
                    {canEdit(role) && (
                      <Td>
                        {num(o.Outstand_Amount) > 0 ? (
                          <div className="flex gap-1.5">
                            <Link title="Repay" to={`/other-finance/${encodeURIComponent(o.Loan_No)}?do=repay`} className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"><HandCoins size={13} /></Link>
                            <Link title="Pay interest" to={`/other-finance/${encodeURIComponent(o.Loan_No)}?do=interest`} className="btn-ghost !px-2 !py-1 text-xs text-amber-300 ring-1 ring-inset ring-amber-500/30"><Percent size={13} /></Link>
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

      {open && (
        <BorrowForm
          finance={finance}
          initialCode={initialCode}
          onClose={() => setOpen(false)}
          onSaved={() => { setOpen(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

interface Lender { code: string; name: string; phone?: number | string; out: number; count: number }

function BorrowForm({ finance, initialCode, onClose, onSaved }: { finance: string; initialCode?: string; onClose: () => void; onSaved: () => void }) {
  const existing = repo.otherFinanceLoans(finance)
  const prefix = (finance.slice(0, 3) || 'Fin')

  // Distinct lender finances already on record, so a repeat borrowing links to the same FIN code.
  const lenders = useMemo(() => {
    const map = new Map<string, Lender>()
    for (const o of existing) {
      const key = (o.Loan_bought_Finance_Name || '').toLowerCase()
      if (!key) continue
      const cur = map.get(key) ?? { code: o.Loan_No, name: o.Loan_bought_Finance_Name, phone: o.Loan_bought_Finance_Phone_No, out: 0, count: 0 }
      cur.out += num(o.Outstand_Amount); cur.count++
      map.set(key, cur)
    }
    return [...map.values()]
  }, [existing])

  const preset = initialCode ? lenders.find(l => l.code === initialCode) ?? null : null
  const [mode, setMode] = useState<'existing' | 'new'>(preset || lenders.length ? 'existing' : 'new')
  const [q, setQ] = useState('')
  const [sel, setSel] = useState<Lender | null>(preset)
  const [lender, setLender] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const autoNum = existing.reduce((mx, o) => {
    const m = String(o.Loan_No).match(/FIN(\d+)/i)
    return m ? Math.max(mx, Number(m[1])) : mx
  }, 0) + 1
  const [finNum, setFinNum] = useState(String(autoNum))
  const [amount, setAmount] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [type, setType] = useState<'Per_Day' | 'Per_Month'>('Per_Day')
  const [rate, setRate] = useState('')
  const [payType, setPayType] = useState('Cash')

  const matches = useMemo(() => {
    const s = q.trim().toLowerCase()
    return (s ? lenders.filter(l => l.name.toLowerCase().includes(s) || l.code.toLowerCase().includes(s) || String(l.phone ?? '').includes(s)) : lenders).slice(0, 8)
  }, [lenders, q])

  const newCode = `${prefix}-FIN${finNum.trim()}`
  const amt = num(amount)
  const lenderReady = mode === 'existing' ? !!sel : lender.trim().length > 0 && finNum.trim().length > 0
  const missing = missingRequired('other', {
    lender: mode === 'existing' ? (sel ? 'y' : '') : lender,
    amount, date, rate,
    phone: mode === 'existing' ? (sel?.phone ?? '') : phoneNo,
    payType,
  })
  const missingLabels = missing.map(k => FORM_FIELDS.other.find(f => f.key === k)?.label ?? k)
  const valid = lenderReady && amt > 0 && num(rate) >= 0 && missing.length === 0

  async function save() {
    const row: OtherFinanceLoan = {
      Finance_Name: finance,
      Loan_Bought_Date: date,
      Loan_No: mode === 'existing' ? sel!.code : newCode,
      Loan_bought_Finance_Name: mode === 'existing' ? sel!.name : lender.trim(),
      Loan_bought_Finance_Phone_No: mode === 'existing' ? sel!.phone : (phoneNo || undefined),
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
      <div className="flex gap-1 rounded-xl bg-slate-800/60 p-1">
        {(['existing', 'new'] as const).map(m => (
          <button key={m} onClick={() => { setMode(m); setSel(null); setQ('') }}
            className={`flex-1 rounded-lg px-3 py-1.5 text-sm font-medium ${mode === m ? 'bg-brand-600 text-white' : 'text-slate-300'}`}>
            {m === 'existing' ? 'Existing finance' : 'New finance'}
          </button>
        ))}
      </div>

      {mode === 'existing' ? (
        sel ? (
          <div className="rounded-xl bg-slate-800/40 p-3">
            <div className="flex items-start justify-between">
              <div>
                <p className="font-semibold text-white">{sel.name}</p>
                <p className="text-xs text-slate-500">{sel.code} · {phone(sel.phone)} · {sel.count} loan(s)</p>
              </div>
              <button onClick={() => setSel(null)} className="btn-ghost !py-1 text-xs">Change</button>
            </div>
            <p className="mt-2 text-xs text-amber-300">Linked · outstanding {inr(sel.out)}</p>
          </div>
        ) : (
          <>
            <Field label="Find finance (name / phone / FIN no.)">
              <input className="input" placeholder="Type to search…" autoFocus value={q} onChange={e => setQ(e.target.value)} />
            </Field>
            <div className="max-h-44 space-y-1 overflow-y-auto">
              {matches.length === 0 && <p className="px-1 text-sm text-slate-500">No matching finances.</p>}
              {matches.map(l => (
                <button key={l.code} type="button" onClick={() => setSel(l)}
                  className="flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm ring-1 ring-inset ring-transparent hover:bg-slate-800/60 hover:ring-brand-500/40">
                  <span><span className="font-medium text-slate-100">{l.name}</span><span className="ml-2 text-xs text-slate-500">{l.code} · {phone(l.phone)}</span></span>
                  <span className="text-xs text-amber-300">{inr(l.out)} out</span>
                </button>
              ))}
            </div>
          </>
        )
      ) : (
        <>
          <Field label="Lender finance name"><input className="input" value={lender} onChange={e => setLender(e.target.value)} placeholder="e.g. AKPR finance" /></Field>
          <div className="grid grid-cols-2 gap-3">
            <Field label="Lender phone"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
            <Field label="Finance no. (FIN)" hint="Only the number is editable.">
              <div className="flex items-center gap-2">
                <span className="rounded-xl border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-400">{prefix}-FIN</span>
                <input className="input" inputMode="numeric" value={finNum} onChange={e => setFinNum(e.target.value.replace(/\D/g, ''))} />
              </div>
            </Field>
          </div>
        </>
      )}

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
      <Field label="Payment type">
        <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
          <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
        </select>
      </Field>
      {missingLabels.length > 0 && <p className="text-xs text-amber-300">Required: {missingLabels.join(', ')}</p>}
    </Modal>
  )
}
