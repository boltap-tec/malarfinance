import { useMemo, useState } from 'react'
import { Link, useParams, useSearchParams, useNavigate } from 'react-router-dom'
import { ArrowLeft, Building2, HandCoins, Percent, Plus, IndianRupee, BookText } from 'lucide-react'
import { repo, repayOtherFinance, payOtherFinanceInterest } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Tabs } from '../components/ui'
import LiabilityRepayModal from '../components/LiabilityRepayModal'
import InterestPayModal from '../components/InterestPayModal'
import LedgerTable from '../components/LedgerTable'
import ReminderButton from '../components/ReminderButton'
import { inr, phone, fmtDate, num, monthName } from '../lib/format'

type TabKey = 'borrowings' | 'interest' | 'ledger'

export default function OtherFinanceDetail() {
  const { code = '' } = useParams()
  const id = decodeURIComponent(code)
  const role = useApp(s => s.user?.role)
  const setFinance = useApp(s => s.setFinance)
  const navigate = useNavigate()
  const editable = canEdit(role)
  const isMd = role === 'md'
  const [sp] = useSearchParams()
  const doParam = sp.get('do')
  const [tick, setTick] = useState(0)
  const [tab, setTab] = useState<TabKey>(doParam === 'interest' ? 'interest' : 'borrowings')
  const [modal, setModal] = useState<'repay' | 'interest' | null>(
    editable && (doParam === 'repay' || doParam === 'interest') ? (doParam as 'repay' | 'interest') : null,
  )
  const [pay, setPay] = useState<any | null>(null)

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
              <button className="btn-primary !py-1.5" onClick={() => { setFinance(first.Finance_Name); navigate(`/other-finance?new=1&code=${encodeURIComponent(id)}`) }}>
                <Plus size={15} /> Add loan
              </button>
            )}
            {editable && outstanding > 0 && <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setModal('repay')}><HandCoins size={15} /> Repay</button>}
            {editable && repo.otherFinanceInterestPending(id) > 0 && <button className="btn-ghost !py-1.5 text-amber-300 ring-1 ring-inset ring-amber-500/30" onClick={() => { setTab('interest'); setModal('interest') }}><Percent size={15} /> Pay interest</button>}
          </div>
        }
      />

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
                <tr><Th>Bought</Th><Th right>Amount</Th><Th right>Repaid</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((o, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-400">{fmtDate(o.Loan_Bought_Date)}</Td>
                    <Td right className="text-hd">{inr(num(o.Loan_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(o.Repaid_Amount))}</Td>
                    <Td right className="text-rose-300">{inr(num(o.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(o.Loan_Status)}>{o.Loan_Status ?? '—'}</Badge></Td>
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
                  {interest.slice().sort((a: any, b: any) => String(b.Month ?? '').localeCompare(String(a.Month ?? ''))).map((i: any, k: number) => (
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
          onRepay={(principal, interest, date, payType, note) => repayOtherFinance({ code: id, principal, interest, date, payType, note })}
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
    </div>
  )
}
