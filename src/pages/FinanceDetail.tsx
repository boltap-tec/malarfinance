import { useMemo } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Building2, Phone, User, HandCoins, PiggyBank, Landmark, Percent, Wallet, Boxes } from 'lucide-react'
import { repo, balanceForFinance } from '../data/repository'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, phone as fmtPhone, num } from '../lib/format'

// Clicking a finance name opens this 360° summary: outstanding loans, deposits
// owed, other-finance (borrowed) owed, interest positions and cash balance.
export default function FinanceDetail() {
  const { name = '' } = useParams()
  const id = decodeURIComponent(name)

  const d = useMemo(() => {
    const finance = repo.finances().find(f => f.Finance_Name === id)
    const loans = repo.loans(id)
    const deposits = repo.deposits(id)
    const other = repo.otherFinanceLoans(id)
    const interest = repo.interest(id)
    const chits = repo.chits(id)
    return {
      finance, loans, deposits, other, chits,
      outLoan: loans.reduce((s, l) => s + num(l.Outstand_Amount), 0),
      givenLoan: loans.reduce((s, l) => s + num(l.Loan_Amount), 0),
      recvLoan: loans.reduce((s, l) => s + num(l.Repaid_Amount), 0),
      outDeposit: deposits.reduce((s, x) => s + num(x.Outstand_Amount), 0),
      outOther: other.reduce((s, x) => s + num(x.Outstand_Amount), 0),
      intBilled: interest.reduce((s, i) => s + num(i.Interest_Amount), 0),
      intRecv: interest.reduce((s, i) => s + num(i.Amount_Received), 0),
      intPending: interest.reduce((s, i) => s + num(i.Interest_Pending), 0),
      balance: balanceForFinance(id),
    }
  }, [id])

  if (!d.finance) return <EmptyState title="Finance not found" />
  const f = d.finance

  return (
    <div>
      <Link to="/finances" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Finances</Link>
      <PageHeader
        title={f.Finance_Name}
        subtitle="Company summary — outstanding positions & cash balance."
        action={<Badge tone="blue">{repo.partners(id).length} partner{repo.partners(id).length === 1 ? '' : 's'}</Badge>}
      />

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        {f.MD_Name && <span className="flex items-center gap-1.5"><User size={14} /> {f.MD_Name}</span>}
        <span className="flex items-center gap-1.5"><Phone size={14} /> {fmtPhone(f.Phone_Number)}</span>
        {f.Date_Opened && <span className="flex items-center gap-1.5"><Building2 size={14} /> Opened {fmtDate(f.Date_Opened)}</span>}
        <span>Start capital {inr(num(f.Initial_Capital_Partner))}</span>
      </div>

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Outstanding loans" value={inr(d.outLoan)} tone="amber" icon={<HandCoins size={18} />} sub={`${d.loans.length} loan${d.loans.length === 1 ? '' : 's'}`} />
        <StatCard label="Outstanding deposits" value={inr(d.outDeposit)} tone="red" icon={<PiggyBank size={18} />} sub="owed to depositors" />
        <StatCard label="Other-finance owed" value={inr(d.outOther)} tone="red" icon={<Landmark size={18} />} sub="you borrowed" />
        <StatCard label="Cash balance" value={inr(d.balance)} tone={d.balance >= 0 ? 'green' : 'red'} icon={<Wallet size={18} />} />
      </div>

      <div className="mt-3 grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Loan given (total)" value={inr(d.givenLoan)} tone="blue" />
        <StatCard label="Loan received (total)" value={inr(d.recvLoan)} tone="green" />
        <StatCard label="Interest received" value={inr(d.intRecv)} tone="green" icon={<Percent size={18} />} sub={`of ${inr(d.intBilled)} billed`} />
        <StatCard label="Interest pending" value={inr(d.intPending)} tone="amber" />
      </div>

      {/* Loans */}
      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><HandCoins size={16} /> Loans</h3>
      {d.loans.length === 0 ? <EmptyState title="No loans" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Loan</Th><Th>Customer</Th><Th right>Amount</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {d.loans.slice(0, 100).map(l => (
                  <tr key={l.Loan_No} className="hover:bg-slate-800/40">
                    <Td><Link to={`/loans/${encodeURIComponent(l.Loan_No)}`} className="text-brand-300 hover:underline">{l.Loan_No}</Link></Td>
                    <Td className="text-slate-300">{l.Customer_Name}</Td>
                    <Td right className="text-hd">{inr(num(l.Loan_Amount))}</Td>
                    <Td right className="text-amber-300">{inr(num(l.Outstand_Amount))}</Td>
                    <Td><Badge tone={statusTone(l.Loan_Status)}>{l.Loan_Status ?? '—'}</Badge></Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {/* Deposits */}
      {d.deposits.length > 0 && (
        <>
          <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><PiggyBank size={16} /> Deposits</h3>
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Deposit</Th><Th>Depositor</Th><Th right>Amount</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {d.deposits.slice(0, 100).map(x => (
                    <tr key={x.Deposit_No} className="hover:bg-slate-800/40">
                      <Td><Link to={`/deposits/${encodeURIComponent(x.Deposit_No)}`} className="text-brand-300 hover:underline">{x.Deposit_No}</Link></Td>
                      <Td className="text-slate-300">{x.Depositer_Name}</Td>
                      <Td right className="text-hd">{inr(num(x.Deposit_Amount))}</Td>
                      <Td right className="text-rose-300">{inr(num(x.Outstand_Amount))}</Td>
                      <Td><Badge tone={statusTone(x.Deposit_Status)}>{x.Deposit_Status ?? '—'}</Badge></Td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </>
      )}

      {/* Other finance (borrowed) */}
      {d.other.length > 0 && (
        <>
          <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><Landmark size={16} /> Other finance loans (borrowed)</h3>
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Loan</Th><Th>Lender</Th><Th right>Amount</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {d.other.slice(0, 100).map(x => (
                    <tr key={x.Loan_No} className="hover:bg-slate-800/40">
                      <Td><Link to={`/other-finance/${encodeURIComponent(x.Loan_No)}`} className="text-brand-300 hover:underline">{x.Loan_No}</Link></Td>
                      <Td className="text-slate-300">{x.Loan_bought_Finance_Name}</Td>
                      <Td right className="text-hd">{inr(num(x.Loan_Amount))}</Td>
                      <Td right className="text-rose-300">{inr(num(x.Outstand_Amount))}</Td>
                      <Td><Badge tone={statusTone(x.Loan_Status)}>{x.Loan_Status ?? '—'}</Badge></Td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </>
      )}

      {/* Chit funds */}
      {d.chits.length > 0 && (
        <>
          <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><Boxes size={16} /> Chit funds</h3>
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Chit</Th><Th right>Pot</Th><Th right>Month</Th><Th>Status</Th></tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {d.chits.map(c => (
                    <tr key={c.Chit_ID} className="hover:bg-slate-800/40">
                      <Td><Link to={`/chit/${encodeURIComponent(c.Chit_ID)}`} className="text-brand-300 hover:underline">Chit {c.Chit_Name}</Link></Td>
                      <Td right className="text-hd">{inr(num(c.Total_Amount))}</Td>
                      <Td right className="text-slate-300">{num(c.No_Month_Completed)}/{num(c.Total_Month)}</Td>
                      <Td><Badge tone={statusTone(c.Chit_Status)}>{c.Chit_Status ?? '—'}</Badge></Td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </>
      )}
    </div>
  )
}
