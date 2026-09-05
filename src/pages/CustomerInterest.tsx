import { useMemo, useState } from 'react'
import { Percent, IndianRupee, Plus, Pencil, Trash2, Users } from 'lucide-react'
import { repo, repayCustomer, updateInterestRow, addInterestRow, deleteInterestRow } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field, ConfirmModal, CallLink } from '../components/ui'
import CustomerInterestPayModal from '../components/CustomerInterestPayModal'
import ReminderButton from '../components/ReminderButton'
import { inr, fmtDate, num, monthKey, monthName } from '../lib/format'
import type { InterestRow } from '../data/types'

// Customer loan interest details, with a per-line "pay interest" action.
export default function CustomerInterest() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  // "All finances" is a combined VIEW only — no transactions until a single
  // finance is picked, so every add/collect/edit action is gated on this.
  const viewOnly = finance === 'ALL'
  const editable = canEdit(role) && !viewOnly
  const isMd = role === 'md' && !viewOnly
  const [q, setQ] = useState('')
  const [monthSel, setMonthSel] = useState('all')
  const [tick, setTick] = useState(0)
  const [pay, setPay] = useState<any | null>(null)
  const [edit, setEdit] = useState<InterestRow | null>(null)
  const [del, setDel] = useState<InterestRow | null>(null)
  const [adding, setAdding] = useState(false)

  const { flat, rowCount, outMap, billed, paid, pending, monthOptions } = useMemo(() => {
    const ff = financeFilter(finance)
    // Current outstanding per loan, to show alongside each interest line.
    const outMap = new Map<string, number>()
    for (const l of repo.loans(ff)) outMap.set(l.Loan_No, num(l.Outstand_Amount))
    // Partner id → name, and the set of referred partners across each customer's
    // loans (used to attribute an "All loans" interest line to a partner).
    const pname = new Map<string, string>()
    for (const p of repo.partners(ff)) pname.set(p.Partner_ID, p.Partner_Name)
    const custPartners = new Map<string, Set<string>>()
    for (const l of repo.loans(ff)) if (l.Referred_Partner) {
      const set = custPartners.get(l.Customer_STL_NO) ?? new Set<string>()
      set.add(l.Referred_Partner); custPartners.set(l.Customer_STL_NO, set)
    }
    // Which partner an interest line belongs to, via its loan(s): a single-loan
    // line follows that loan's partner; an "All loans" line follows its
    // customer's loans — the sole partner if they all share one, else "Unmatched
    // partner". Lines whose loan(s) carry no partner fall under "No partner".
    // rank orders groups within a month: partners first, No partner, Unmatched last.
    const groupOf = (i: InterestRow): { key: string; name: string; rank: number } => {
      let pids: Set<string>
      if (i.Loan_No) {
        const l = repo.loan(i.Loan_No)
        pids = l ? new Set(l.Referred_Partner ? [l.Referred_Partner] : []) : (custPartners.get(i.Customer_STL_NO) ?? new Set())
      } else {
        pids = custPartners.get(i.Customer_STL_NO) ?? new Set()
      }
      if (pids.size === 0) return { key: '__NONE__', name: 'No partner', rank: 1 }
      if (pids.size === 1) { const id = [...pids][0]; return { key: id, name: pname.get(id) || id, rank: 0 } }
      return { key: '__UNMATCHED__', name: 'Unmatched partner', rank: 2 }
    }

    let list = repo.interest(ff)
    const s = q.trim().toLowerCase()
    if (s) list = list.filter(i =>
      String(i.Customer_Name ?? '').toLowerCase().includes(s) ||
      String(i.Customer_STL_NO ?? '').toLowerCase().includes(s) ||
      String(i.Loan_No ?? '').toLowerCase().includes(s) ||
      String(i.Month ?? '').toLowerCase().includes(s))
    // Distinct months present (newest first) for the month picker.
    const monthOptions = [...new Set(list.map(i => i.Month ?? '—'))].sort((a, b) => monthKey(b) - monthKey(a))
    if (monthSel !== 'all') list = list.filter(i => (i.Month ?? '—') === monthSel)
    list = list.slice().sort((a, b) =>
      monthKey(b.Month) - monthKey(a.Month) ||
      String(a.Customer_STL_NO ?? '').localeCompare(String(b.Customer_STL_NO ?? ''), undefined, { numeric: true }) ||
      num(b.Interest_Pending) - num(a.Interest_Pending))

    // Nest the lines: month → partner group → rows, each level carrying totals.
    type Totals = { interest: number; received: number; pending: number }
    type Grp = Totals & { name: string; rank: number; rows: InterestRow[] }
    type Mon = Totals & { groups: Map<string, Grp> }
    const add = (t: Totals, r: InterestRow) => {
      t.interest += num(r.Interest_Amount); t.received += num(r.Amount_Received); t.pending += num(r.Interest_Pending)
    }
    const months = new Map<string, Mon>()
    for (const r of list) {
      const m = r.Month ?? '—'
      let mo = months.get(m); if (!mo) { mo = { interest: 0, received: 0, pending: 0, groups: new Map() }; months.set(m, mo) }
      add(mo, r)
      const g = groupOf(r)
      let gr = mo.groups.get(g.key); if (!gr) { gr = { name: g.name, rank: g.rank, interest: 0, received: 0, pending: 0, rows: [] }; mo.groups.set(g.key, gr) }
      add(gr, r); gr.rows.push(r)
    }

    // Flatten to a render list (header/sub-header/row items), capped at 300 rows.
    type Item =
      | { t: 'month'; key: string; label: string } & Totals
      | { t: 'partner'; key: string; name: string } & Totals
      | { t: 'row'; key: string; i: InterestRow }
    const flat: Item[] = []
    let shown = 0
    outer: for (const m of [...months.keys()].sort((a, b) => monthKey(b) - monthKey(a))) {
      const mo = months.get(m)!
      flat.push({ t: 'month', key: 'm:' + m, label: m, interest: mo.interest, received: mo.received, pending: mo.pending })
      const groups = [...mo.groups.entries()].sort((a, b) => a[1].rank - b[1].rank || a[1].name.localeCompare(b[1].name))
      for (const [gk, gr] of groups) {
        flat.push({ t: 'partner', key: 'p:' + m + '|' + gk, name: gr.name, interest: gr.interest, received: gr.received, pending: gr.pending })
        for (const r of gr.rows) {
          flat.push({ t: 'row', key: 'r:' + (r.ID ?? (m + '|' + gk + '|' + shown)), i: r })
          if (++shown >= 300) break outer
        }
      }
    }

    return {
      flat, rowCount: shown, outMap, monthOptions,
      billed: list.reduce((s2, i) => s2 + num(i.Interest_Amount), 0),
      paid: list.reduce((s2, i) => s2 + num(i.Amount_Received), 0),
      pending: list.reduce((s2, i) => s2 + num(i.Interest_Pending), 0),
    }
  }, [finance, q, tick, monthSel])

  const cols = 9 + (editable ? 1 : 0) + (isMd ? 1 : 0)

  return (
    <div>
      <PageHeader
        title="Customer Interest"
        subtitle="Interest billed on customer loans — collect pending interest per line."
        action={isMd && <button className="btn-primary !py-1.5" onClick={() => setAdding(true)}><Plus size={15} /> Add interest</button>}
      />

      {canEdit(role) && viewOnly && <p className="mb-3 text-xs text-amber-300/80">Viewing all finances. Pick a single finance in the switcher to add or collect interest.</p>}

      <div className="mb-4 grid grid-cols-3 gap-3">
        <StatCard label="Total interest" value={inr(billed)} tone="blue" icon={<Percent size={18} />} />
        <StatCard label="Collected" value={inr(paid)} tone="green" />
        <StatCard label="Pending" value={inr(pending)} tone="amber" />
      </div>

      <Card className="mb-4 !p-3">
        <div className="flex flex-wrap items-center gap-2">
          <input className="input min-w-[12rem] flex-1" placeholder="Search customer, STL no., loan no., month…" value={q} onChange={e => setQ(e.target.value)} />
          <select className="input !w-auto" value={monthSel} onChange={e => setMonthSel(e.target.value)}>
            <option value="all">All months</option>
            {monthOptions.map(m => <option key={m} value={m}>{monthName(m)}</option>)}
          </select>
        </div>
      </Card>

      {rowCount === 0 ? <EmptyState title="No customer interest yet" hint="Run Interest posting to generate lines." /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="max-h-[70vh] overflow-auto">
            <table className="w-full">
              <thead className="sticky top-0 z-30 border-b border-slate-800 bg-slate-900">
                <tr><Th sticky>Customer</Th><Th>STL No.</Th><Th right>Outstanding</Th><Th>Period</Th><Th right>Interest</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th><Th>Remind</Th>{editable && <Th>Collect</Th>}{isMd && <Th>Edit</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {flat.map(item => {
                  if (item.t === 'month') return (
                    <tr key={item.key} className="bg-slate-900/80"><td colSpan={cols} className="px-3 py-1.5">
                      <div className="flex flex-wrap items-center gap-3">
                        <span className="text-xs font-semibold uppercase tracking-wide text-brand-300">{monthName(item.label)}</span>
                        <span className="text-xs text-slate-400">Interest <b className="text-hd">{inr(item.interest)}</b> · Received <b className="text-emerald-300">{inr(item.received)}</b> · Pending <b className="text-amber-300">{inr(item.pending)}</b></span>
                      </div>
                    </td></tr>
                  )
                  if (item.t === 'partner') return (
                    <tr key={item.key} className="bg-slate-900/50"><td colSpan={cols} className="px-3 py-1.5 pl-6">
                      <div className="flex flex-wrap items-center gap-3">
                        <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-200"><Users size={12} className="text-slate-400" />{item.name}</span>
                        <span className="text-[11px] text-slate-400">Interest <b className="text-hd">{inr(item.interest)}</b> · Received <b className="text-emerald-300">{inr(item.received)}</b> · Pending <b className="text-amber-300">{inr(item.pending)}</b></span>
                      </div>
                    </td></tr>
                  )
                  const i = item.i
                  return (
                    <tr key={item.key} className="group hover:bg-slate-800/40">
                      <Td sticky className="text-slate-200">
                        <div className="flex items-center gap-2">
                          <span>{i.Customer_Name}</span>
                          <CallLink phone={repo.customer(i.Customer_STL_NO)?.Customer_Phone_No} />
                        </div>
                      </Td>
                      <Td className="text-slate-400">{i.Customer_STL_NO}</Td>
                      <Td right className="text-slate-300">{inr(i.Loan_No ? (outMap.get(i.Loan_No) ?? 0) : num(i.Loan_Amount))}</Td>
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
                          header={`${i.Customer_STL_NO}-${i.Customer_Name}`}
                          phone={repo.customer(i.Customer_STL_NO)?.Customer_Phone_No}
                          items={repo.interestByCustomer(i.Customer_STL_NO).map(r => ({ month: r.Month, amount: num(r.Interest_Amount), pending: num(r.Interest_Pending) }))}
                        />
                      </Td>
                      {editable && (
                        <Td>
                          {num(i.Interest_Pending) > 0
                            ? <button className="btn-ghost !px-2.5 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30"
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
                  )
                })}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {pay && (
        <CustomerInterestPayModal
          name={pay.Customer_Name}
          rows={repo.interestByCustomer(pay.Customer_STL_NO)}
          onPay={(amount, date, payType, note) => repayCustomer({ stl: pay.Customer_STL_NO, principal: 0, interest: amount, date, payType, note })}
          onClose={() => setPay(null)}
          onSaved={() => { setPay(null); setTick(t => t + 1) }}
        />
      )}

      {(adding || edit) && (
        <InterestFormModal
          finance={financeFilter(finance)}
          row={edit}
          onClose={() => { setAdding(false); setEdit(null) }}
          onSaved={() => { setAdding(false); setEdit(null); setTick(t => t + 1) }}
        />
      )}

      {del && (
        <ConfirmModal
          title="Delete interest row"
          message={<>Delete interest for <b className="text-hd">{del.Customer_Name}</b> · {del.Loan_No} · {del.Month} ({inr(num(del.Interest_Amount))})? Restorable from the Log.</>}
          onConfirm={async () => { await deleteInterestRow(del.ID); setDel(null); setTick(t => t + 1) }}
          onClose={() => setDel(null)}
        />
      )}
    </div>
  )
}

// Add a new customer-interest row, or edit an existing one. Recomputes the
// customer's totals and records the change in the Activity Log.
function InterestFormModal({ finance, row, onClose, onSaved }: {
  finance?: string; row: InterestRow | null; onClose: () => void; onSaved: () => void
}) {
  const editing = !!row
  const customers = useMemo(() => repo.customers(finance), [finance])
  const [stl, setStl] = useState(row?.Customer_STL_NO ?? '')
  const loans = useMemo(() => stl ? repo.loansByCustomer(stl) : [], [stl])
  const [loanNo, setLoanNo] = useState(row?.Loan_No ?? '')
  const [month, setMonth] = useState(row?.Month ?? '')
  const [from, setFrom] = useState(row?.From_Date ?? '')
  const [to, setTo] = useState(row?.To_Date ?? '')
  const [amount, setAmount] = useState(String(num(row?.Interest_Amount) || ''))
  const [busy, setBusy] = useState(false)

  const cust = customers.find(c => c.Customer_STL_NO === stl)
  // Received is never edited here — it changes only through the Collect flow. We
  // keep whatever was already received (0 for a new row) and re-derive pending.
  const received = num(row?.Amount_Received)
  const pending = Math.max(0, num(amount) - received)
  // When editing an existing row the customer/loan are fixed (a consolidated
  // multi-loan row has no Loan_No at all), so only the amount/month matter. Adding
  // a new row still needs a customer + loan chosen.
  const valid = editing
    ? month.trim().length > 0 && num(amount) > 0
    : Boolean(stl && loanNo && month.trim() && num(amount) > 0)

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    const status = received >= num(amount) ? 'Paid' : received > 0 ? 'Partial' : 'Pending'
    if (editing && row) {
      await updateInterestRow(row.ID, {
        Month: month.trim(), From_Date: from || undefined, To_Date: to || undefined,
        Interest_Amount: num(amount), Amount_Received: received, Interest_Pending: pending, Status: status,
      })
    } else {
      await addInterestRow({
        Finance_Name: cust?.Finance_Name ?? finance ?? '', Loan_No: loanNo,
        Customer_STL_NO: stl, Customer_Name: cust?.Customer_Name ?? '',
        Month: month.trim(), From_Date: from || undefined, To_Date: to || undefined,
        Interest_Amount: num(amount), Amount_Received: received, Interest_Pending: pending, Status: status,
      })
    }
    onSaved()
  }

  return (
    <Modal title={editing ? `Edit interest — ${row?.Loan_No}` : 'Add customer interest'} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>{editing ? 'Save changes' : 'Add interest'}</button>
    </>}>
      {!editing && (
        <div className="grid grid-cols-2 gap-3">
          <Field label="Customer">
            <select className="input" value={stl} onChange={e => { setStl(e.target.value); setLoanNo('') }}>
              <option value="">Select…</option>
              {customers.map(c => <option key={c.Customer_STL_NO} value={c.Customer_STL_NO}>{c.Customer_Name}</option>)}
            </select>
          </Field>
          <Field label="Loan">
            <select className="input" value={loanNo} onChange={e => setLoanNo(e.target.value)} disabled={!stl}>
              <option value="">Select…</option>
              {loans.map(l => <option key={l.Loan_No} value={l.Loan_No}>{l.Loan_No} · {inr(num(l.Loan_Amount))}</option>)}
            </select>
          </Field>
        </div>
      )}
      <div className="grid grid-cols-3 gap-3">
        <Field label="Month" hint="MM-YYYY"><input className="input" value={month} onChange={e => setMonth(e.target.value)} placeholder="08-2026" /></Field>
        <Field label="From"><input type="date" className="input" value={from} onChange={e => setFrom(e.target.value)} /></Field>
        <Field label="To"><input type="date" className="input" value={to} onChange={e => setTo(e.target.value)} /></Field>
      </div>
      <Field label="Interest amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
      {editing && received > 0 && <p className="text-sm text-slate-400">Received <b className="text-emerald-300">{inr(received)}</b> · Pending <b className="text-amber-300">{inr(pending)}</b></p>}
    </Modal>
  )
}
