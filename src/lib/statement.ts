import { fmtDate, num } from './format'
import type { LedgerRow } from '../data/types'

// A shareable account statement (PDF via the browser's print dialog) for one
// entity — a customer, depositor or other-finance lender. Mirrors the chit
// member statement: build a self-contained HTML page and print it, so it works
// on web and inside the Capacitor WebView without any PDF dependency.

export interface StatementParty {
  kind: string            // e.g. "Loan statement", "Deposit statement"
  name: string            // party name
  code?: string           // STL / deposit / loan code
  finance?: string        // finance house name
  phone?: string | number
  address?: string
}

export interface StatementCard { label: string; value: string }

const esc = (s: unknown) =>
  String(s ?? '').replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string))
const rup = (n: number) => `₹${Math.round(n).toLocaleString('en-IN')}`

// Normalise any stored date to a comparable YYYY-MM-DD (ISO dates already are).
const dayKey = (d?: string | null): string => {
  const s = String(d ?? '')
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10)
  const dt = new Date(s)
  return isNaN(dt.getTime()) ? '' : dt.toISOString().slice(0, 10)
}

// Human label for a Nature_Transaction (e.g. "Customer_Loan_Prin_Repayment" ->
// "Customer Loan Prin Repayment").
const natureLabel = (n?: string) => String(n ?? '—').replace(/_/g, ' ')

export function printLedgerStatement(
  party: StatementParty,
  rows: LedgerRow[],
  fromDate: string,
  toDate: string,
  cards: StatementCard[] = [],
): void {
  const lo = fromDate, hi = toDate
  const withDay = rows.map(r => ({ r, d: dayKey(r.Date_Transaction) }))

  // Opening balance = net of every dated movement before the period start.
  const opening = withDay
    .filter(x => x.d && x.d < lo)
    .reduce((s, x) => s + num(x.r.Receipt_Amount) - num(x.r.Payment_Amount), 0)

  // In-period rows, oldest first, with a running net balance carried from opening.
  const inRange = withDay
    .filter(x => x.d && x.d >= lo && x.d <= hi)
    .sort((a, b) => (a.d < b.d ? -1 : a.d > b.d ? 1 : 0))

  let bal = opening
  let totIn = 0, totOut = 0
  const bodyRows = inRange.map(({ r }) => {
    const rc = num(r.Receipt_Amount), pm = num(r.Payment_Amount)
    bal += rc - pm; totIn += rc; totOut += pm
    return `<tr>
      <td>${esc(fmtDate(r.Date_Transaction))}</td>
      <td>${esc(natureLabel(r.Nature_Transaction))}${r.Description ? `<span class="sub">${esc(r.Description)}</span>` : ''}</td>
      <td class="r">${rc ? rup(rc) : '—'}</td>
      <td class="r">${pm ? rup(pm) : '—'}</td>
      <td class="r">${rup(bal)}</td></tr>`
  }).join('')

  const closing = bal
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
  const period = `${fmtDate(fromDate)} – ${fmtDate(toDate)}`
  const cardHtml = cards.length
    ? `<div class="cards">${cards.map(c => `<div><div class="k">${esc(c.label)}</div><div class="v">${esc(c.value)}</div></div>`).join('')}</div>`
    : ''

  const html = `<!doctype html><html><head><meta charset="utf-8"><title>${esc(party.kind)} — ${esc(party.name)}</title>
  <style>
    *{box-sizing:border-box} body{font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#0f172a;margin:32px;font-size:13px}
    h1{font-size:20px;margin:0} h2{font-size:14px;color:#475569;margin:2px 0 14px} h3{font-size:13px;margin:20px 0 6px;text-transform:uppercase;letter-spacing:.04em;color:#475569}
    .meta{color:#475569;font-size:12px;margin-bottom:12px} .meta span{margin-right:14px}
    .period{font-size:12px;color:#334155;margin:0 0 8px} .period b{color:#0f172a}
    .cards{display:flex;flex-wrap:wrap;gap:10px;margin:10px 0 4px} .cards div{flex:1;min-width:120px;border:1px solid #e2e8f0;border-radius:8px;padding:8px 10px}
    .cards .k{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .cards .v{font-size:16px;font-weight:700}
    table{width:100%;border-collapse:collapse;margin-top:4px} th,td{border-bottom:1px solid #e2e8f0;padding:6px 8px;text-align:left;vertical-align:top}
    th{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .r{text-align:right;font-variant-numeric:tabular-nums}
    .sub{display:block;font-size:11px;color:#94a3b8} tr.tot td{font-weight:700;border-top:2px solid #cbd5e1;border-bottom:none}
    tr.open td{color:#475569;font-style:italic}
    .foot{margin-top:24px;color:#94a3b8;font-size:11px} @media print{body{margin:12mm}}
  </style></head><body>
    <h1>${esc(party.kind)}</h1>
    <h2>${esc(party.finance ?? '')}${party.code ? ` · ${esc(party.code)}` : ''}</h2>
    <div class="meta">
      <span><b>${esc(party.name)}</b></span>
      ${party.phone ? `<span>${esc(String(party.phone).replace(/\.0$/, ''))}</span>` : ''}
      ${party.address ? `<span>${esc(party.address)}</span>` : ''}
    </div>
    <p class="period">Period: <b>${period}</b></p>
    ${cardHtml}
    <h3>Transactions</h3>
    <table>
      <thead><tr><th>Date</th><th>Particulars</th><th class="r">Received</th><th class="r">Paid</th><th class="r">Balance</th></tr></thead>
      <tbody>
        <tr class="open"><td>${esc(fmtDate(fromDate))}</td><td>Opening balance</td><td class="r">—</td><td class="r">—</td><td class="r">${rup(opening)}</td></tr>
        ${bodyRows || '<tr><td colspan="5">No transactions in this period.</td></tr>'}
        <tr class="tot"><td colspan="2">Period total</td><td class="r">${rup(totIn)}</td><td class="r">${rup(totOut)}</td><td class="r">${rup(closing)}</td></tr>
      </tbody>
    </table>
    <p class="period" style="margin-top:10px">Closing balance: <b>${rup(closing)}</b></p>
    <div class="foot">Generated ${today} · Arul Finance</div>
    <script>window.onload=function(){window.print()}</script>
  </body></html>`

  const w = window.open('', '_blank')
  if (!w) { alert('Allow pop-ups to open the statement.'); return }
  w.document.open(); w.document.write(html); w.document.close()
}
