import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { HandCoins, PiggyBank, Landmark, Gem, Scale, FileDown, Share2, Sheet, Loader2 } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState } from '../components/ui'
import { inr, phone as fmtPhone, num } from '../lib/format'
import {
  buildSummaryHtml, printSummary, exportSummaryExcel, summaryFilename,
  type SummaryData,
} from '../lib/financeSummaryExport'
import { shareStatementPdf } from '../lib/statementShare'

// Organisation → Finance Summary: consolidated ACTIVE positions across the
// business — customer loans receivable, deposits/other-finance/jewel payable —
// and the net finance amount. Exportable to PDF and Excel.
export default function FinanceSummary() {
  const finance = useApp(s => s.finance)
  const scopeName = finance === 'ALL' ? 'All finances' : finance
  const [sharing, setSharing] = useState(false)

  const data: SummaryData = useMemo(() => {
    const f = financeFilter(finance)

    // Active customer loans, one row per customer (outstanding summed).
    const byCust = new Map<string, { stl: string; name: string; phone?: string | number; finance: string; outstanding: number }>()
    for (const l of repo.loans(f)) {
      const out = num(l.Outstand_Amount)
      if (out <= 0) continue
      const key = l.Customer_STL_NO
      const cur = byCust.get(key) ?? { stl: l.Customer_STL_NO, name: l.Customer_Name, phone: l.Customer_Phone_No, finance: l.Finance_Name, outstanding: 0 }
      cur.outstanding += out
      byCust.set(key, cur)
    }
    const customers = [...byCust.values()].sort((a, b) => b.outstanding - a.outstanding)

    const depositors = repo.depositors(f).filter(x => num(x.out) > 0)
      .map(x => ({ name: x.name, phone: x.phone, finance: x.finance, outstanding: num(x.out) }))
      .sort((a, b) => b.outstanding - a.outstanding)

    const others = repo.otherFinances(f).filter(x => num(x.out) > 0)
      .map(x => ({ name: x.name, phone: x.phone, finance: x.finance, outstanding: num(x.out) }))
      .sort((a, b) => b.outstanding - a.outstanding)

    const jewels = repo.jewelLoans(f).filter(j => (j.Loan_Status ?? 'Active') !== 'Closed')
      .map(j => ({ loanNo: j.Loan_No, from: j.Loan_Taken_From, by: j.Loan_Taken_By, grams: num(j.Loan_Total_grams), finance: j.Finance_Name, amount: num(j.Loan_Amount) }))
      .sort((a, b) => b.amount - a.amount)

    const loanOut = customers.reduce((s, c) => s + c.outstanding, 0)
    const depOut = depositors.reduce((s, c) => s + c.outstanding, 0)
    const othOut = others.reduce((s, c) => s + c.outstanding, 0)
    const jewOut = jewels.reduce((s, c) => s + c.amount, 0)

    return {
      scope: scopeName, customers, depositors, others, jewels,
      totals: { loanOut, depOut, othOut, jewOut, net: loanOut - depOut - othOut - jewOut },
    }
  }, [finance, scopeName])

  const t = data.totals

  async function share() {
    if (sharing) return
    setSharing(true)
    try { await shareStatementPdf(buildSummaryHtml(data), summaryFilename(data, 'pdf'), `Finance Summary — ${data.scope}`) }
    catch { alert('Could not build the PDF. Use “PDF” to print instead.') }
    finally { setSharing(false) }
  }

  return (
    <div>
      <PageHeader
        title="Finance Summary"
        subtitle={`Consolidated active positions — ${scopeName}.`}
        action={
          <div className="flex flex-wrap items-center gap-2">
            <button className="btn-primary !py-1.5" disabled={sharing} onClick={share}>
              {sharing ? <Loader2 size={15} className="animate-spin" /> : <Share2 size={15} />} Share PDF
            </button>
            <button className="btn-ghost !py-1.5" onClick={() => printSummary(data)}><FileDown size={15} /> PDF</button>
            <button className="btn-ghost !py-1.5" onClick={() => exportSummaryExcel(data)}><Sheet size={15} /> Excel</button>
          </div>
        }
      />

      <div className="mb-4 grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Customer loans (receivable)" value={inr(t.loanOut)} tone="green" icon={<HandCoins size={18} />} sub={`${data.customers.length} active`} />
        <StatCard label="Deposits payable" value={inr(t.depOut)} tone="red" icon={<PiggyBank size={18} />} sub={`${data.depositors.length} active`} />
        <StatCard label="Other finance payable" value={inr(t.othOut)} tone="red" icon={<Landmark size={18} />} sub={`${data.others.length} active`} />
        <StatCard label="Jewel loans payable" value={inr(t.jewOut)} tone="amber" icon={<Gem size={18} />} sub={`${data.jewels.length} active`} />
      </div>

      <Card className="mb-6 flex flex-wrap items-center justify-between gap-3 border-brand-500/30 bg-brand-500/5">
        <div className="flex items-center gap-2 text-hd">
          <Scale size={18} className="text-brand-300" />
          <span className="font-semibold">Net finance amount</span>
        </div>
        <span className={`text-2xl font-bold ${t.net >= 0 ? 'text-emerald-300' : 'text-rose-300'}`}>{inr(t.net)}</span>
        <p className="w-full text-xs text-slate-500">Net = customer loans − deposits − other finance − jewel loans.</p>
      </Card>

      {/* Active customer loans */}
      <h3 className="mb-2 flex items-center gap-2 font-semibold text-hd"><HandCoins size={16} /> Active customer loans</h3>
      {data.customers.length === 0 ? <EmptyState title="No active customer loans" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>STL</Th><Th>Customer</Th><Th>Phone</Th><Th>Finance</Th><Th right>Outstanding</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {data.customers.map(c => (
                  <tr key={c.stl} className="hover:bg-slate-800/40">
                    <Td><Link to={`/customers/${encodeURIComponent(c.stl)}`} className="font-medium text-brand-300 hover:underline">{c.stl}</Link></Td>
                    <Td className="text-slate-200">{c.name}</Td>
                    <Td className="text-slate-400">{fmtPhone(c.phone)}</Td>
                    <Td className="text-slate-400">{c.finance}</Td>
                    <Td right className="text-emerald-300">{inr(c.outstanding)}</Td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="border-t-2 border-slate-700 bg-slate-900/50 font-semibold">
                  <td className="px-3 py-2.5 text-sm text-slate-300" colSpan={4}>Total · {data.customers.length} customer{data.customers.length === 1 ? '' : 's'}</td>
                  <td className="px-3 py-2.5 text-right text-sm tabular-nums text-emerald-300">{inr(t.loanOut)}</td>
                </tr>
              </tfoot>
            </table>
          </div>
        </Card>
      )}

      {/* Active depositors */}
      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><PiggyBank size={16} /> Active depositors</h3>
      {data.depositors.length === 0 ? <EmptyState title="No active deposits" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Depositor</Th><Th>Phone</Th><Th>Finance</Th><Th right>Payable</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {data.depositors.map((r, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-200">{r.name}</Td>
                    <Td className="text-slate-400">{fmtPhone(r.phone)}</Td>
                    <Td className="text-slate-400">{r.finance}</Td>
                    <Td right className="text-rose-300">{inr(r.outstanding)}</Td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="border-t-2 border-slate-700 bg-slate-900/50 font-semibold">
                  <td className="px-3 py-2.5 text-sm text-slate-300" colSpan={3}>Total · {data.depositors.length} depositor{data.depositors.length === 1 ? '' : 's'}</td>
                  <td className="px-3 py-2.5 text-right text-sm tabular-nums text-rose-300">{inr(t.depOut)}</td>
                </tr>
              </tfoot>
            </table>
          </div>
        </Card>
      )}

      {/* Active other-finance */}
      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><Landmark size={16} /> Active other-finance loans (borrowed)</h3>
      {data.others.length === 0 ? <EmptyState title="No active other-finance loans" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Lender</Th><Th>Phone</Th><Th>Finance</Th><Th right>Payable</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {data.others.map((r, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td className="text-slate-200">{r.name}</Td>
                    <Td className="text-slate-400">{fmtPhone(r.phone)}</Td>
                    <Td className="text-slate-400">{r.finance}</Td>
                    <Td right className="text-rose-300">{inr(r.outstanding)}</Td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="border-t-2 border-slate-700 bg-slate-900/50 font-semibold">
                  <td className="px-3 py-2.5 text-sm text-slate-300" colSpan={3}>Total · {data.others.length} lender{data.others.length === 1 ? '' : 's'}</td>
                  <td className="px-3 py-2.5 text-right text-sm tabular-nums text-rose-300">{inr(t.othOut)}</td>
                </tr>
              </tfoot>
            </table>
          </div>
        </Card>
      )}

      {/* Active jewel loans */}
      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><Gem size={16} /> Active jewel loans</h3>
      {data.jewels.length === 0 ? <EmptyState title="No active jewel loans" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Loan</Th><Th>Taken from</Th><Th>Taken by</Th><Th right>Grams</Th><Th>Finance</Th><Th right>Payable</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {data.jewels.map(j => (
                  <tr key={j.loanNo} className="hover:bg-slate-800/40">
                    <Td><Link to={`/jewel/${encodeURIComponent(j.loanNo)}`} className="font-medium text-brand-300 hover:underline">{j.loanNo}</Link></Td>
                    <Td className="text-slate-300">{j.from ?? '—'}</Td>
                    <Td className="text-slate-400">{j.by ?? '—'}</Td>
                    <Td right className="text-slate-300">{j.grams ? `${j.grams} g` : '—'}</Td>
                    <Td className="text-slate-400">{j.finance}</Td>
                    <Td right className="text-rose-300">{inr(j.amount)}</Td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="border-t-2 border-slate-700 bg-slate-900/50 font-semibold">
                  <td className="px-3 py-2.5 text-sm text-slate-300" colSpan={3}>Total · {data.jewels.length} loan{data.jewels.length === 1 ? '' : 's'}</td>
                  <td className="px-3 py-2.5 text-right text-sm tabular-nums text-slate-300">{(() => { const g = data.jewels.reduce((s, j) => s + (j.grams || 0), 0); return g ? `${num(g)} g` : '—' })()}</td>
                  <td className="px-3 py-2.5"></td>
                  <td className="px-3 py-2.5 text-right text-sm tabular-nums text-rose-300">{inr(t.jewOut)}</td>
                </tr>
              </tfoot>
            </table>
          </div>
        </Card>
      )}
    </div>
  )
}
