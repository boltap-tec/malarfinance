import { useMemo, useState } from 'react'
import { Link, useParams, useSearchParams, useNavigate } from 'react-router-dom'
import { ArrowLeft, PiggyBank, HandCoins, Percent, Plus, IndianRupee, BookText } from 'lucide-react'
import { repo, repayDeposit, payDepositInterest } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Tabs } from '../components/ui'
import LiabilityRepayModal from '../components/LiabilityRepayModal'
import InterestPayModal from '../components/InterestPayModal'
import LedgerTable from '../components/LedgerTable'
import ReminderButton from '../components/ReminderButton'
import { inr, phone, fmtDate, num, monthName } from '../lib/format'

type TabKey = 'deposits' | 'interest' | 'ledger'

export default function DepositDetail() {
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
  const [tab, setTab] = useState<TabKey>(doParam === 'interest' ? 'interest' : 'deposits')
  const [modal, setModal] = useState<'repay' | 'interest' | null>(
    editable && (doParam === 'repay' || doParam === 'interest') ? (doParam as 'repay' | 'interest') : null,
  )
  const [pay, setPay] = useState<any | null>(null)

  const { rows, ledger, interest, interestPending, outstanding, deposited, first } = useMemo(() => {
    const rows = repo.depositsByCode(id)
    const ledger = repo.ledgerByRef(id)
    const interest = repo.depositInterestByCode(id)
    return {
      rows, ledger, interest,
      interestPending: interest.reduce((s: number, i: any) => s + num(i.Interest_Pending), 0),
      outstanding: rows.reduce((s, d) => s + num(d.Outstand_Amount), 0),
      deposited: rows.reduce((s, d) => s + num(d.Deposit_Amount), 0),
      first: rows[0],
    }
  }, [id, tick])

  if (!first) return <EmptyState title="Deposit not found" />
  const rate = num(first.Interest_Per_Month_Per_Lakh)

  return (
    <div>
      <Link to="/deposits" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Deposits</Link>
      <PageHeader
        title={first.Depositer_Name}
        subtitle={`${id} · ${first.Finance_Name}`}
        action={
          <div className="flex items-center gap-2">
            <Badge tone={statusTone(first.Deposit_Status)}>{first.Deposit_Status ?? '—'}</Badge>
            <ReminderButton
              header={`${id}-${first.Depositer_Name}`}
              phone={first.Depositer_Phone_No}
              items={interest.map((i: any) => ({ month: i.Month, amount: num(i.Interest_Amount), pending: num(i.Interest_Pending) }))}
            />
            {editable && (
              <button className="btn-primary !py-1.5" onClick={() => { setFinance(first.Finance_Name); navigate(`/deposits?new=1&code=${encodeURIComponent(id)}`) }}>
                <Plus size={15} /> Add deposit
              </button>
            )}
            {editable && outstanding > 0 && <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setModal('repay')}><HandCoins size={15} /> Repay</button>}
            {editable && repo.depositInterestPending(id) > 0 && <button className="btn-ghost !py-1.5 text-amber-300 ring-1 ring-inset ring-amber-500/30" onClick={() => { setTab('interest'); setModal('interest') }}><Percent size={15} /> Pay interest</button>}
          </div>
        }
      />

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span className="flex items-center gap-1.5">{phone(first.Depositer_Phone_No)}</span>
        {first.Depositer_Email && <span>{first.Depositer_Email}</span>}
        {first.Depositer_Address && <span>{first.Depositer_Address}</span>}
      </div>

      <div className="mb-6 grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Total deposited" value={inr(deposited)} tone="blue" icon={<PiggyBank size={18} />} />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
        <StatCard label="Interest payable" value={inr(interestPending)} tone="amber" />
        <StatCard label="Rate / lakh / month" value={`₹${rate}`} tone="slate" />
      </div>

      <Tabs<TabKey>
        active={tab}
        onChange={setTab}
        tabs={[
          { key: 'deposits', label: <span className="flex items-center gap-1.5"><PiggyBank size={14} /> Deposits</span>, badge: rows.length || '' },
          { key: 'interest', label: <span className="flex items-center gap-1.5"><Percent size={14} /> Interest</span>, badge: interestPending > 0 ? '!' : '' },
          { key: 'ledger', label: <span className="flex items-center gap-1.5"><BookText size={14} /> Ledger</span>, badge: ledger.length || '' },
        ]}
      />

      {tab === 'deposits' && (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Bought</Th><Th right>Amount</Th><Th right>Repaid</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((d, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-400">{fmtDate(d.Deposit_Bought_Date)}</Td>
                    <Td right className="text-hd">{inr(num(d.Deposit_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(d.Repaid_Amount))}</Td>
                    <Td right className="text-rose-300">{inr(num(d.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(d.Deposit_Status)}>{d.Deposit_Status ?? '—'}</Badge></Td>
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
                            ? <button title="Collect interest" className="btn-ghost !px-2.5 !py-1 text-xs text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setPay(i)}><IndianRupee size={13} /> Pay</button>
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
          emptyHint="Deposit, refund and interest movements appear here."
          onChanged={() => setTick(t => t + 1)}
        />
      )}

      {modal && (
        <LiabilityRepayModal
          title={modal === 'interest' ? `Pay deposit interest — ${first.Depositer_Name}` : `Deposit — ${first.Depositer_Name}`}
          name={first.Depositer_Name}
          code={id}
          outstanding={outstanding}
          pendingInterest={repo.depositInterestPending(id)}
          interestOnly={modal === 'interest'}
          onRepay={(principal, interest, date, payType, note) => repayDeposit({ code: id, principal, interest, date, payType, note })}
          onClose={() => setModal(null)}
          onSaved={() => { setModal(null); setTick(t => t + 1) }}
        />
      )}

      {pay && (
        <InterestPayModal
          title="Pay deposit interest"
          name={first.Depositer_Name}
          code={id}
          month={pay.Month}
          pending={num(pay.Interest_Pending)}
          onPay={(amount, date, payType, note) => payDepositInterest(pay.ID, amount, date, payType, note)}
          onClose={() => setPay(null)}
          onSaved={() => { setPay(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}
