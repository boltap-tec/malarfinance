import * as XLSX from 'xlsx'

// Shared shape for the Finance Summary — active positions only, plus the
// consolidated net. Built by the FinanceSummary page and consumed by the PDF
// and Excel exporters here.
export interface SummaryRowCustomer { stl: string; name: string; phone?: string | number; finance: string; outstanding: number }
export interface SummaryRowParty { name: string; phone?: string | number; finance: string; outstanding: number }
export interface SummaryRowJewel { loanNo: string; from?: string; by?: string; grams: number; finance: string; amount: number }

export interface SummaryData {
  scope: string          // finance name, or "All finances"
  customers: SummaryRowCustomer[]
  depositors: SummaryRowParty[]
  others: SummaryRowParty[]
  jewels: SummaryRowJewel[]
  totals: { loanOut: number; depOut: number; othOut: number; jewOut: number; net: number }
}

const esc = (s: unknown) => String(s ?? '').replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string))
const rup = (n: number) => `₹${Math.round(n).toLocaleString('en-IN')}`
const ph = (p?: string | number) => (p == null || p === '') ? '—' : String(p).replace(/\.0$/, '')

// ── PDF (via print / share) ──────────────────────────────────────────────────
// Self-contained, mildly-coloured HTML — same visual language as the account
// statements, and print-safe (print-color-adjust:exact).
export function buildSummaryHtml(d: SummaryData): string {
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
  const custRows = d.customers.map(c => `<tr>
    <td class="muted">${esc(c.stl)}</td><td>${esc(c.name)}</td><td class="muted">${esc(ph(c.phone))}</td>
    <td class="muted">${esc(c.finance)}</td><td class="r pos">${rup(c.outstanding)}</td></tr>`).join('')
  const partyRows = (rows: SummaryRowParty[]) => rows.map(r => `<tr>
    <td>${esc(r.name)}</td><td class="muted">${esc(ph(r.phone))}</td>
    <td class="muted">${esc(r.finance)}</td><td class="r neg">${rup(r.outstanding)}</td></tr>`).join('')
  const jewelRows = d.jewels.map(j => `<tr>
    <td class="muted">${esc(j.loanNo)}</td><td>${esc(j.from ?? '—')}</td><td class="muted">${esc(j.by ?? '—')}</td>
    <td class="r muted">${j.grams ? j.grams + ' g' : '—'}</td><td class="muted">${esc(j.finance)}</td>
    <td class="r neg">${rup(j.amount)}</td></tr>`).join('')

  const section = (title: string, head: string, body: string, cols: number, empty: string) => `
    <h3>${esc(title)}</h3>
    <table><thead><tr>${head}</tr></thead>
    <tbody>${body || `<tr><td colspan="${cols}">${esc(empty)}</td></tr>`}</tbody></table>`

  return `<!doctype html><html><head><meta charset="utf-8"><title>Finance Summary — ${esc(d.scope)}</title>
  <style>
    *{box-sizing:border-box} html{-webkit-print-color-adjust:exact;print-color-adjust:exact}
    body{font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#0f172a;margin:0;font-size:13px;background:#fff}
    .wrap{margin:28px 32px}
    .hero{background:linear-gradient(120deg,#eef2ff,#e0f2fe);color:#0f172a;border:1px solid #dbeafe;border-radius:14px;padding:18px 22px;margin:0 0 16px}
    .hero h1{font-size:21px;margin:0;color:#3730a3} .hero .fin{font-size:13px;color:#475569;margin-top:2px}
    .cards{display:flex;flex-wrap:wrap;gap:10px;margin:10px 0 6px} .cards div{flex:1;min-width:130px;border:1px solid;border-radius:10px;padding:9px 12px}
    .cards .k{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .cards .v{font-size:16px;font-weight:800}
    .net{margin:6px 0 2px;display:inline-block;border-radius:10px;padding:10px 16px;font-weight:800;font-size:15px;border:1px solid #c7d2fe;background:#eef2ff;color:#3730a3}
    h3{font-size:12px;margin:20px 0 6px;text-transform:uppercase;letter-spacing:.05em;color:#4338ca;font-weight:800}
    table{width:100%;border-collapse:collapse;margin-top:4px;border:1px solid #e2e8f0;border-radius:10px;overflow:hidden}
    thead tr{background:#eef2ff} th{color:#3730a3;font-size:10px;text-transform:uppercase;letter-spacing:.04em;padding:8px;text-align:left;border-bottom:1px solid #dbeafe}
    td{border-top:1px solid #eef2f7;padding:7px 8px;text-align:left} tbody tr:nth-child(even){background:#f8fafc}
    .r{text-align:right;font-variant-numeric:tabular-nums} .muted{color:#64748b}
    .pos{color:#047857;font-weight:600} .neg{color:#b91c1c;font-weight:600}
    .foot{margin-top:22px;color:#94a3b8;font-size:11px} @media print{.wrap{margin:12mm}}
  </style></head><body><div class="wrap">
    <div class="hero"><h1>Finance Summary</h1><div class="fin">${esc(d.scope)} · active positions</div></div>
    <div class="cards">
      <div style="background:#f0fdf4;border-color:#bbf7d0"><div class="k">Customer loans (receivable)</div><div class="v" style="color:#15803d">${rup(d.totals.loanOut)}</div></div>
      <div style="background:#fef2f2;border-color:#fecaca"><div class="k">Deposits payable</div><div class="v" style="color:#dc2626">${rup(d.totals.depOut)}</div></div>
      <div style="background:#fef2f2;border-color:#fecaca"><div class="k">Other finance payable</div><div class="v" style="color:#dc2626">${rup(d.totals.othOut)}</div></div>
      <div style="background:#fffbeb;border-color:#fde68a"><div class="k">Jewel loans payable</div><div class="v" style="color:#b45309">${rup(d.totals.jewOut)}</div></div>
    </div>
    <div class="net">Net finance amount: ${rup(d.totals.net)}</div>
    <div class="foot" style="margin-top:6px">Net = customer loans − deposits − other finance − jewel loans.</div>
    ${section('Active customer loans', '<th>STL</th><th>Customer</th><th>Phone</th><th>Finance</th><th class="r">Outstanding</th>', custRows, 5, 'No active customer loans.')}
    ${section('Active depositors', '<th>Depositor</th><th>Phone</th><th>Finance</th><th class="r">Payable</th>', partyRows(d.depositors), 4, 'No active deposits.')}
    ${section('Active other-finance loans (borrowed)', '<th>Lender</th><th>Phone</th><th>Finance</th><th class="r">Payable</th>', partyRows(d.others), 4, 'No active other-finance loans.')}
    ${section('Active jewel loans', '<th>Loan</th><th>Taken from</th><th>Taken by</th><th class="r">Grams</th><th>Finance</th><th class="r">Payable</th>', jewelRows, 6, 'No active jewel loans.')}
    <div class="foot">Generated ${today} · Arul Finance</div>
  </div>
    <script>window.onload=function(){window.print()}</script>
  </body></html>`
}

// Open the summary ready to print / save as PDF.
export function printSummary(d: SummaryData): void {
  const w = window.open('', '_blank')
  if (!w) { alert('Allow pop-ups to open the summary.'); return }
  w.document.open(); w.document.write(buildSummaryHtml(d)); w.document.close()
}

export const summaryFilename = (d: SummaryData, ext: string) =>
  `Finance-summary-${d.scope.replace(/[^\w]+/g, '-')}-${new Date().toISOString().slice(0, 10)}.${ext}`

// ── Excel (.xlsx, multi-sheet) ───────────────────────────────────────────────
export function exportSummaryExcel(d: SummaryData): void {
  const wb = XLSX.utils.book_new()

  const summary = [
    ['Finance Summary', d.scope],
    ['Generated', new Date().toLocaleString('en-IN')],
    [],
    ['Position', 'Amount (₹)'],
    ['Customer loans (receivable)', d.totals.loanOut],
    ['Deposits payable', d.totals.depOut],
    ['Other finance payable', d.totals.othOut],
    ['Jewel loans payable', d.totals.jewOut],
    ['Net finance amount', d.totals.net],
    [],
    ['Net = customer loans − deposits − other finance − jewel loans.'],
  ]
  XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(summary), 'Summary')

  const cust = [['STL', 'Customer', 'Phone', 'Finance', 'Outstanding'],
    ...d.customers.map(c => [c.stl, c.name, ph(c.phone), c.finance, c.outstanding])]
  XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(cust), 'Customer Loans')

  const dep = [['Depositor', 'Phone', 'Finance', 'Payable'],
    ...d.depositors.map(r => [r.name, ph(r.phone), r.finance, r.outstanding])]
  XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(dep), 'Depositors')

  const oth = [['Lender', 'Phone', 'Finance', 'Payable'],
    ...d.others.map(r => [r.name, ph(r.phone), r.finance, r.outstanding])]
  XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(oth), 'Other Finance')

  const jew = [['Loan', 'Taken from', 'Taken by', 'Grams', 'Finance', 'Payable'],
    ...d.jewels.map(j => [j.loanNo, j.from ?? '', j.by ?? '', j.grams || '', j.finance, j.amount])]
  XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(jew), 'Jewel Loans')

  XLSX.writeFile(wb, summaryFilename(d, 'xlsx'))
}
