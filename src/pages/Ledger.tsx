import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Search, ArrowDownLeft, ArrowUpRight, Scale, Trash2, Pencil, TrendingDown, TrendingUp, HandCoins, Percent, PiggyBank, Landmark } from 'lucide-react'
import { repo, addBalanceCorrection, balanceForFinance, deleteLedgerEntry, updateLedgerEntry, addExpense, addOtherIncome, getLedgerCategories } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState, Badge, Modal, Field, ConfirmModal } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'
import type { LedgerRow } from '../data/types'

export default function Ledger() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const isMd = role === 'md'
  const [q, setQ] = useState('')
  const [correct, setCorrect] = useState(false)
  const [entry, setEntry] = useState<'expense' | 'income' | null>(null)
  const [del, setDel] = useState<LedgerRow | null>(null)
  const [edit, setEdit] = useState<LedgerRow | null>(null)
  const [tick, setTick] = useState(0)

  const singleFinance = finance !== 'ALL'

  const { rows, receipts, payments, balance, balByRef } = useMemo(() => {
    const all = repo.ledger(financeFilter(finance))

    // Running balance per entry, computed here from the SAME rows the card totals,
    // so the newest row's balance always equals the "Balance" card (the seeded
    // Balance column was imported with a different, global method — hence drift).
    const balByRef = new Map<string, number>()
    if (singleFinance) {
      const asc = all.slice().sort((a, b) => {
        const d = new Date(a.Date_Transaction ?? 0).getTime() - new Date(b.Date_Transaction ?? 0).getTime()
        return d !== 0 ? d : Number(String(a.Ref_ID).replace(/\D/g, '')) - Number(String(b.Ref_ID).replace(/\D/g, ''))
      })
      let run = 0
      for (const t of asc) { run += num(t.Receipt_Amount) - num(t.Payment_Amount); balByRef.set(String(t.Ref_ID), run) }
    }

    let list = all
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(t =>
      [t.Description, t.Customer_Name, t.Nature_Transaction, t.STL_No, t.Loan_No, t.Ref_ID]
        .some(v => String(v ?? '').toLowerCase().includes(s)))
    // Newest first for display.
    list = list.slice().sort((a, b) => {
      const d = new Date(b.Date_Transaction ?? 0).getTime() - new Date(a.Date_Transaction ?? 0).getTime()
      return d !== 0 ? d : Number(String(b.Ref_ID).replace(/\D/g, '')) - Number(String(a.Ref_ID).replace(/\D/g, ''))
    })
    return {
      rows: list.slice(0, 300),
      receipts: list.reduce((s2, t) => s2 + num(t.Receipt_Amount), 0),
      payments: list.reduce((s2, t) => s2 + num(t.Payment_Amount), 0),
      // Balance card = net of the whole finance ledger = the newest row's balance.
      balance: singleFinance ? all.reduce((s2, t) => s2 + num(t.Receipt_Amount) - num(t.Payment_Amount), 0) : 0,
      balByRef,
    }
  }, [finance, q, tick, singleFinance])

  return (
    <div>
      <PageHeader
        title="Transaction ledger"
        subtitle="Every receipt and payment across the business."
      />

      {/* Quick actions — record money here, or jump to a related screen. */}
      <div className="mb-4 flex flex-wrap gap-2">
        {editable && <button className="btn-primary !py-1.5" onClick={() => setEntry('expense')} disabled={!singleFinance}><TrendingDown size={15} /> Add expense</button>}
        {editable && <button className="btn-primary !py-1.5 !bg-emerald-600 hover:!bg-emerald-500" onClick={() => setEntry('income')} disabled={!singleFinance}><TrendingUp size={15} /> Add other income</button>}
        {editable && <button className="btn-ghost !py-1.5" onClick={() => setCorrect(true)}><Scale size={15} /> Balance correction</button>}
        <span className="mx-1 hidden w-px self-stretch bg-slate-700 sm:block" />
        <Link className="btn-ghost !py-1.5" to="/customer-interest"><HandCoins size={15} /> Loan interest</Link>
        <Link className="btn-ghost !py-1.5" to="/deposit-interest"><PiggyBank size={15} /> Deposit interest</Link>
        <Link className="btn-ghost !py-1.5" to="/other-finance-interest"><Landmark size={15} /> Other finance</Link>
        <Link className="btn-ghost !py-1.5" to="/profit"><Percent size={15} /> Profit</Link>
      </div>
      {editable && !singleFinance && <p className="-mt-2 mb-3 text-xs text-amber-300/80">Pick a single finance to add an expense or income.</p>}

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
        <StatCard label="Total receipts" value={inr(receipts)} tone="green" icon={<ArrowDownLeft size={18} />} />
        <StatCard label="Total payments" value={inr(payments)} tone="red" icon={<ArrowUpRight size={18} />} />
        <StatCard label="Net" value={inr(receipts - payments)} tone="blue" />
        {singleFinance && <StatCard label={`Balance · ${finance}`} value={inr(balance)} tone="slate" />}
      </div>

      <Card className="mb-4 !p-3">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" />
          <input className="input pl-9" placeholder="Search ledger…" value={q} onChange={e => setQ(e.target.value)} />
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No transactions" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Date</Th><Th>Nature</Th><Th>Description</Th><Th right>Receipt</Th><Th right>Payment</Th>{singleFinance && <Th right>Balance</Th>}<Th>Mode</Th>{isMd && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((t, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="whitespace-nowrap text-slate-400">
                      {fmtDate(t.Date_Transaction)}
                      {t.Created_Date && fmtDate(t.Created_Date) !== fmtDate(t.Date_Transaction) && (
                        <span className="block text-[11px] text-slate-500" title={t.Created_Date}>entered {fmtDate(t.Created_Date)}</span>
                      )}
                    </Td>
                    <Td><Badge tone="slate">{t.Nature_Transaction ?? '—'}</Badge></Td>
                    <Td>
                      <p className="text-slate-200">{t.Description ?? '—'}</p>
                      <p className="text-xs text-slate-500">{t.Customer_Name ?? t.STL_No ?? ''}</p>
                    </Td>
                    <Td right className="text-emerald-400">{num(t.Receipt_Amount) ? inr(num(t.Receipt_Amount)) : ''}</Td>
                    <Td right className="text-rose-400">{num(t.Payment_Amount) ? inr(num(t.Payment_Amount)) : ''}</Td>
                    {singleFinance && <Td right className="font-medium text-slate-200">{inr(balByRef.get(String(t.Ref_ID)) ?? 0)}</Td>}
                    <Td className="text-slate-400">{t.Payment_Type ?? '—'}</Td>
                    {isMd && <Td>
                      <div className="flex gap-1">
                        <button title="Edit entry" className="btn-ghost !px-2 !py-1 text-xs" onClick={() => setEdit(t)}><Pencil size={13} /></button>
                        <button title="Delete entry" className="btn-ghost !px-2 !py-1 text-xs text-rose-300" onClick={() => setDel(t)}><Trash2 size={13} /></button>
                      </div>
                    </Td>}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}
      {!singleFinance && <p className="mt-3 text-xs text-slate-500">Pick a single finance in the switcher to see the running balance column.</p>}

      {entry && singleFinance && (
        <ManualEntryModal
          kind={entry}
          finance={finance}
          onClose={() => setEntry(null)}
          onSaved={() => { setEntry(null); setTick(t => t + 1) }}
        />
      )}

      {correct && (
        <BalanceCorrection
          defaultFinance={singleFinance ? finance : undefined}
          onClose={() => setCorrect(false)}
          onSaved={() => { setCorrect(false); setTick(t => t + 1) }}
        />
      )}

      {del && (
        <ConfirmModal
          title="Delete ledger entry"
          message={<>Delete <b className="text-hd">{del.Description ?? del.Nature_Transaction}</b> (Ref {del.Ref_ID})? The finance balance will recompute.</>}
          onConfirm={async () => { await deleteLedgerEntry(String(del.Ref_ID)); setDel(null); setTick(t => t + 1) }}
          onClose={() => setDel(null)}
        />
      )}

      {edit && (
        <EditLedgerModal
          row={edit}
          onClose={() => setEdit(null)}
          onSaved={() => { setEdit(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// Edit a single ledger entry (date / description / amounts / mode). The running
// balance recomputes and the change is recorded in the Activity Log.
function EditLedgerModal({ row, onClose, onSaved }: { row: LedgerRow; onClose: () => void; onSaved: () => void }) {
  const [date, setDate] = useState(row.Date_Transaction ?? new Date().toISOString().slice(0, 10))
  const [desc, setDesc] = useState(row.Description ?? '')
  const [receipt, setReceipt] = useState(String(num(row.Receipt_Amount) || ''))
  const [payment, setPayment] = useState(String(num(row.Payment_Amount) || ''))
  const [payType, setPayType] = useState(row.Payment_Type ?? 'Cash')
  const [busy, setBusy] = useState(false)
  const valid = num(receipt) > 0 || num(payment) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await updateLedgerEntry(String(row.Ref_ID), {
      Date_Transaction: date, Description: desc.trim() || row.Nature_Transaction,
      Receipt_Amount: num(receipt), Payment_Amount: num(payment), Payment_Type: payType,
    })
    onSaved()
  }

  return (
    <Modal title={`Edit entry — Ref ${row.Ref_ID}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Save changes</button>
    </>}>
      <p className="text-sm text-slate-400">{row.Nature_Transaction} · {row.Finance_Name}. Editing recomputes the running balance and is logged.</p>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option><option>Account</option><option>Other</option>
          </select>
        </Field>
      </div>
      <Field label="Description"><input className="input" value={desc} onChange={e => setDesc(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Receipt (money in) ₹"><input className="input" inputMode="numeric" value={receipt} onChange={e => setReceipt(e.target.value)} /></Field>
        <Field label="Payment (money out) ₹"><input className="input" inputMode="numeric" value={payment} onChange={e => setPayment(e.target.value)} /></Field>
      </div>
      {num(receipt) > 0 && num(payment) > 0 && <p className="text-xs text-amber-300/80">An entry is usually either a receipt or a payment, not both.</p>}
      <p className="mt-1 text-xs text-slate-500">Note: this edits the cash ledger only — it does not change any linked loan, deposit or interest record.</p>
    </Modal>
  )
}

// Record an expense (money out) or other income (money in), tagged with a
// category from Settings. Both are ordinary ledger entries.
function ManualEntryModal({ kind, finance, onClose, onSaved }: { kind: 'expense' | 'income'; finance: string; onClose: () => void; onSaved: () => void }) {
  const cats = getLedgerCategories()
  const list = kind === 'expense' ? cats.expense : cats.income
  const [category, setCategory] = useState(list[0] ?? '')
  const [amount, setAmount] = useState('')
  const [note, setNote] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [payType, setPayType] = useState('Cash')
  const [busy, setBusy] = useState(false)
  const valid = category && num(amount) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    const input = { finance, amount: num(amount), category, note: note.trim() || undefined, date, payType }
    if (kind === 'expense') await addExpense(input); else await addOtherIncome(input)
    onSaved()
  }

  const isExp = kind === 'expense'
  return (
    <Modal
      title={isExp ? 'Add expense' : 'Add other income'}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className={`btn-primary ${isExp ? '' : '!bg-emerald-600 hover:!bg-emerald-500'}`} disabled={!valid || busy} onClick={save}>{isExp ? 'Record expense' : 'Record income'}</button>
      </>}
    >
      <p className="text-sm text-slate-400">{isExp ? 'Money going out' : 'Money coming in'} — {finance}. Manage categories in Settings.</p>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Category">
          <select className="input" value={category} onChange={e => setCategory(e.target.value)}>
            {list.map(c => <option key={c} value={c}>{c}</option>)}
          </select>
        </Field>
        <Field label="Amount (₹)"><input className="input" inputMode="numeric" autoFocus value={amount} onChange={e => setAmount(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}>
            <option>Cash</option><option>Bank</option><option>UPI</option><option>Cheque</option>
          </select>
        </Field>
      </div>
      <Field label="Note (optional)"><input className="input" value={note} onChange={e => setNote(e.target.value)} placeholder="Reference / remark" /></Field>
    </Modal>
  )
}

function BalanceCorrection({ defaultFinance, onClose, onSaved }: { defaultFinance?: string; onClose: () => void; onSaved: () => void }) {
  const finances = repo.finances()
  const [finance, setFinance] = useState(defaultFinance ?? finances[0]?.Finance_Name ?? '')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [target, setTarget] = useState('')

  const current = finance ? balanceForFinance(finance, date) : 0
  const diff = num(target) - current
  const valid = finance && target.trim() !== '' && diff !== 0

  async function save() {
    await addBalanceCorrection(finance, date, num(target), 'Balance correction')
    onSaved()
  }

  return (
    <Modal
      title="Balance correction"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>Post correction</button>
      </>}
    >
      <p className="text-sm text-slate-400">Adds a ledger entry that makes the finance's balance equal your target as of the date.</p>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Finance">
          <select className="input" value={finance} onChange={e => setFinance(e.target.value)}>
            {finances.map(f => <option key={f.Finance_Name} value={f.Finance_Name}>{f.Finance_Name}</option>)}
          </select>
        </Field>
        <Field label="As of date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      </div>
      <div className="rounded-xl bg-slate-800/40 p-3 text-sm">
        <div className="flex justify-between"><span className="text-slate-400">Current balance</span><span className="font-semibold text-hd">{inr(current)}</span></div>
      </div>
      <Field label="Correct balance should be (₹)"><input className="input" inputMode="numeric" value={target} onChange={e => setTarget(e.target.value)} /></Field>
      {target.trim() !== '' && (
        <p className="text-sm">Adjustment: <span className={`font-semibold ${diff >= 0 ? 'text-emerald-300' : 'text-rose-300'}`}>{diff >= 0 ? '+' : ''}{inr(diff)}</span> {diff >= 0 ? '(receipt)' : '(payment)'}</p>
      )}
    </Modal>
  )
}
