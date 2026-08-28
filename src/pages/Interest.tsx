import { useMemo, useState } from 'react'
import { Zap, Check, Percent } from 'lucide-react'
import {
  repo, appendInterestRows, appendDepositInterest, appendOtherFinanceInterest,
  markCustomerPostedUpto, markDepositPostedUpto, markOtherFinancePostedUpto,
  appendPostingLog, getSettings, setSettings,
} from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { previewPosting, toInterestRow, computeInterest, isMonthEnd, distributeRounding, resumeFrom } from '../lib/interestEngine'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState } from '../components/ui'
import { inr, num } from '../lib/format'
import type { Loan } from '../data/types'

const monthStr = (d: Date) => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`
// A YYYY-MM key → "August 2026" for display.
const monthLabel = (m: string) => {
  const [y, mo] = m.split('-').map(Number)
  return new Date(y, (mo || 1) - 1, 1).toLocaleString('en-US', { month: 'long', year: 'numeric' })
}
const fmtDateTime = (iso?: string) => iso ? new Date(iso).toLocaleString('en-IN', { dateStyle: 'medium', timeStyle: 'short' }) : '—'

export default function Interest() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const userName = useApp(s => s.user?.name)
  const financeList = useApp(s => s.user?.finances) ?? []
  const isSuper = useApp(s => s.user?.isSuper)

  // Interest can be run one finance at a time (finance-wise) or, for the super MD,
  // all finances at once ('ALL'). Defaults to the finance in the top switcher.
  const [scope, setScope] = useState(finance)
  // Which finances the user may post for: their own, plus 'ALL' for the super MD.
  const scopeOptions = isSuper ? ['ALL', ...financeList] : financeList
  const f = financeFilter(scope)

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
  // Already posted? Block re-running a completed month (belt-and-braces with each
  // entity's posted-till). `posted` is a dep so this refreshes after a run.
  const priorRun = repo.postingLog(scope).find(r => r.Month === month)
  const alreadyPosted = !!priorRun && posted === null

  // Customer loan interest. Rounding is applied per CUSTOMER (not per loan): each
  // loan's raw interest is summed for the customer and that total rounded to ₹10.
  const custPreview = useMemo(() => {
    // Interest is charged on the OUTSTANDING principal (not the original loan
    // amount), and each loan resumes from its own stored posted-till date.
    const loans = repo.loans(f).map(l => ({ ...l, Loan_Amount: num(l.Outstand_Amount) }))
    const raw = previewPosting(loans, from, to, l => repo.loanPostedUpto(l.Loan_No))
    const rounded = distributeRounding(raw, p => p.rawInterest, p => p.loan.Customer_STL_NO)
    return raw.map(p => ({ ...p, interest: rounded.get(p) ?? p.interest })).filter(p => p.interest > 0)
  }, [f, from, to, posted])

  // Deposit interest (interest we OWE depositors), one line per deposit; rounded
  // per depositor (grouped by DEP no.).
  const depPreview = useMemo(() => {
    const items = repo.deposits(f)
      .filter(d => (d.Deposit_Status ?? '').toLowerCase() === 'active' && num(d.Outstand_Amount) > 0)
      .map(d => {
        // Use the deposit's stored rate, or derive it from past interest when blank.
        const rate = num(d.Interest_Per_Month_Per_Lakh) || repo.derivedDepositRate(d.Deposit_No)
        const pseudo = { Loan_Amount: num(d.Outstand_Amount), Interest_Type: 'Per_Month', Interest_Per_Month_Per_Lakh: rate, Loan_Given_Date: resumeFrom(d.Deposit_Bought_Date, repo.depositPostedUpto(d.Deposit_No)) } as Loan
        const p = computeInterest(pseudo, from, to)
        return { d, p, rate, id: `${d.Deposit_No}-${num(d.Deposit_Amount)}-${p.month}` }
      })
      .filter(x => x.p.rawInterest > 0)
      .filter(x => !(repo.depositInterest(f).some((i: any) => i.ID === x.id)))
    const rounded = distributeRounding(items, x => x.p.rawInterest, x => x.d.Deposit_No)
    return items.map(x => ({ ...x, p: { ...x.p, interest: rounded.get(x) ?? x.p.interest } })).filter(x => x.p.interest > 0)
  }, [f, from, to, posted])

  // Other-finance interest (interest we OWE lenders), one line per borrowing;
  // rounded per lender (grouped by FIN no.).
  const othPreview = useMemo(() => {
    const items = repo.otherFinanceLoans(f)
      .filter(o => (o.Loan_Status ?? '').toLowerCase() === 'active' && num(o.Outstand_Amount) > 0)
      .map(o => {
        const pseudo = { Loan_Amount: num(o.Outstand_Amount), Interest_Type: o.Interest_Type || 'Per_Day', Interest_Per_day_Per_Lakh: num(o.Interest_Per_day_Per_Lakh), Interest_Per_Month_Per_Lakh: num(o.Interest_Per_Month_Per_Lakh), Loan_Given_Date: resumeFrom(o.Loan_Bought_Date, repo.otherFinancePostedUpto(o.Loan_No)) } as Loan
        const p = computeInterest(pseudo, from, to)
        return { o, p, id: `${o.Loan_No}-${num(o.Loan_Amount)}-${p.month}` }
      })
      .filter(x => x.p.rawInterest > 0)
      .filter(x => !(repo.otherFinanceInterest(f).some((i: any) => i.ID === x.id)))
    const rounded = distributeRounding(items, x => x.p.rawInterest, x => x.o.Loan_No)
    return items.map(x => ({ ...x, p: { ...x.p, interest: rounded.get(x) ?? x.p.interest } })).filter(x => x.p.interest > 0)
  }, [f, from, to, posted])

  const custTotal = custPreview.reduce((s, p) => s + p.interest, 0)
  const depTotal = depPreview.reduce((s, x) => s + x.p.interest, 0)
  const othTotal = othPreview.reduce((s, x) => s + x.p.interest, 0)
  const count = custPreview.length + depPreview.length + othPreview.length

  async function postAll() {
    await appendInterestRows(custPreview.map(toInterestRow))
    await appendDepositInterest(depPreview.map(({ d, p, rate, id }) => ({
      ID: id, Finance_Name: d.Finance_Name, Deposit_No: d.Deposit_No, Depositer_Name: d.Depositer_Name,
      From_Date: p.fromDate, To_Date: p.toDate, No_Days: p.noOfDays, Interest_Per_Month_Per_Lakh: rate,
      Interest_Amount: p.interest, Deposit_Amount: num(d.Deposit_Amount), Month: p.month, Description: p.description,
      Amount_Received: 0, Status: 'Pending', Interest_Pending: p.interest, Interest_Type: 'Per_Month',
    })))
    await appendOtherFinanceInterest(othPreview.map(({ o, p, id }) => ({
      ID: id, Finance_Name: o.Finance_Name, Loan_No: o.Loan_No, Loan_bought_Finance_Name: o.Loan_bought_Finance_Name,
      From_Date: p.fromDate, To_Date: p.toDate, No_Days: p.noOfDays, Interest_Amount: p.interest, Loan_Amount: num(o.Loan_Amount),
      Month: p.month, Description: p.description, Amount_Received: 0, Status: 'Pending', Interest_Pending: p.interest,
      Interest_Type: o.Interest_Type || 'Per_Day',
    })))
    // Advance each posted item's posted-till to this month end. A posting is the
    // ONLY thing that moves it — repayments deliberately leave it alone, so a
    // remaining balance still bills its pre-repay days at the next monthly run.
    for (const stl of [...new Set(custPreview.map(p => p.loan.Customer_STL_NO))]) await markCustomerPostedUpto(stl, to)
    for (const x of depPreview) await markDepositPostedUpto(x.d.Deposit_No, to)
    for (const x of othPreview) await markOtherFinancePostedUpto(x.o.Loan_No, to)
    setSettings({ lastPostedDate: to })
    // Record the run in the posting register so this month reads as "posted".
    await appendPostingLog({
      ID: `${scope}-${month}`, Finance_Name: scope, Month: month, From_Date: from, To_Date: to,
      Posted_On: new Date().toISOString(), Posted_By: userName || role || 'md',
      Customer_Lines: custPreview.length, Deposit_Lines: depPreview.length, Other_Lines: othPreview.length,
      Customer_Amount: custTotal, Deposit_Amount: depTotal, Other_Amount: othTotal,
    })
    setPosted(`Posted ${custPreview.length} customer, ${depPreview.length} deposit and ${othPreview.length} other-finance interest lines.`)
  }

  if (role !== 'md') return <EmptyState title="Only the MD can post interest" />

  return (
    <div>
      <PageHeader title="Interest posting" subtitle="Run customer, deposit and other-finance interest for a whole month — per finance, or all at once." />

      <div className="mb-4 grid grid-cols-2 gap-3 lg:grid-cols-5">
        <StatCard label="Customer interest" value={inr(custTotal)} tone="green" sub={`${custPreview.length} loans · earned`} icon={<Percent size={18} />} />
        <StatCard label="Deposit interest" value={inr(depTotal)} tone="amber" sub={`${depPreview.length} deposits · owed`} />
        <StatCard label="Other-finance interest" value={inr(othTotal)} tone="red" sub={`${othPreview.length} loans · owed`} />
        <StatCard label="Total to post" value={inr(custTotal + depTotal + othTotal)} tone="slate" />
        <StatCard label="Profit this period" value={inr(custTotal - depTotal - othTotal)} tone="blue" sub="customer − deposit − other" />
      </div>

      <Card className="mb-4">
        <div className="flex flex-wrap items-end gap-4">
          {scopeOptions.length > 1 && (
            <div>
              <label className="label">Finance to post</label>
              <select className="input mt-1" value={scope} onChange={e => { setScope(e.target.value); setPosted(null) }}>
                {scopeOptions.map(s => <option key={s} value={s}>{s === 'ALL' ? 'All finances' : s}</option>)}
              </select>
            </div>
          )}
          <div>
            <label className="label">Month to post</label>
            <input type="month" max={monthStr(now)} className="input mt-1" value={month} onChange={e => { setMonth(e.target.value); setPosted(null) }} />
          </div>
          <div className="text-sm text-slate-400">
            <p className="label">Period</p>
            <p className="mt-1">{from} → {to}</p>
          </div>
          <div className="flex-1" />
          <button className="btn-primary" onClick={postAll} disabled={count === 0 || !monthEndOk || alreadyPosted}>
            <Zap size={16} /> Post all interest
          </button>
        </div>
        {alreadyPosted && priorRun && (
          <div className="mt-3 rounded-xl bg-slate-500/10 px-4 py-2.5 text-sm text-slate-300 ring-1 ring-slate-500/30">
            <b>{monthLabel(month)} is already posted.</b> Run on {fmtDateTime(priorRun.Posted_On)} · {priorRun.Customer_Lines ?? 0} customer, {priorRun.Deposit_Lines ?? 0} deposit, {priorRun.Other_Lines ?? 0} other-finance lines. Re-posting is blocked to avoid charging interest twice — see the posting register below.
          </div>
        )}
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

      <PostingRegister rows={repo.postingLog(scope)} />
    </div>
  )
}

// The interest-posting register — every month that's been posted, newest first.
// This is the record that removes any doubt about whether a month was run.
function PostingRegister({ rows }: { rows: ReturnType<typeof repo.postingLog> }) {
  return (
    <Card className="!p-0 mt-4 overflow-hidden">
      <div className="flex items-center justify-between px-4 py-2.5">
        <h3 className="font-semibold text-hd">Posting register</h3>
        <Badge tone="slate">{rows.length} posted</Badge>
      </div>
      {rows.length === 0 ? (
        <p className="px-4 py-6 text-sm text-slate-400">No interest has been posted yet. Each run you commit above is recorded here.</p>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-y border-slate-800 bg-slate-900/60">
              <tr>
                <Th>Month</Th><Th>Period</Th><Th right>Customer</Th><Th right>Deposit</Th>
                <Th right>Other</Th><Th right>Total</Th><Th>Posted on</Th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {rows.map(r => {
                const total = num(r.Customer_Amount) - num(r.Deposit_Amount) - num(r.Other_Amount)
                return (
                  <tr key={r.ID} className="hover:bg-slate-800/40">
                    <Td className="font-medium text-hd">{monthLabel(r.Month)}</Td>
                    <Td className="text-slate-400">{r.From_Date} → {r.To_Date}</Td>
                    <Td right className="text-emerald-300">{inr(num(r.Customer_Amount))} <span className="text-slate-500">· {r.Customer_Lines ?? 0}</span></Td>
                    <Td right className="text-amber-300">{inr(num(r.Deposit_Amount))} <span className="text-slate-500">· {r.Deposit_Lines ?? 0}</span></Td>
                    <Td right className="text-rose-300">{inr(num(r.Other_Amount))} <span className="text-slate-500">· {r.Other_Lines ?? 0}</span></Td>
                    <Td right className="font-semibold text-hd">{inr(total)}</Td>
                    <Td className="text-slate-400">{fmtDateTime(r.Posted_On)}{r.Posted_By ? ` · ${r.Posted_By}` : ''}</Td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
      )}
    </Card>
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
