import { useMemo, useState } from 'react'
import { Link, useParams, useSearchParams, useNavigate } from 'react-router-dom'
import { ArrowLeft, Building2, HandCoins, Percent, Plus, IndianRupee, BookText, Pencil } from 'lucide-react'
import { repo, repayOtherFinance, payOtherFinanceInterest, editOtherFinance, updateOtherFinanceProfile } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Tabs, Modal, Field } from '../components/ui'
import LiabilityRepayModal from '../components/LiabilityRepayModal'
import InterestPayModal from '../components/InterestPayModal'
import LedgerTable from '../components/LedgerTable'
import ReminderButton from '../components/ReminderButton'
import { inr, phone, fmtDate, num, monthName, monthKey } from '../lib/format'

type TabKey = 'borrowings' | 'interest' | 'ledger'

export default function OtherFinanceDetail() {
  const { code = '' } = useParams()
  const id = decodeURIComponent(code)
  const role = useApp(s => s.user?.role)
  const finance = useApp(s => s.finance)
  const setFinance = useApp(s => s.setFinance)
  const navigate = useNavigate()
  // "All finances" is view-only — switch to this borrowing's finance to transact.
  const viewOnly = finance === 'ALL'
  const editable = canEdit(role) && !viewOnly
  const isMd = role === 'md' && !viewOnly
  const [sp] = useSearchParams()
  const doParam = sp.get('do')
  const [tick, setTick] = useState(0)
  const [tab, setTab] = useState<TabKey>(doParam === 'interest' ? 'interest' : 'borrowings')
  const [modal, setModal] = useState<'repay' | 'interest' | null>(
    editable && (doParam === 'repay' || doParam === 'interest') ? (doParam as 'repay' | 'interest') : null,
  )
  const [pay, setPay] = useState<any | null>(null)
  const [editProfile, setEditProfile] = useState(false)
  const [editRow, setEditRow] = useState<any | null>(null)

  const { rows, ledger, interest, interestPending, outstanding, borrowed, first } = useMemo(() => {
    const rows = repo.otherFinanceByCode(id)
    const ledger = repo.ledgerByRef(id)
    const interest = repo.otherFinanceInterestByCode(id)
    return {
      rows, ledger, interest,
      interestPending: interest.reduce((s: number, i: any) => s + num(i.Interest_Pending), 0),
      outstanding: rows.reduce((s, o) => s + num(o.Outstand_Amount), 0),
      borrowed: rows.reduce((s, o) => s + num(o.Loan_Amount), 0),
      first: rows[0],
    }
  }, [id, tick])

  if (!first) return <EmptyState title="Other-finance loan not found" />
  const type = first.Interest_Type || 'Per_Day'
  const perDay = num(first.Interest_Per_day_Per_Lakh)
  const perMonth = typeof first.Interest_Per_Month_Per_Lakh === 'number' ? first.Interest_Per_Month_Per_Lakh : 0

  return (
    <div>
      <Link to="/other-finance" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Other-finance</Link>
      <PageHeader
        title={first.Loan_bought_Finance_Name}
        subtitle={`${id} · ${first.Finance_Name}`}
        action={
          <div className="flex items-center gap-2">
            <Badge tone={statusTone(first.Loan_Status)}>{first.Loan_Status ?? '—'}</Badge>
            <ReminderButton
              header={`${id}-${first.Loan_bought_Finance_Name}`}
              phone={first.Loan_bought_Finance_Phone_No}
              items={interest.map((i: any) => ({ month: i.Month, amount: num(i.Interest_Amount), pending: num(i.Interest_Pending) }))}
            />
            {editable && (
              <button className="btn-ghost !py-1.5" onClick={() => setEditProfile(true)}><Pencil size={15} /> Edit</button>
            )}
            {editable && (
              <button className="btn-primary !py-1.5" onClick={() => { setFinance(first.Finance_Name); navigate(`/other-finance?new=1&code=${encodeURIComponent(id)}`) }}>
                <Plus size={15} /> Add loan
              </button>
            )}
            {editable && outstanding > 0 && <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setModal('repay')}><HandCoins size={15} /> Repay</button>}
            {editable && repo.otherFinanceInterestPending(id) > 0 && <button className="btn-ghost !py-1.5 text-amber-300 ring-1 ring-inset ring-amber-500/30" onClick={() => { setTab('interest'); setModal('interest') }}><Percent size={15} /> Pay interest</button>}
          </div>
        }
      />

      {canEdit(role) && viewOnly && (
        <p className="mb-4 text-xs text-amber-300/80">
          Viewing all finances (read-only).{' '}
          <button className="font-semibold text-brand-300 underline hover:text-brand-200" onClick={() => setFinance(first.Finance_Name)}>Switch to {first.Finance_Name}</button>{' '}to repay or pay interest.
        </p>
      )}

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span>{phone(first.Loan_bought_Finance_Phone_No)}</span>
        {first.Loan_bought_Finance_Address && <span>{first.Loan_bought_Finance_Address}</span>}
      </div>

      <div className="mb-6 grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Total borrowed" value={inr(borrowed)} tone="blue" icon={<Building2 size={18} />} />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
        <StatCard label="Interest payable" value={inr(interestPending)} tone="amber" />
        <StatCard label="Rate" value={type === 'Per_Month' ? `₹${perMonth}/L·mo` : `₹${perDay}/L·day`} tone="slate" />
      </div>

      <Tabs<TabKey>
        active={tab}
        onChange={setTab}
        tabs={[
          { key: 'borrowings', label: <span className="flex items-center gap-1.5"><Building2 size={14} /> Borrowings</span>, badge: rows.length || '' },
          { key: 'interest', label: <span className="flex items-center gap-1.5"><Percent size={14} /> Interest</span>, badge: interestPending > 0 ? '!' : '' },
          { key: 'ledger', label: <span className="flex items-center gap-1.5"><BookText size={14} /> Ledger</span>, badge: ledger.length || '' },
        ]}
      />

      {tab === 'borrowings' && (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Bought</Th><Th right>Amount</Th><Th>Rate</Th><Th right>Repaid</Th><Th right>Outstanding</Th><Th>Status</Th>{isMd && <Th>Edit</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((o, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-400">{fmtDate(o.Loan_Bought_Date)}</Td>
                    <Td right className="text-hd">{inr(num(o.Loan_Amount))}</Td>
                    <Td className="text-slate-300">{o.Interest_Type === 'Per_Month' ? `₹${num(o.Interest_Per_Month_Per_Lakh)}/L·mo` : `₹${num(o.Interest_Per_day_Per_Lakh)}/L·day`}</Td>
                    <Td right className="text-emerald-400">{inr(num(o.Repaid_Amount))}</Td>
                    <Td right className="text-rose-300">{inr(num(o.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(o.Loan_Status)}>{o.Loan_Status ?? '—'}</Badge></Td>
                    {isMd && <Td><button title="Edit borrowing" className="btn-ghost !px-2 !py-1 text-xs" onClick={() => setEditRow(o)}><Pencil size={13} /></button></Td>}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {tab === 'interest' && (
        interest.length === 0 ? <EmptyState title="No interest postings yet" /> : (
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Month</Th><Th>Period</Th><Th right>Interest</Th><Th right>Paid</Th><Th right>Pending</Th><Th>Status</Th>{editable && <Th>Collect</Th>}</tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {interest.slice().sort((a: any, b: any) => (monthKey(b.Month) - monthKey(a.Month)) || String(b.To_Date ?? '').localeCompare(String(a.To_Date ?? ''))).map((i: any, k: number) => (
                    <tr key={k} className="hover:bg-slate-800/40">
                      <Td className="text-slate-300">{monthName(i.Month)}</Td>
                      <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                      <Td right className="text-hd">{inr(num(i.Interest_Amount))}</Td>
                      <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                      <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                      <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                      {editable && (
                        <Td>
                          {num(i.Interest_Pending) > 0
                            ? <button title="Pay interest" className="btn-ghost !px-2.5 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setPay(i)}><IndianRupee size={13} /> Pay</button>
                            : <span className="text-xs text-slate-600">—</span>}
                        </Td>
                      )}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        )
      )}

      {tab === 'ledger' && (
        <LedgerTable
          rows={ledger}
          canManage={isMd}
          emptyHint="Borrowing, refund and interest movements appear here."
          onChanged={() => setTick(t => t + 1)}
        />
      )}

      {modal && (
        <LiabilityRepayModal
          title={modal === 'interest' ? `Pay interest — ${first.Loan_bought_Finance_Name}` : `Other-finance — ${first.Loan_bought_Finance_Name}`}
          name={first.Loan_bought_Finance_Name}
          code={id}
          outstanding={outstanding}
          pendingInterest={repo.otherFinanceInterestPending(id)}
          interestOnly={modal === 'interest'}
          rateLabel={type === 'Per_Month' ? `₹${perMonth}/L·mo` : `₹${perDay}/L·day`}
          debts={rows.filter(l => num(l.Outstand_Amount) > 0)
            .sort((a, b) => new Date(a.Loan_Bought_Date ?? 0).getTime() - new Date(b.Loan_Bought_Date ?? 0).getTime())
            .map((l) => ({
              key: `${l.Loan_Bought_Date ?? ''}|${num(l.Loan_Amount)}`,
              outstanding: num(l.Outstand_Amount),
              type: l.Interest_Type,
              perDay: num(l.Interest_Per_day_Per_Lakh),
              perMonth: typeof l.Interest_Per_Month_Per_Lakh === 'number' ? l.Interest_Per_Month_Per_Lakh : 0,
              lastTo: repo.otherFinancePostedUpto(id),
              givenDate: l.Loan_Bought_Date,
            }))}
          onRepay={(principal, interestAmt, date, payType, note, accruals, targetKey, accrualInterest) => repayOtherFinance({
            code: id, principal, interest: interestAmt, accrualInterest, date, payType, note, targetKey,
            accruals: (accruals ?? []).map((a, i) => ({
              ID: `${id}-repay-${Date.now()}-${i}`,
              Finance_Name: first.Finance_Name, Loan_No: id, Loan_bought_Finance_Name: first.Loan_bought_Finance_Name,
              From_Date: a.from, To_Date: a.to, Interest_Amount: a.amount, Loan_Amount: a.base,
              Month: a.month, Description: `Interest on ₹${a.base.toLocaleString('en-IN')} refunded`,
              Amount_Received: 0, Status: 'Pending', Interest_Pending: a.amount,
            })),
          })}
          onClose={() => setModal(null)}
          onSaved={() => { setModal(null); setTick(t => t + 1) }}
        />
      )}

      {pay && (
        <InterestPayModal
          title="Pay other-finance interest"
          name={first.Loan_bought_Finance_Name}
          code={id}
          month={pay.Month}
          pending={num(pay.Interest_Pending)}
          onPay={(amount, date, payType, note) => payOtherFinanceInterest(pay.ID, amount, date, payType, note)}
          onClose={() => setPay(null)}
          onSaved={() => { setPay(null); setTick(t => t + 1) }}
        />
      )}

      {editProfile && (
        <EditLenderModal
          code={id} first={first}
          onClose={() => setEditProfile(false)}
          onSaved={() => { setEditProfile(false); setTick(t => t + 1) }}
        />
      )}

      {editRow && (
        <EditBorrowingRowModal
          row={editRow}
          onClose={() => setEditRow(null)}
          onSaved={() => { setEditRow(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// Edit the lender's own details — applied to every borrowing under this code.
function EditLenderModal({ code, first, onClose, onSaved }: { code: string; first: any; onClose: () => void; onSaved: () => void }) {
  const [name, setName] = useState(first.Loan_bought_Finance_Name ?? '')
  const [phoneNo, setPhoneNo] = useState(String(first.Loan_bought_Finance_Phone_No ?? ''))
  const [email, setEmail] = useState(first.Loan_bought_Finance_Email ?? '')
  const [address, setAddress] = useState(first.Loan_bought_Finance_Address ?? '')
  const [busy, setBusy] = useState(false)
  const valid = name.trim().length > 0 && !busy

  async function save() {
    if (!valid) return
    setBusy(true)
    await updateOtherFinanceProfile(code, {
      Loan_bought_Finance_Name: name.trim(),
      Loan_bought_Finance_Phone_No: phoneNo.trim() || undefined,
      Loan_bought_Finance_Email: email.trim() || undefined,
      Loan_bought_Finance_Address: address.trim() || undefined,
    })
    onSaved()
  }

  return (
    <Modal title={`Edit lender — ${first.Loan_bought_Finance_Name}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid} onClick={save}>Save changes</button>
    </>}>
      <Field label="Finance / lender name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Phone"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
        <Field label="Email"><input className="input" value={email} onChange={e => setEmail(e.target.value)} /></Field>
      </div>
      <Field label="Address"><input className="input" value={address} onChange={e => setAddress(e.target.value)} /></Field>
      <p className="text-xs text-slate-500">Applies to all borrowings under {code}.</p>
    </Modal>
  )
}

// Edit one borrowing's financials — amount, outstanding, rate (drives future
// interest posting), type and status. Repaid is kept as amount − outstanding.
function EditBorrowingRowModal({ row, onClose, onSaved }: { row: any; onClose: () => void; onSaved: () => void }) {
  const [amount, setAmount] = useState(String(num(row.Loan_Amount)))
  const [outstanding, setOutstanding] = useState(String(num(row.Outstand_Amount)))
  const [type, setType] = useState(row.Interest_Type === 'Per_Month' ? 'Per_Month' : 'Per_Day')
  const [rate, setRate] = useState(String(row.Interest_Type === 'Per_Month' ? num(row.Interest_Per_Month_Per_Lakh) : num(row.Interest_Per_day_Per_Lakh)))
  const [status, setStatus] = useState(row.Loan_Status ?? 'Active')
  const [busy, setBusy] = useState(false)
  const amt = num(amount), out = num(outstanding)
  const valid = amt > 0 && out >= 0 && out <= amt && !busy

  async function save() {
    if (!valid) return
    setBusy(true)
    await editOtherFinance(row, {
      Loan_Amount: amt, Outstand_Amount: out, Repaid_Amount: Math.max(0, amt - out),
      Interest_Type: type, Loan_Status: status,
      ...(type === 'Per_Month' ? { Interest_Per_Month_Per_Lakh: num(rate) } : { Interest_Per_day_Per_Lakh: num(rate) }),
    })
    onSaved()
  }

  return (
    <Modal title={`Edit borrowing — ${fmtDate(row.Loan_Bought_Date)}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid} onClick={save}>Save changes</button>
    </>}>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Loan amount (₹)"><input className="input" inputMode="numeric" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
        <Field label="Outstanding (₹)"><input className="input" inputMode="numeric" value={outstanding} onChange={e => setOutstanding(e.target.value)} /></Field>
      </div>
      {out > amt && <p className="text-xs text-rose-300">Outstanding can't exceed the loan amount.</p>}
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="Interest type">
          <select className="input" value={type} onChange={e => setType(e.target.value)}>
            <option value="Per_Day">Per day</option><option value="Per_Month">Per month</option>
          </select>
        </Field>
        <Field label={type === 'Per_Month' ? 'Rate (₹/lakh/month)' : 'Rate (₹/lakh/day)'} hint="Used for future interest"><input className="input" inputMode="numeric" value={rate} onChange={e => setRate(e.target.value)} /></Field>
      </div>
      <Field label="Status">
        <select className="input" value={status} onChange={e => setStatus(e.target.value)}>
          <option>Active</option><option>Closed</option>
        </select>
      </Field>
    </Modal>
  )
}
