import { useState } from 'react'
import { FileDown } from 'lucide-react'
import { Card, Field } from './ui'
import { printLedgerStatement } from '../lib/statement'
import type { StatementParty, StatementCard } from '../lib/statement'
import type { LedgerRow } from '../data/types'

// The "Statement" tab body: pick a date range, then open a shareable PDF
// statement (opening balance → dated rows → closing balance). Same generator
// as before, now inline next to the Interest / Ledger tabs.
export default function StatementPanel({
  party, rows, cards = [],
}: {
  party: StatementParty
  rows: LedgerRow[]
  cards?: StatementCard[]
}) {
  const today = new Date().toISOString().slice(0, 10)
  const yearAgo = (() => { const d = new Date(); d.setFullYear(d.getFullYear() - 1); return d.toISOString().slice(0, 10) })()
  const [from, setFrom] = useState(yearAgo)
  const [to, setTo] = useState(today)
  const valid = !!from && !!to && from <= to

  function preset(kind: 'ytd' | '12m' | 'all') {
    if (kind === '12m') { setFrom(yearAgo); setTo(today); return }
    if (kind === 'ytd') { setFrom(`${new Date().getFullYear()}-01-01`); setTo(today); return }
    const days = rows.map(r => String(r.Date_Transaction ?? '').slice(0, 10)).filter(Boolean).sort()
    setFrom(days[0] ?? yearAgo); setTo(today)
  }

  function generate() {
    if (!valid) return
    printLedgerStatement(party, rows, from, to, cards)
  }

  return (
    <Card className="max-w-xl">
      <h3 className="mb-1 font-semibold text-hd">{party.kind}</h3>
      <p className="mb-4 text-sm text-slate-400">Pick a period, then open a printable statement you can save as PDF and share.</p>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <Field label="From date"><input type="date" className="input" value={from} max={to} onChange={e => setFrom(e.target.value)} /></Field>
        <Field label="To date"><input type="date" className="input" value={to} min={from} max={today} onChange={e => setTo(e.target.value)} /></Field>
      </div>
      {!valid && <p className="mb-2 text-xs text-rose-300">“From” must be on or before “To”.</p>}
      <div className="mb-4 flex flex-wrap gap-2">
        <button className="btn-ghost !py-1 !px-2.5 text-xs" onClick={() => preset('12m')}>Last 12 months</button>
        <button className="btn-ghost !py-1 !px-2.5 text-xs" onClick={() => preset('ytd')}>This year</button>
        <button className="btn-ghost !py-1 !px-2.5 text-xs" onClick={() => preset('all')}>All time</button>
      </div>
      <button className="btn-primary" disabled={!valid} onClick={generate}><FileDown size={15} /> Generate statement</button>
    </Card>
  )
}
