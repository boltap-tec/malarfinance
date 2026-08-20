import { useMemo, useState } from 'react'
import { Link, useParams, useSearchParams } from 'react-router-dom'
import { ArrowLeft, Building2, HandCoins, Percent } from 'lucide-react'
import { repo, repayOtherFinance } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import LiabilityRepayModal from '../components/LiabilityRepayModal'
import { inr, phone, fmtDate, num } from '../lib/format'

export default function OtherFinanceDetail() {
  const { code = '' } = useParams()
  const id = decodeURIComponent(code)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [sp] = useSearchParams()
  const doParam = sp.get('do')
  const [tick, setTick] = useState(0)
  const [modal, setModal] = useState<'repay' | 'interest' | null>(
    editable && (doParam === 'repay' || doParam === 'interest') ? doParam : null,
  )

  const { rows, ledger, outstanding, borrowed, first } = useMemo(() => {
    const rows = repo.otherFinanceByCode(id)
    const ledger = repo.ledgerByRef(id)
    return {
      rows, ledger,
      outstanding: rows.reduce((s, o) => s + num(o.Outstand_Amount), 0),
      borrowed: rows.reduce((s, o) => s + num(o.Loan_Amount), 0),
      first: rows[0],
    }
  }, [id, tick])

  if (!first) return <EmptyState title="Other-finance loan not found" />
  const type = first.Interest_Type || 'Per_Day'
  const perDay = num(first.Interest_Per_day_Per_Lakh)
  const perMonth = typeof first.Interest_Per_Month_Per_Lakh === 'number' ? first.Interest_Per_Month_Per_Lakh : 0
  const since = rows.map(o => o.Loan_Bought_Date).filter(Boolean).sort()[0]

  return (
    <div>
      <Link to="/other-finance" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Other-finance</Link>
      <PageHeader
        title={first.Loan_bought_Finance_Name}
        subtitle={`${id} · ${first.Finance_Name}`}
        action={
          <div className="flex items-center gap-2">
            <Badge tone={statusTone(first.Loan_Status)}>{first.Loan_Status ?? '—'}</Badge>
            {editable && outstanding > 0 && <>
              <button className="btn-ghost !py-1.5" onClick={() => setModal('repay')}><HandCoins size={15} /> Repay</button>
              <button className="btn-ghost !py-1.5" onClick={() => setModal('interest')}><Percent size={15} /> Pay interest</button>
            </>}
          </div>
        }
      />

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span>{phone(first.Loan_bought_Finance_Phone_No)}</span>
        {first.Loan_bought_Finance_Address && <span>{first.Loan_bought_Finance_Address}</span>}
      </div>

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Total borrowed" value={inr(borrowed)} tone="blue" icon={<Building2 size={18} />} />
        <StatCard label="Outstanding payable" value={inr(outstanding)} tone="red" />
        <StatCard label="Rate" value={type === 'Per_Month' ? `₹${perMonth}/L·mo` : `₹${perDay}/L·day`} tone="slate" />
        <StatCard label="Loans" value={rows.length} tone="slate" />
      </div>

      <h3 className="mb-2 mt-6 font-semibold text-white">Borrowings under {id}</h3>
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
                  <Td right className="text-white">{inr(num(o.Loan_Amount))}</Td>
                  <Td right className="text-emerald-400">{inr(num(o.Repaid_Amount))}</Td>
                  <Td right className="text-rose-300">{inr(num(o.Outstand_Amount))}</Td>
                  <Td><Badge tone={statusTone(o.Loan_Status)}>{o.Loan_Status ?? '—'}</Badge></Td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </Card>

      <h3 className="mb-2 mt-6 font-semibold text-white">Ledger</h3>
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
          title={`Other-finance — ${first.Loan_bought_Finance_Name}`}
          name={first.Loan_bought_Finance_Name}
          code={id}
          outstanding={outstanding}
          interestType={type}
          perDay={perDay}
          perMonth={perMonth}
          sinceDate={since}
          interestOnly={modal === 'interest'}
          onRepay={(principal, interest, date) => repayOtherFinance({ code: id, principal, interest, date })}
          onClose={() => setModal(null)}
          onSaved={() => { setModal(null); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}
