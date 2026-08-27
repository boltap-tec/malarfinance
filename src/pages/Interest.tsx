import { useMemo, useState } from 'react'
import { Zap, Check, Percent } from 'lucide-react'
import {
  repo, appendInterestRows, appendDepositInterest, appendOtherFinanceInterest,
  getSettings, setSettings,
} from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { previewPosting, toInterestRow, computeInterest, isMonthEnd } from '../lib/interestEngine'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState } from '../components/ui'
import { inr, num } from '../lib/format'
import type { Loan } from '../data/types'

const monthStr = (d: Date) => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`

export default function Interest() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const f = financeFilter(finance)

  const now = new Date()
  const todayStr = now.toISOString().slice(0, 10)
  const lastPosted = getSettings().lastPostedDate
  // Default to the month after the last posted one, else last month.
  const defaultMonth = lastPosted
    ? monthStr(new Date(new Date(lastPosted).getFullYear(), new Date(lastPosted).getMonth() + 1, 1))
    : monthStr(new Date(now.getFullYear(), now.getMonth() - 1, 1))

  const [month, setMonth] = useState(defaultMonth)
  const [posted, setPosted] = useState<string | null>(null)

  // Posting is per whole month: From = 1st, To = month end.
  const [my, mm] = month.split('-').map(Number)
  const from = `${month}-01`
  // Days in the month via getDate() (local, timezone-safe) — toISOString() would
  // roll a local month-end back a day in +ve timezones (e.g. IST), so Aug showed 30.
  const to = `${month}-${String(new Date(my, mm, 0).getDate()).padStart(2, '0')}`

  const settings = getSettings()
  // Month end is enforced by construction; the To date must not be in the future.
  const monthEndOk = settings.postingAnyDate || new Date(to) <= new Date(todayStr)

  // Customer loan interest.
  const custPreview = useMemo(
    () => previewPosting(repo.loans(f), from, to, (loanNo, month) => repo.postedMonths(loanNo).has(month)),
    [f, from, to, posted],
  )

  // Deposit interest (interest we OWE depositors), one line per deposit.
  const depPreview = useMemo(() => {
    return repo.deposits(f)
      .filter(d => (d.Deposit_Status ?? '').toLowerCase() === 'active' && num(d.Outstand_Amount) > 0)
      .map(d => {
        const pseudo = { Loan_Amount: num(d.Outstand_Amount), Interest_Type: 'Per_Month', Interest_Per_Month_Per_Lakh: num(d.Interest_Per_Month_Per_Lakh), Loan_Given_Date: d.Deposit_Bought_Date } as Loan
        const p = computeInterest(pseudo, from, to)
        return { d, p, id: `${d.Deposit_No}-${num(d.Deposit_Amount)}-${p.month}` }
      })
      .filter(x => x.p.interest > 0)
      .filter(x => !(repo.depositInterest(f).some((i: any) => i.ID === x.id)))
  }, [f, from, to, posted])

  // Other-finance interest (interest we OWE lenders), one line per borrowing.
  const othPreview = useMemo(() => {
    return repo.otherFinanceLoans(f)
      .filter(o => (o.Loan_Status ?? '').toLowerCase() === 'active' && num(o.Outstand_Amount) > 0)
      .map(o => {
        const pseudo = { Loan_Amount: num(o.Outstand_Amount), Interest_Type: o.Interest_Type || 'Per_Day', Interest_Per_day_Per_Lakh: num(o.Interest_Per_day_Per_Lakh), Interest_Per_Month_Per_Lakh: num(o.Interest_Per_Month_Per_Lakh), Loan_Given_Date: o.Loan_Bought_Date } as Loan
        const p = computeInterest(pseudo, from, to)
        return { o, p, id: `${o.Loan_No}-${num(o.Loan_Amount)}-${p.month}` }
      })
      .filter(x => x.p.interest > 0)
      .filter(x => !(repo.otherFinanceInterest(f).some((i: any) => i.ID === x.id)))
  }, [f, from, to, posted])

  const custTotal = custPreview.reduce((s, p) => s + p.interest, 0)
  const depTotal = depPreview.reduce((s, x) => s + x.p.interest, 0)
  const othTotal = othPreview.reduce((s, x) => s + x.p.interest, 0)
  const count = custPreview.length + depPreview.length + othPreview.length

  async function postAll() {
    await appendInterestRows(custPreview.map(toInterestRow))
    await appendDepositInterest(depPreview.map(({ d, p, id }) => ({
      ID: id, Finance_Name: d.Finance_Name, Deposit_No: d.Deposit_No, Depositer_Name: d.Depositer_Name,
      From_Date: p.fromDate, To_Date: p.toDate, No_Days: p.noOfDays, Interest_Per_Month_Per_Lakh: num(d.Interest_Per_Month_Per_Lakh),
      Interest_Amount: p.interest, Deposit_Amount: num(d.Deposit_Amount), Month: p.month, Description: p.description,
      Amount_Received: 0, Status: 'Pending', Interest_Pending: p.interest, Interest_Type: 'Per_Month',
    })))
    await appendOtherFinanceInterest(othPreview.map(({ o, p, id }) => ({
      ID: id, Finance_Name: o.Finance_Name, Loan_No: o.Loan_No, Loan_bought_Finance_Name: o.Loan_bought_Finance_Name,
      From_Date: p.fromDate, To_Date: p.toDate, No_Days: p.noOfDays, Interest_Amount: p.interest, Loan_Amount: num(o.Loan_Amount),
      Month: p.month, Description: p.description, Amount_Received: 0, Status: 'Pending', Interest_Pending: p.interest,
      Interest_Type: o.Interest_Type || 'Per_Day',
    })))
    setSettings({ lastPostedDate: to })
    setPosted(`Posted ${custPreview.length} customer, ${depPreview.length} deposit and ${othPreview.length} other-finance interest lines.`)
  }

  if (role !== 'md') return <EmptyState title="Only the MD can post interest" />

  return (
    <div>
      <PageHeader title="Interest posting" subtitle="Run customer, deposit and other-finance interest for a whole month — in one click." />

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
        <StatCard label="Customer interest" value={inr(custTotal)} tone="green" sub={`${custPreview.length} loans`} icon={<Percent size={18} />} />
        <StatCard label="Deposit interest" value={inr(depTotal)} tone="amber" sub={`${depPreview.length} deposits`} />
        <StatCard label="Other-finance interest" value={inr(othTotal)} tone="red" sub={`${othPreview.length} loans`} />
        <StatCard label="Total to post" value={inr(custTotal + depTotal + othTotal)} tone="blue" />
      </div>

      <Card className="mb-4">
        <div className="flex flex-wrap items-end gap-4">
          <div>
            <label className="label">Month to post</label>
            <input type="month" max={monthStr(now)} className="input mt-1" value={month} onChange={e => { setMonth(e.target.value); setPosted(null) }} />
          </div>
          <div className="text-sm text-slate-400">
            <p className="label">Period</p>
            <p className="mt-1">{from} → {to}</p>
          </div>
          <div className="flex-1" />
          <button className="btn-primary" onClick={postAll} disabled={count === 0 || !monthEndOk}>
            <Zap size={16} /> Post all interest
          </button>
        </div>
        {!monthEndOk && (
          <div className="mt-3 rounded-xl bg-amber-500/10 px-4 py-2.5 text-sm text-amber-300 ring-1 ring-amber-500/30">
            This month hasn’t ended — interest posts only for a <b>completed month</b> (the To date can’t be after today).
          </div>
        )}
        {posted && (
          <div className="mt-3 flex items-center gap-2 rounded-xl bg-emerald-500/10 px-4 py-3 text-sm text-emerald-300 ring-1 ring-emerald-500/30">
            <Check size={16} /> {posted} See Customer / Deposit / Other-Finance Interest to view or collect them.
          </div>
        )}
      </Card>

      {count === 0 ? (
        <EmptyState title="Nothing to post in this window" hint="Adjust the dates, or interest for this period is already posted." />
      ) : (
        <div className="space-y-4">
          <Section title="Customer interest" total={custTotal} rows={custPreview.map(p => ({ a: p.loan.Loan_No, b: p.loan.Customer_Name, days: p.noOfDays, amt: p.interest }))} />
          <Section title="Deposit interest" total={depTotal} rows={depPreview.map(x => ({ a: x.d.Deposit_No, b: x.d.Depositer_Name, days: x.p.noOfDays, amt: x.p.interest }))} />
          <Section title="Other-finance interest" total={othTotal} rows={othPreview.map(x => ({ a: x.o.Loan_No, b: x.o.Loan_bought_Finance_Name, days: x.p.noOfDays, amt: x.p.interest }))} />
        </div>
      )}
    </div>
  )
}

function Section({ title, total, rows }: { title: string; total: number; rows: { a: string; b: string; days: number; amt: number }[] }) {
  if (rows.length === 0) return null
  return (
    <Card className="!p-0 overflow-hidden">
      <div className="flex items-center justify-between px-4 py-2.5">
        <h3 className="font-semibold text-hd">{title}</h3>
        <Badge tone="blue">{inr(total)} · {rows.length}</Badge>
      </div>
      <div className="overflow-x-auto">
        <table className="w-full">
          <thead className="border-y border-slate-800 bg-slate-900/60">
            <tr><Th>Code</Th><Th>Name</Th><Th right>Days</Th><Th right>Interest</Th></tr>
          </thead>
          <tbody className="divide-y divide-slate-800">
            {rows.map((r, i) => (
              <tr key={i} className="hover:bg-slate-800/40">
                <Td className="font-medium text-brand-300">{r.a}</Td>
                <Td className="text-slate-200">{r.b}</Td>
                <Td right className="text-slate-400">{r.days}</Td>
                <Td right className="font-semibold text-hd">{inr(r.amt)}</Td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </Card>
  )
}
