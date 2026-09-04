import { Fragment, useMemo, useState } from 'react'
import { ReceiptText, IndianRupee, Plus, Pencil, Trash2 } from 'lucide-react'
import { repo, payOtherFinanceInterest, addOtherFinanceInterestRow, updateOtherFinanceInterestRow, deleteOtherFinanceInterestRow } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field, ConfirmModal, CallLink } from '../components/ui'
import InterestPayModal from '../components/InterestPayModal'
import ReminderButton from '../components/ReminderButton'
import { inr, fmtDate, num, monthKey, monthName } from '../lib/format'

// Interest the finance OWES the finances it borrowed from, from the schedule.
export default function OtherFinanceInterest() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  // "All finances" is view-only — gate every transaction on a single finance.
  const viewOnly = finance === 'ALL'
  const editable = canEdit(role) && !viewOnly
  const isMd = role === 'md' && !viewOnly
  const [q, setQ] = useState('')
  const [monthSel, setMonthSel] = useState('all')
  const [tick, setTick] = useState(0)
  const [pay, setPay] = useState<any | null>(null)
  const [edit, setEdit] = useState<any | null>(null)
  const [del, setDel] = useState<any | null>(null)
  const [adding, setAdding] = useState(false)

  const { rows, monthTotals, outMap, billed, paid, pending, monthOptions } = useMemo(() => {
    // Current outstanding per borrowing (summed across its rows), shown per line.
    const outMap = new Map<string, number>()
    for (const l of repo.otherFinanceLoans(financeFilter(finance))) outMap.set(l.Loan_No, (outMap.get(l.Loan_No) ?? 0) + num(l.Outstand_Amount))
    let list = repo.otherFinanceInterest(financeFilter(finance))
    const s = q.trim().toLowerCase()
    if (s) list = list.filter((i: any) =>
      String(i.Loan_bought_Finance_Name ?? '').toLowerCase().includes(s) ||
      String(i.Loan_No ?? '').toLowerCase().includes(s) ||
      String(i.Month ?? '').toLowerCase().includes(s))
    // Distinct months present (newest first) for the month picker.
    const monthOptions = [...new Set(list.map((i: any) => i.Month ?? '—'))].sort((a, b) => monthKey(b) - monthKey(a))
    if (monthSel !== 'all') list = list.filter((i: any) => (i.Month ?? '—') === monthSel)
    list = list.slice().sort((a: any, b: any) => monthKey(b.Month) - monthKey(a.Month) || num(b.Interest_Pending) - num(a.Interest_Pending))
    const monthTotals: Record<string, { interest: number; received: number; pending: number }> = {}
    for (const r of list) {
      const m = r.Month ?? '—'
      const t = monthTotals[m] ?? (monthTotals[m] = { interest: 0, received: 0, pending: 0 })
      t.interest += num(r.Interest_Amount); t.received += num(r.Amount_Received); t.pending += num(r.Interest_Pending)
    }
    return { monthTotals, outMap, monthOptions,
      rows: list,
      billed: list.reduce((s2: number, i: any) => s2 + num(i.Interest_Amount), 0),
      paid: list.reduce((s2: number, i: any) => s2 + num(i.Amount_Received), 0),
      pending: list.reduce((s2: number, i: any) => s2 + num(i.Interest_Pending), 0),
    }
  }, [finance, q, tick, monthSel])

  return (
    <div>
      <PageHeader
        title="Other Finance Interest"
        subtitle="Interest you owe the finances you borrowed from."
        action={isMd && <button className="btn-primary !py-1.5" onClick={() => setAdding(true)}><Plus size={15} /> Add interest</button>}
      />

      {canEdit(role) && viewOnly && <p className="mb-3 text-xs text-amber-300/80">Viewing all finances. Pick a single finance in the switcher to add or pay interest.</p>}

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Total interest" value={inr(billed)} tone="blue" icon={<ReceiptText size={18} />} />
        <StatCard label="Paid" value={inr(paid)} tone="green" />
        <StatCard label="Pending" value={inr(pending)} tone="amber" />
      </div>

      <Card className="mb-4 !p-3">
        <div className="flex flex-wrap items-center gap-2">
          <input className="input min-w-[12rem] flex-1" placeholder="Search finance, FIN no., month…" value={q} onChange={e => setQ(e.target.value)} />
          <select className="input !w-auto" value={monthSel} onChange={e => setMonthSel(e.target.value)}>
            <option value="all">All months</option>
            {monthOptions.map((m: string) => <option key={m} value={m}>{monthName(m)}</option>)}
          </select>
        </div>
      </Card>

      {rows.length === 0 ? <EmptyState title="No other-finance interest yet" hint="Run Interest posting to generate lines." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th sticky>Finance</Th><Th>FIN no.</Th><Th right>Outstanding</Th><Th>Period</Th><Th right>Interest</Th><Th right>Paid</Th><Th right>Pending</Th><Th>Status</Th><Th>Remind</Th>{editable && <Th>Pay</Th>}{isMd && <Th>Edit</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.slice(0, 300).map((i: any, k: number, arr: any[]) => (
                  <Fragment key={k}>
                    {(k === 0 || arr[k - 1].Month !== i.Month) && (
                      <tr className="bg-slate-900/80"><td colSpan={9 + (editable ? 1 : 0) + (isMd ? 1 : 0)} className="px-3 py-1.5">
                        <div className="flex flex-wrap items-center gap-3">
                          <span className="text-xs font-semibold uppercase tracking-wide text-brand-300">{i.Month}</span>
                          <span className="text-xs text-slate-400">Interest <b className="text-hd">{inr(monthTotals[i.Month ?? '—']?.interest ?? 0)}</b> · Received <b className="text-emerald-300">{inr(monthTotals[i.Month ?? '—']?.received ?? 0)}</b> · Pending <b className="text-amber-300">{inr(monthTotals[i.Month ?? '—']?.pending ?? 0)}</b></span>
                        </div>
                      </td></tr>
                    )}
                    <tr className="group hover:bg-slate-800/40">
                      <Td sticky className="text-slate-200">
                        <div className="flex items-center gap-2">
                          <span>{i.Loan_bought_Finance_Name}</span>
                          <CallLink phone={repo.otherFinanceLoans().find((l: any) => l.Loan_No === i.Loan_No)?.Loan_bought_Finance_Phone_No} />
                        </div>
                      </Td>
                      <Td className="text-slate-400">{i.Loan_No}</Td>
                      <Td right className="text-slate-300">{inr(outMap.get(i.Loan_No) ?? 0)}</Td>
                      <Td className="text-xs text-slate-500">
                        <div>{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</div>
                        {i.Description && <div className="mt-0.5 text-[11px] text-slate-400">{i.Description}</div>}
                      </Td>
                      <Td right className="text-hd">{inr(num(i.Interest_Amount))}</Td>
                      <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                      <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                      <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                      <Td>
                        <ReminderButton
                          label="" className="btn-ghost !px-2 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"
                          header={`${i.Loan_No}-${i.Loan_bought_Finance_Name}`} totalLabel="Total Interest Pending"
                          phone={repo.otherFinanceLoans().find((l: any) => l.Loan_No === i.Loan_No)?.Loan_bought_Finance_Phone_No}
                          items={repo.otherFinanceInterestByCode(i.Loan_No).map((r: any) => ({ month: r.Month, amount: num(r.Interest_Amount), pending: num(r.Interest_Pending) }))}
                        />
                      </Td>
                      {editable && (
                        <Td>
                          {num(i.Interest_Pending) > 0
                            ? <button className="btn-ghost !px-2.5 !py-1 text-xs text-amber-300 ring-1 ring-inset ring-amber-500/30"
                                onClick={() => setPay(i)}><IndianRupee size={13} /> Pay</button>
                            : <span className="text-xs text-slate-600">—</span>}
                        </Td>
                      )}
                      {isMd && (
                        <Td>
                          <div className="flex gap-1">
                            <button title="Edit" className="btn-ghost !px-2 !py-1 text-xs" onClick={() => setEdit(i)}><Pencil size={13} /></button>
                            <button title="Delete" className="btn-ghost !px-2 !py-1 text-xs text-rose-300" onClick={() => setDel(i)}><Trash2 size={13} /></button>
                          </div>
                        </Td>
                      )}
                    </tr>
                  </Fragment>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {pay && (
        <InterestPayModal
          title="Pay other-finance interest"
          name={pay.Loan_bought_Finance_Name}
          code={pay.Loan_No}
          month={pay.Month}
          pending={num(pay.Interest_Pending)}
          onPay={(amount, date, payType, note) => payOtherFinanceInterest(pay.ID, amount, date, payType, note)}
          onClose={() => setPay(null)}
          onSaved={() => { setPay(null); setTick(t => t + 1) }}
        />
      )}

      {(adding || edit) && (
        <OtherFinanceInterestForm
          finance={financeFilter(finance)}
          row={edit}
          onClose={() => { setAdding(false); setEdit(null) }}
          onSaved={() => { setAdding(false); setEdit(null); setTick(t => t + 1) }}
        />
      )}

      {del && (
        <ConfirmModal
          title="Delete other-finance interest"
          message={<>Delete interest for <b className="text-hd">{del.Loan_bought_Finance_Name}</b> · {del.Loan_No} · {del.Month} ({inr(num(del.Interest_Amount))})? Restorable from the Log.</>}
          onConfirm={async () => { await deleteOtherFinanceInterestRow(del.ID); setDel(null); setTick(t => t + 1) }}
          onClose={() => setDel(null)}
        />
      )}
    </div>
  )
}

// Add or edit an other-finance interest row (admin correction). Logged.
function OtherFinanceInterestForm({ finance, row, onClose, onSaved }: {
  finance?: string; row: any | null; onClose: () => void; onSaved: () => void
}) {
  const editing = !!row
  const loans = useMemo(() => repo.otherFinanceLoans(finance), [finance])
  const [code, setCode] = useState(row?.Loan_No ?? '')
  const [month, setMonth] = useState(row?.Month ?? '')
  const [from, setFrom] = useState(row?.From_Date ?? '')
  const [to, setTo] = useState(row?.To_Date ?? '')
  const [amount, setAmount] = useState(String(num(row?.Interest_Amount) || ''))
  const [received, setReceived] = useState(String(num(row?.Amount_Received) || ''))
  const [busy, setBusy] = useState(false)

  const loan = loans.find(l => l.Loan_No === code)
  const pending = Math.max(0, num(amount) - num(received))
  const valid = code && month.trim() && num(amount) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    const status = num(received) >= num(amount) ? 'Paid' : num(received) > 0 ? 'Partial' : 'Pending'
    const common = { Month: month.trim(), From_Date: from || undefined, To_Date: to || undefined, Interest_Amount: num(amount), Amount_Received: num(received), Interest_Pending: pending, Status: status }
    if (editing && row) await updateOtherFinanceInterestRow(row.ID, { ...common, Loan_No: code })
    else await addOtherFinanceInterestRow({ ...common, Loan_No: code, Loan_bought_Finance_Name: loan?.Loan_bought_Finance_Name ?? '', Finance_Name: loan?.Finance_Name ?? finance ?? '' })
    onSaved()
  }

  return (
    <Modal title={editing ? `Edit other-finance interest — ${row?.Loan_No}` : 'Add other-finance interest'} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>{editing ? 'Save changes' : 'Add interest'}</button>
    </>}>
      {!editing && (
        <Field label="Lender / loan">
          <select className="input" value={code} onChange={e => setCode(e.target.value)}>
            <option value="">Select…</option>
            {loans.map(l => <option key={l.Loan_No} value={l.Loan_No}>{l.Loan_bought_Finance_Name} · {l.Loan_No}</option>)}
          </select>
        </Field>
      )}
      <div className="grid grid-cols-3 gap-3">
        <Field label="Month" hint="MM-YYYY"><input className="input" value={month} onChange={e => setMonth(e.target.value)} placeholder="08-2026" /></Field>
        <Field label="From"><input type="date" className="input" value={from} onChange={e => setFrom(e.target.value)} /></Field>
        <Field label="To"><input type="date" className="input" value={to} onChange={e => setTo(e.target.value)} /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Interest amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Received (₹)"><input className="input" inputMode="numeric" value={received} onChange={e => setReceived(e.target.value)} /></Field>
      </div>
      <p className="text-sm text-slate-400">Pending: <b className="text-amber-300">{inr(pending)}</b></p>
    </Modal>
  )
}
