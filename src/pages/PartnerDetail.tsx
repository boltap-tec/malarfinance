import { useMemo } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Phone, Mail, HandCoins, Percent, Share2, Building2 } from 'lucide-react'
import { repo } from '../data/repository'
import { accrueOnRepaidPrincipal, type DebtLine } from '../lib/interestEngine'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState } from '../components/ui'
import ReminderButton from '../components/ReminderButton'
import { inr, fmtDate, phone as fmtPhone, num, monthKey, monthName, isActive } from '../lib/format'

// Clicking a partner name opens this 360° view: the loans they referred, the
// interest still pending (with the amount owed up to the previous month called
// out), and a colourful PDF you can share with the partner.
export default function PartnerDetail() {
  const { id = '' } = useParams()
  const pid = decodeURIComponent(id)

  const d = useMemo(() => {
    const partner = repo.partners().find(p => p.Partner_ID === pid)
    const fin = partner?.Finance_Name
    const loans = repo.loans(fin).filter(l => l.Referred_Partner === pid)
    const interest = repo.interest(fin).filter(i => i.Referred_Partner === pid)
    // "till previous month" = every month strictly before the current one.
    const now = new Date()
    const curKey = now.getFullYear() * 100 + (now.getMonth() + 1)
    const pendingPrev = interest
      .filter(i => i.Month && monthKey(i.Month) < curKey)
      .reduce((s, i) => s + num(i.Interest_Pending), 0)
    // Pending interest grouped by month (newest first).
    const byMonth: Record<string, { billed: number; pending: number }> = {}
    for (const i of interest) {
      const m = i.Month ?? '—'
      const t = byMonth[m] ?? (byMonth[m] = { billed: 0, pending: 0 })
      t.billed += num(i.Interest_Amount); t.pending += num(i.Interest_Pending)
    }
    const months = Object.entries(byMonth).sort((a, b) => monthKey(b[0]) - monthKey(a[0]))

    // Interest-pending LEDGER, one row PER CUSTOMER (unique by STL number): the
    // billed and pending amounts are summed across all their loans/months, and
    // the covered months live in a single Description column (no Loan No / Month).
    const ledgerMap = new Map<string, { name: string; stl: string; descs: Set<string>; billed: number; received: number; pending: number }>()
    for (const i of interest) {
      if (num(i.Interest_Pending) <= 0) continue
      const key = i.Customer_STL_NO || i.Customer_Name || '—'
      const c = ledgerMap.get(key) ?? { name: i.Customer_Name ?? key, stl: i.Customer_STL_NO ?? '', descs: new Set<string>(), billed: 0, received: 0, pending: 0 }
      const desc = (i.Description || monthName(i.Month) || '').trim()
      if (desc && desc !== '—') c.descs.add(desc)
      c.billed += num(i.Interest_Amount); c.received += num(i.Amount_Received); c.pending += num(i.Interest_Pending)
      ledgerMap.set(key, c)
    }
    const pendingLedger = [...ledgerMap.values()]
      .map(c => ({ name: c.name, stl: c.stl, description: [...c.descs].join(', '), billed: c.billed, received: c.received, pending: c.pending }))
      .sort((a, b) => b.pending - a.pending)

    // Unbilled (accrued-but-not-yet-posted) interest on the ACTIVE referred loans,
    // computed from each loan's posted-till date up to today — the same rule the
    // repay screens use. Charged on the full current outstanding.
    const today = new Date().toISOString().slice(0, 10)
    const lines: DebtLine[] = loans
      .filter(l => isActive(l.Loan_Status) && num(l.Outstand_Amount) > 0)
      .map(l => ({
        key: l.Loan_No,
        outstanding: num(l.Outstand_Amount),
        type: l.Interest_Type,
        perDay: num(l.Interest_Per_day_Per_Lakh),
        perMonth: num(l.Interest_Per_Month_Per_Lakh),
        lastTo: repo.loanPostedUpto(l.Loan_No),
        givenDate: l.Loan_Given_Date,
      }))
    const unbilled = accrueOnRepaidPrincipal(lines, lines.reduce((s, l) => s + l.outstanding, 0), today).total

    return {
      partner, loans, interest, months, pendingPrev, pendingLedger, unbilled,
      given: loans.reduce((s, l) => s + num(l.Loan_Amount), 0),
      outstanding: loans.reduce((s, l) => s + num(l.Outstand_Amount), 0),
      pendingTotal: interest.reduce((s, i) => s + num(i.Interest_Pending), 0),
      received: interest.reduce((s, i) => s + num(i.Amount_Received), 0),
    }
  }, [pid])

  if (!d.partner) return <EmptyState title="Partner not found" />
  const p = d.partner

  return (
    <div>
      <Link to="/partners" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Partners</Link>
      <PageHeader
        title={p.Partner_Name}
        subtitle={`${p.Partner_ID} · ${p.Finance_Name}`}
        action={<div className="flex items-center gap-2">
          <ReminderButton
            label="WhatsApp"
            phone={p.Phone_Number}
            header={`${p.Partner_Name} (${p.Finance_Name})`}
            message={partnerWaMessage(p.Partner_Name, p.Finance_Name, d.outstanding, d.unbilled)}
          />
          <button className="btn-primary !py-1.5" onClick={() => sharePartnerPdf({ ...d, partner: p })}><Share2 size={15} /> Share PDF</button>
        </div>}
      />

      <div className="mb-4 flex flex-wrap gap-4 text-sm text-slate-400">
        <span className="flex items-center gap-1.5"><Phone size={14} /> {fmtPhone(p.Phone_Number)}</span>
        {p.Email_Address && <span className="flex items-center gap-1.5"><Mail size={14} /> {p.Email_Address}</span>}
        <span className="flex items-center gap-1.5"><Building2 size={14} /> {p.Finance_Name}</span>
      </div>

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Referred loans" value={d.loans.length} tone="blue" icon={<HandCoins size={18} />} sub={`${inr(d.given)} given`} />
        <StatCard label="Outstanding loan" value={inr(d.outstanding)} tone="amber" />
        <StatCard label="Interest received" value={inr(d.received)} tone="green" icon={<Percent size={18} />} />
        <StatCard label="Interest pending" value={inr(d.pendingTotal)} tone="red" sub={`Unbilled so far ${inr(d.unbilled)}`} />
      </div>

      <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><HandCoins size={16} /> Referred loans</h3>
      {d.loans.length === 0 ? <EmptyState title="No referred loans" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Loan</Th><Th>Customer</Th><Th>Given</Th><Th right>Amount</Th><Th right>Outstanding</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {d.loans.map(l => (
                  <tr key={l.Loan_No} className="hover:bg-slate-800/40">
                    <Td><Link to={`/loans/${encodeURIComponent(l.Loan_No)}`} className="text-brand-300 hover:underline">{l.Loan_No}</Link></Td>
                    <Td className="text-slate-300">{l.Customer_Name}</Td>
                    <Td className="text-slate-400">{fmtDate(l.Loan_Given_Date)}</Td>
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

      {d.months.length > 0 && (
        <>
          <h3 className="mb-2 mt-6 flex items-center gap-2 font-semibold text-hd"><Percent size={16} /> Interest by month</h3>
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Month</Th><Th right>Interest billed</Th><Th right>Pending</Th></tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {d.months.map(([m, v]) => (
                    <tr key={m} className="hover:bg-slate-800/40">
                      <Td className="text-slate-300">{monthName(m)}</Td>
                      <Td right className="text-hd">{inr(v.billed)}</Td>
                      <Td right className={v.pending > 0 ? 'text-amber-400' : 'text-slate-500'}>{v.pending ? inr(v.pending) : '—'}</Td>
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

// The WhatsApp update sent to a partner: their total outstanding loan and the
// interest that has accrued but not yet been billed (unbilled) so far.
function partnerWaMessage(name: string, finance: string, outstanding: number, unbilled: number): string {
  const rs = (n: number) => 'Rs ' + Math.round(n).toLocaleString('en-IN')
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
  return [
    `${name} (${finance})`,
    `Total Outstanding Loan: ${rs(outstanding)}`,
    `Unbilled Interest (to ${today}): ${rs(unbilled)}`,
  ].join('\n')
}

// ── Colourful, shareable PDF of the partner's position ──────────────────────
interface PartnerPdf {
  partner: import('../data/types').Partner
  loans: import('../data/types').Loan[]
  pendingLedger: { name: string; stl: string; description: string; billed: number; received: number; pending: number }[]
  given: number; outstanding: number; pendingTotal: number; received: number; pendingPrev: number
}
function sharePartnerPdf(d: PartnerPdf): void {
  const esc = (s: unknown) => String(s ?? '').replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string))
  const rup = (n: number) => `₹${Math.round(n).toLocaleString('en-IN')}`
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
  const p = d.partner

  // Referred loans — excluding fully-closed ones.
  const openLoans = d.loans.filter(l => (l.Loan_Status ?? '').toLowerCase() !== 'closed')
  const loanRows = openLoans.map(l => `<tr>
    <td>${esc(l.Loan_No)}</td><td>${esc(l.Customer_Name)}</td>
    <td>${esc(fmtDate(l.Loan_Given_Date))}</td>
    <td class="r">${rup(num(l.Loan_Amount))}</td>
    <td class="r amber">${rup(num(l.Outstand_Amount))}</td>
    <td>${esc(l.Loan_Status ?? '')}</td></tr>`).join('')

  // Interest-pending ledger — one row per customer (unique by STL), billed and
  // pending summed, the covered months carried in the Description column.
  const ledgerTotal = d.pendingLedger.reduce((s, r) => s + r.pending, 0)
  const ledgerRows = d.pendingLedger.map(r => `<tr>
    <td>${esc(r.name)}</td>
    <td>${esc(r.description)}</td>
    <td class="r">${rup(r.billed)}</td>
    <td class="r">${rup(r.received)}</td>
    <td class="r amber">${rup(r.pending)}</td></tr>`).join('')

  const html = `<!doctype html><html><head><meta charset="utf-8"><title>Partner statement — ${esc(p.Partner_Name)}</title>
  <style>
    *{box-sizing:border-box;margin:0;padding:0}
    body{font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#0f172a;background:#f1f5f9;padding:28px;font-size:13px}
    .sheet{max-width:820px;margin:0 auto;background:#fff;border-radius:16px;overflow:hidden;box-shadow:0 10px 40px rgba(2,6,23,.12)}
    .hero{background:linear-gradient(135deg,#4f46e5 0%,#7c3aed 55%,#db2777 100%);color:#fff;padding:26px 30px}
    .hero h1{font-size:24px;letter-spacing:.3px} .hero .sub{opacity:.9;margin-top:4px;font-size:13px}
    .hero .badge{display:inline-block;margin-top:12px;background:rgba(255,255,255,.18);padding:4px 12px;border-radius:999px;font-size:12px}
    .body{padding:24px 30px}
    .cards{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:8px}
    .card{border-radius:12px;padding:14px;color:#fff}
    .card .k{font-size:11px;text-transform:uppercase;letter-spacing:.05em;opacity:.85}
    .card .v{font-size:18px;font-weight:800;margin-top:4px}
    .card .s{font-size:11px;opacity:.85;margin-top:2px}
    .c1{background:linear-gradient(135deg,#2563eb,#1d4ed8)} .c2{background:linear-gradient(135deg,#f59e0b,#d97706)}
    .c3{background:linear-gradient(135deg,#10b981,#059669)} .c4{background:linear-gradient(135deg,#ef4444,#dc2626)}
    .callout{margin:16px 0;padding:12px 16px;border-radius:12px;background:#fef3c7;border:1px solid #fde68a;color:#92400e;font-size:13px}
    .callout b{font-size:15px}
    h3{font-size:12px;text-transform:uppercase;letter-spacing:.06em;color:#6366f1;margin:22px 0 8px}
    table{width:100%;border-collapse:collapse;border-radius:10px;overflow:hidden}
    thead th{background:#eef2ff;color:#4338ca;font-size:10px;text-transform:uppercase;letter-spacing:.05em;text-align:left;padding:9px 10px}
    tbody td{border-bottom:1px solid #eef2f7;padding:9px 10px}
    tbody tr:nth-child(even){background:#f8fafc}
    .r{text-align:right;font-variant-numeric:tabular-nums} .amber{color:#b45309;font-weight:700}
    .foot{padding:16px 30px;color:#94a3b8;font-size:11px;border-top:1px solid #eef2f7;display:flex;justify-content:space-between}
    @media print{body{background:#fff;padding:0}.sheet{box-shadow:none;border-radius:0}}
  </style></head><body>
    <div class="sheet">
      <div class="hero">
        <h1>${esc(p.Partner_Name)}</h1>
        <div class="sub">${esc(p.Finance_Name)} · Partner ${esc(p.Partner_ID)}${p.Phone_Number ? ' · ' + esc(p.Phone_Number) : ''}</div>
        <span class="badge">Partner statement · ${today}</span>
      </div>
      <div class="body">
        <div class="cards">
          <div class="card c1"><div class="k">Referred loans</div><div class="v">${d.loans.length}</div><div class="s">${rup(d.given)} given</div></div>
          <div class="card c2"><div class="k">Outstanding</div><div class="v">${rup(d.outstanding)}</div><div class="s">loan balance</div></div>
          <div class="card c3"><div class="k">Interest received</div><div class="v">${rup(d.received)}</div></div>
          <div class="card c4"><div class="k">Interest pending</div><div class="v">${rup(d.pendingTotal)}</div></div>
        </div>
        <div class="callout">Interest pending up to last month: <b>${rup(d.pendingPrev)}</b></div>

        <h3>Referred loans</h3>
        <table><thead><tr><th>Loan</th><th>Customer</th><th>Given</th><th class="r">Amount</th><th class="r">Outstanding</th><th>Status</th></tr></thead>
        <tbody>${loanRows || '<tr><td colspan="6">No open referred loans.</td></tr>'}</tbody></table>

        <h3>Interest pending ledger · ${rup(ledgerTotal)}</h3>
        <table><thead><tr><th>Customer</th><th>Description</th><th class="r">Billed</th><th class="r">Received</th><th class="r">Pending</th></tr></thead>
        <tbody>${ledgerRows || '<tr><td colspan="5">No pending interest.</td></tr>'}</tbody></table>
      </div>
      <div class="foot"><span>Generated ${today}</span><span>Arul Finance</span></div>
    </div>
    <script>window.onload=function(){window.print()}</script>
  </body></html>`

  const w = window.open('', '_blank')
  if (!w) { alert('Allow pop-ups to open the shareable PDF.'); return }
  w.document.open(); w.document.write(html); w.document.close()
}
