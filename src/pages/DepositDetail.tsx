import { useMemo, useState } from 'react'
import { Link, useParams, useSearchParams, useNavigate } from 'react-router-dom'
import { ArrowLeft, PiggyBank, HandCoins, Percent, Plus } from 'lucide-react'
import { repo, repayDeposit } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import LiabilityRepayModal from '../components/LiabilityRepayModal'
import { inr, phone, fmtDate, num } from '../lib/format'

export default function DepositDetail() {
  const { code = '' } = useParams()
  const id = decodeURIComponent(code)
  const role = useApp(s => s.user?.role)
  const setFinance = useApp(s => s.setFinance)
  const navigate = useNavigate()
  const editable = canEdit(role)
  const [sp] = useSearchParams()
  const doParam = sp.get('do')
  const [tick, setTick] = useState(0)
  const [modal, setModal] = useState<'repay' | null>(editable && doParam === 'repay' ? 'repay' : null)

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
  const since = rows.map(d => d.Deposit_Bought_Date).filter(Boolean).sort()[0]

  return (
    <div>
      <Link to="/deposits" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Deposits</Link>
      <PageHeader
        title={first.Depositer_Name}
        subtitle={`${id} · ${first.Finance_Name}`}
        action={
          <div className="flex items-center gap-2">
            <Badge tone={statusTone(first.Deposit_Status)}>{first.Deposit_Status ?? '—'}</Badge>
            {editable && (
              <button className="btn-primary !py-1.5" onClick={() => { setFinance(first.Finance_Name); navigate(`/deposits?new=1&code=${encodeURIComponent(id)}`) }}>
                <Plus size={15} /> Add deposit
              </button>
            )}
            {editable && (outstanding > 0 || repo.depositInterestPending(id) > 0) && <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setModal('repay')}><HandCoins size={15} /> Repay</button>}
          </div>
        }
      />

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span className="flex items-center gap-1.5">{phone(first.Depositer_Phone_No)}</span>
        {first.Depositer_Email && <span>{first.Depositer_Email}</span>}
        {first.Depositer_Address && <span>{first.Depositer_Address}</span>}
      </div>

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Total deposited" value={inr(deposited)} tone="blue" icon={<PiggyBank size={18} />} />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
        <StatCard label="Interest payable" value={inr(interestPending)} tone="amber" />
        <StatCard label="Rate / lakh / month" value={`₹${rate}`} tone="slate" />
      </div>

      <h3 className="mb-2 mt-6 font-semibold text-hd">Deposits under {id}</h3>
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

      <h3 className="mb-2 mt-6 font-semibold text-hd">Interest history</h3>
      {interest.length === 0 ? <EmptyState title="No interest postings yet" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Period</Th><Th right>Interest</Th><Th right>Paid</Th><Th right>Pending</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {interest.slice().sort((a: any, b: any) => String(b.Month ?? '').localeCompare(String(a.Month ?? ''))).map((i: any, k: number) => (
                  <tr key={k} className="hover:bg-slate-800/40">
                    <Td className="text-slate-300">{i.Month}</Td>
                    <Td className="text-xs text-slate-500">{fmtDate(i.From_Date)} – {fmtDate(i.To_Date)}</Td>
                    <Td right className="text-hd">{inr(num(i.Interest_Amount))}</Td>
                    <Td right className="text-emerald-400">{inr(num(i.Amount_Received))}</Td>
                    <Td right className="text-amber-400">{inr(num(i.Interest_Pending))}</Td>
                    <Td><Badge tone={statusTone(i.Status)}>{i.Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      <h3 className="mb-2 mt-6 font-semibold text-hd">Ledger</h3>
      {ledger.length === 0 ? <EmptyState title="No ledger entries yet" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Date</Th><Th>Nature</Th><Th>Description</Th><Th right>Receipt</Th><Th right>Payment</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {ledger.slice().reverse().map((t, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-400">{fmtDate(t.Date_Transaction)}</Td>
                    <Td className="text-slate-300">{t.Nature_Transaction}</Td>
                    <Td className="text-slate-400">{t.Description}</Td>
                    <Td right className="text-emerald-400">{num(t.Receipt_Amount) ? inr(num(t.Receipt_Amount)) : '—'}</Td>
                    <Td right className="text-rose-300">{num(t.Payment_Amount) ? inr(num(t.Payment_Amount)) : '—'}</Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {modal && (
        <LiabilityRepayModal
          title={`Deposit — ${first.Depositer_Name}`}
          name={first.Depositer_Name}
          code={id}
          outstanding={outstanding}
          pendingInterest={repo.depositInterestPending(id)}
          onRepay={(principal, interest, date) => repayDeposit({ code: id, principal, interest, date })}
          onClose={() => setModal(null)}
          onSaved={() => { setModal(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}
