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

export type StatementTone = 'blue' | 'green' | 'amber' | 'red' | 'slate'
export interface StatementCard { label: string; value: string; tone?: StatementTone }

// Print-safe colour palette (ink / soft background / border) per tone. Used for
// the summary cards; `print-color-adjust:exact` keeps the colours when printed.
const TONES: Record<StatementTone, { ink: string; bg: string; bd: string }> = {
  blue: { ink: '#1d4ed8', bg: '#eff6ff', bd: '#bfdbfe' },
  green: { ink: '#15803d', bg: '#f0fdf4', bd: '#bbf7d0' },
  amber: { ink: '#b45309', bg: '#fffbeb', bd: '#fde68a' },
  red: { ink: '#dc2626', bg: '#fef2f2', bd: '#fecaca' },
  slate: { ink: '#334155', bg: '#f8fafc', bd: '#e2e8f0' },
}

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
      <td class="muted">${esc(fmtDate(r.Date_Transaction))}</td>
      <td><span class="pill">${esc(natureLabel(r.Nature_Transaction))}</span>${r.Description ? `<span class="sub">${esc(r.Description)}</span>` : ''}</td>
      <td class="r pos">${rc ? rup(rc) : '—'}</td>
      <td class="r neg">${pm ? rup(pm) : '—'}</td>
      <td class="r bal ${bal < 0 ? 'neg' : ''}">${rup(bal)}</td></tr>`
  }).join('')

  const closing = bal
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
  const period = `${fmtDate(fromDate)} – ${fmtDate(toDate)}`
  const cardHtml = cards.length
    ? `<div class="cards">${cards.map(c => {
        const t = TONES[c.tone ?? 'slate']
        return `<div style="background:${t.bg};border-color:${t.bd}"><div class="k">${esc(c.label)}</div><div class="v" style="color:${t.ink}">${esc(c.value)}</div></div>`
      }).join('')}</div>`
    : ''

  const html = `<!doctype html><html><head><meta charset="utf-8"><title>${esc(party.kind)} — ${esc(party.name)}</title>
  <style>
    *{box-sizing:border-box} html{-webkit-print-color-adjust:exact;print-color-adjust:exact}
    body{font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#0f172a;margin:0;font-size:13px;background:#fff}
    .wrap{margin:28px 32px}
    .hero{background:linear-gradient(120deg,#eef2ff,#e0f2fe);color:#0f172a;border:1px solid #dbeafe;border-radius:14px;padding:18px 22px;margin:0 0 16px}
    .hero h1{font-size:21px;margin:0;letter-spacing:.2px;color:#3730a3} .hero .fin{font-size:13px;color:#475569;margin-top:2px}
    .hero .who{margin-top:12px;display:flex;flex-wrap:wrap;gap:6px 16px;font-size:12px}
    .hero .who b{font-size:14px;color:#1e293b} .hero .who .chip{background:#fff;border:1px solid #c7d2fe;color:#334155;border-radius:999px;padding:2px 10px}
    .period{font-size:12px;color:#334155;margin:2px 0 10px} .period b{color:#0f172a}
    .cards{display:flex;flex-wrap:wrap;gap:10px;margin:10px 0 6px} .cards div{flex:1;min-width:120px;border:1px solid;border-radius:10px;padding:9px 12px}
    .cards .k{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .cards .v{font-size:16px;font-weight:800}
    h3{font-size:12px;margin:20px 0 6px;text-transform:uppercase;letter-spacing:.05em;color:#4338ca;font-weight:800}
    table{width:100%;border-collapse:collapse;margin-top:4px;border:1px solid #e2e8f0;border-radius:10px;overflow:hidden}
    thead tr{background:#eef2ff} th{color:#3730a3;font-size:10px;text-transform:uppercase;letter-spacing:.04em;padding:8px;text-align:left;border-bottom:1px solid #dbeafe}
    td{border-top:1px solid #eef2f7;padding:7px 8px;text-align:left;vertical-align:top}
    tbody tr:nth-child(even){background:#f8fafc} .r{text-align:right;font-variant-numeric:tabular-nums}
    .muted{color:#64748b} .pos{color:#047857;font-weight:600} .neg{color:#b91c1c;font-weight:600} .bal{font-weight:700;color:#1e293b}
    .pill{display:inline-block;background:#eef2ff;color:#4338ca;border-radius:6px;padding:1px 7px;font-size:11px;font-weight:600}
    .sub{display:block;font-size:11px;color:#94a3b8;margin-top:2px}
    tr.open td{color:#475569;font-style:italic;background:#f8fafc}
    tr.tot td{font-weight:800;background:#eef2ff;border-top:2px solid #c7d2fe;color:#1e293b}
    .close{margin-top:12px;display:inline-block;background:#eef2ff;color:#3730a3;border:1px solid #c7d2fe;border-radius:10px;padding:8px 14px;font-weight:700}
    .foot{margin-top:22px;color:#94a3b8;font-size:11px}
    @media print{.wrap{margin:12mm}}
  </style></head><body><div class="wrap">
    <div class="hero">
      <h1>${esc(party.kind)}</h1>
      <div class="fin">${esc(party.finance ?? '')}${party.code ? ` · ${esc(party.code)}` : ''}</div>
      <div class="who">
        <span class="chip"><b>${esc(party.name)}</b></span>
        ${party.phone ? `<span class="chip">${esc(String(party.phone).replace(/\.0$/, ''))}</span>` : ''}
        ${party.address ? `<span class="chip">${esc(party.address)}</span>` : ''}
      </div>
    </div>
    <p class="period">Period: <b>${period}</b></p>
    ${cardHtml}
    <h3>Transactions</h3>
    <table>
      <thead><tr><th>Date</th><th>Particulars</th><th class="r">Received</th><th class="r">Paid</th><th class="r">Balance</th></tr></thead>
      <tbody>
        <tr class="open"><td>${esc(fmtDate(fromDate))}</td><td>Opening balance</td><td class="r">—</td><td class="r">—</td><td class="r bal ${opening < 0 ? 'neg' : ''}">${rup(opening)}</td></tr>
        ${bodyRows || '<tr><td colspan="5">No transactions in this period.</td></tr>'}
        <tr class="tot"><td colspan="2">Period total</td><td class="r pos">${rup(totIn)}</td><td class="r neg">${rup(totOut)}</td><td class="r bal ${closing < 0 ? 'neg' : ''}">${rup(closing)}</td></tr>
      </tbody>
    </table>
    <div class="close">Closing balance: ${rup(closing)}</div>
    <div class="foot">Generated ${today} · Arul Finance</div>
  </div>
    <script>window.onload=function(){window.print()}</script>
  </body></html>`

  const w = window.open('', '_blank')
  if (!w) { alert('Allow pop-ups to open the statement.'); return }
  w.document.open(); w.document.write(html); w.document.close()
}
