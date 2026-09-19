import { useMemo, useState } from 'react'
import { BookOpenText } from 'lucide-react'
import { repo } from '../data/repository'
import { useApp, financeFilter } from '../store/app'
import { PageHeader, Card, StatCard, Badge, Th, Td, EmptyState } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

interface Movement {
  date: string; nature: string; who: string; month: number
  receipt: number; payment: number; payType?: string
}

export default function ChitLedger() {
  const financeSel = useApp(s => s.finance)
  const finance = financeFilter(financeSel)

  const chits = useMemo(() => repo.chits(finance), [finance])
  const [fund, setFund] = useState<string>('')
  const activeFund = fund || chits[0]?.Chit_ID || ''

  // The chit's own cash ledger: dues received from members (receipts) and
  // payouts given to takers (payments) — separate from the firm's ledger.
  const rows = useMemo<Movement[]>(() => {
    if (!activeFund) return []
    const out: Movement[] = []
    for (const r of repo.chitLedger(activeFund)) {
      if (num(r.Received_Amount) > 0) {
        out.push({ date: r.Paid_Date ?? r.Date_Auction ?? '', nature: 'Due received', who: r.Member_Name ?? r.Member_ID, month: num(r.Month_Count), receipt: num(r.Received_Amount), payment: 0, payType: r.Payment_Type })
      }
    }
    for (const t of repo.chitTakers(activeFund)) {
      // Prefer the individual payout installments (dated, typed); fall back to a
      // single lump for any amount given before the payment history was kept.
      const pays = repo.chitTakerPayments(t.Chit_Taken_ID)
      let recorded = 0
      for (const p of pays) {
        recorded += num(p.Amount)
        out.push({ date: p.Date ?? t.Date_Auction ?? '', nature: 'Payout to taker', who: t.Member_Name ?? t.Member_ID, month: num(t.Month_Count), receipt: 0, payment: num(p.Amount), payType: p.Payment_Type })
      }
      const earlier = num(t.Amount_Given_to_Member) - recorded
      if (earlier > 0) {
        out.push({ date: t.Date_Auction ?? '', nature: 'Payout to taker', who: t.Member_Name ?? t.Member_ID, month: num(t.Month_Count), receipt: 0, payment: earlier })
      }
    }
    out.sort((a, b) => {
      const d = new Date(a.date || 0).getTime() - new Date(b.date || 0).getTime()
      return d !== 0 ? d : a.month - b.month
    })
    return out
  }, [activeFund])

  const totalIn = rows.reduce((s, r) => s + r.receipt, 0)
  const totalOut = rows.reduce((s, r) => s + r.payment, 0)
  let bal = 0

  return (
    <div>
      <PageHeader
        title="Chit ledger"
        subtitle="The chit fund's own cash book — dues in, payouts out. Separate from the firm ledger."
        action={chits.length > 0 && (
          <select className="input !w-auto !py-1.5 text-sm" value={activeFund} onChange={e => setFund(e.target.value)}>
            {chits.map(c => <option key={c.Chit_ID} value={c.Chit_ID}>Chit {c.Chit_Name}</option>)}
          </select>
        )}
      />

      {!activeFund ? <EmptyState title="No chit funds yet" hint="Create a chit fund first." /> : (
        <>
          <div className="mb-4 grid grid-cols-3 gap-3">
            <StatCard label="Dues received" value={inr(totalIn)} tone="green" icon={<BookOpenText size={18} />} />
            <StatCard label="Payouts given" value={inr(totalOut)} tone="red" />
            <StatCard label="Net in hand" value={inr(totalIn - totalOut)} tone="blue" />
          </div>

          {rows.length === 0 ? <EmptyState title="No chit cash movements yet" hint="Collect a due or pay a taker to see entries." /> : (
            <Card className="!p-0 overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead className="border-b border-slate-800 bg-slate-900/60">
                    <tr><Th>Date</Th><Th>Nature</Th><Th>Member</Th><Th right>Month</Th><Th right>Receipt</Th><Th right>Payment</Th><Th right>Balance</Th></tr>
                  </thead>
                  <tbody className="divide-y divide-slate-800">
                    {rows.map((r, i) => {
                      bal += r.receipt - r.payment
                      return (
                        <tr key={i} className="hover:bg-slate-800/40">
                          <Td className="text-slate-400">{fmtDate(r.date)}</Td>
                          <Td><Badge tone={r.receipt > 0 ? 'green' : 'red'}>{r.nature}</Badge></Td>
                          <Td className="text-slate-300">{r.who}</Td>
                          <Td right className="text-slate-400">#{r.month}</Td>
                          <Td right className="text-emerald-400">{r.receipt ? inr(r.receipt) : '—'}</Td>
                          <Td right className="text-rose-300">{r.payment ? inr(r.payment) : '—'}</Td>
                          <Td right className="text-hd">{inr(bal)}</Td>
                        </tr>
                      )
                    })}
                  </tbody>
                </table>
              </div>
            </Card>
          )}
        </>
      )}
    </div>
  )
}
