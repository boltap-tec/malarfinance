import { useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Boxes, Building2, CalendarClock, Coins, Plus, HandCoins } from 'lucide-react'
import { repo, recordInvestedContribution, recordInvestedTake } from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'

export default function InvestedChitDetail() {
  const { chitId = '' } = useParams()
  const id = decodeURIComponent(chitId)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [tick, setTick] = useState(0)
  const [recording, setRecording] = useState(false)
  const [taking, setTaking] = useState(false)

  const { chit, trans, invested, received } = useMemo(() => {
    const chit = repo.investedChit(id)
    const trans = repo.investedChitTrans(id)
    const s = repo.investedChitSummary(id)
    return { chit, trans, invested: s.invested, received: s.received }
  }, [id, tick])

  if (!chit) return <EmptyState title="Invested chit not found" />

  const paymentCount = trans.filter(t => t.Kind !== 'Receipt').length
  const monthsDone = num(chit.No_Months_Completed) || paymentCount
  const remainingMonths = Math.max(0, num(chit.No_Months) - monthsDone)
  const completed = remainingMonths === 0 || (chit.Chit_Status ?? '').toLowerCase() === 'completed'

  return (
    <div>
      <Link to="/chits" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> My Invested Chits</Link>
      <PageHeader
        title={chit.Chit_Name ?? chit.Chit_ID}
        subtitle={<span className="flex items-center gap-1.5"><Building2 size={14} className="text-slate-500" />{chit.Chit_Invested_Company}{chit.Chit_Invested_By ? ` · invested by ${chit.Chit_Invested_By}` : ''}</span>}
        action={
          <div className="flex flex-wrap items-center gap-2">
            {chit.Chit_Taken === 'Yes' && <Badge tone="green">Taken</Badge>}
            <Badge tone={statusTone(chit.Chit_Status)}>{chit.Chit_Status ?? '—'}</Badge>
            {editable && <button className="btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30" onClick={() => setTaking(true)}><HandCoins size={15} /> Record take</button>}
            {editable && !completed && <button className="btn-primary !py-1.5" onClick={() => setRecording(true)}><Plus size={15} /> Record month</button>}
          </div>
        }
      />

      {chit.Chit_Invested_Company_Address && <p className="mb-4 text-sm text-slate-400">{chit.Chit_Invested_Company_Address}</p>}

      <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-5">
        <StatCard label="Pot value" value={inr(num(chit.Total_Amount_Chit))} tone="blue" icon={<Boxes size={18} />} />
        <StatCard label="Paid to company" value={inr(invested)} tone="amber" icon={<Coins size={18} />} sub={`over ${paymentCount} month${paymentCount === 1 ? '' : 's'}`} />
        <StatCard label="Received on take" value={received ? inr(received) : '—'} tone="green" icon={<HandCoins size={18} />} sub={chit.Chit_Taken === 'Yes' ? fmtDate(chit.Chit_Taken_Date) : 'not taken yet'} />
        <StatCard label="Months completed" value={`${monthsDone} / ${num(chit.No_Months)}`} tone="slate" icon={<CalendarClock size={18} />} sub={remainingMonths ? `${remainingMonths} to go` : 'complete'} />
        <StatCard label="Started" value={fmtDate(chit.Chit_Started_Date)} tone="slate" />
      </div>

      <div className="mb-2 mt-8 flex items-center gap-2">
        <Coins size={16} className="text-brand-400" />
        <h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Monthly contributions</h2>
      </div>
      {trans.length === 0 ? (
        <EmptyState title="No contributions yet" hint={editable ? 'Use “Record month” to add the first month.' : undefined} />
      ) : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Type</Th><Th>Month</Th><Th>Period</Th><Th>Date</Th><Th right>Amount</Th><Th>Remarks</Th><Th>Status</Th></tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {trans.map((t) => {
                  const isReceipt = t.Kind === 'Receipt'
                  return (
                  <tr key={t.ID} className="hover:bg-slate-800/40">
                    <Td><Badge tone={isReceipt ? 'green' : 'amber'}>{isReceipt ? 'Received' : 'Paid'}</Badge></Td>
                    <Td className="font-medium text-slate-200">{isReceipt ? '—' : `#${num(t.Month_Count)}`}</Td>
                    <Td className="text-slate-400">{t.Month_Year ?? '—'}</Td>
                    <Td className="text-slate-400">{fmtDate(t.Paid_Date ?? t.Date)}</Td>
                    <Td right className={isReceipt ? 'text-emerald-400' : 'text-hd'}>{isReceipt ? '+ ' : ''}{inr(num(t.Chit_This_Month_Amount))}</Td>
                    <Td className="text-slate-400">{t.Remarks ?? '—'}</Td>
                    <Td><Badge tone={statusTone(t.Chit_Status)}>{t.Chit_Status ?? '—'}</Badge></Td>
                  </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {recording && (
        <RecordContributionModal
          chitId={id}
          suggested={num(chit.Total_Amount_Chit) && num(chit.No_Months) ? Math.round(num(chit.Total_Amount_Chit) / num(chit.No_Months)) : 0}
          nextMonth={monthsDone + 1}
          onClose={() => setRecording(false)}
          onSaved={() => { setRecording(false); setTick(t => t + 1) }}
        />
      )}

      {taking && (
        <RecordTakeModal
          chitId={id}
          suggested={num(chit.Total_Amount_Chit)}
          onClose={() => setTaking(false)}
          onSaved={() => { setTaking(false); setTick(t => t + 1) }}
        />
      )}
    </div>
  )
}

// Record the amount you received when you took (won) the invested chit.
function RecordTakeModal({ chitId, suggested, onClose, onSaved }: {
  chitId: string; suggested: number; onClose: () => void; onSaved: () => void
}) {
  const [amount, setAmount] = useState(suggested ? String(suggested) : '')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [remarks, setRemarks] = useState('')
  const [busy, setBusy] = useState(false)
  const valid = num(amount) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await recordInvestedTake({ chitId, amount: num(amount), date, remarks: remarks.trim() || undefined })
    onSaved()
  }

  return (
    <Modal
      title="Record chit taken"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>Record receipt</button>
      </>}
    >
      <p className="mb-1 text-sm text-slate-400">The amount you received from the company when you took (won) this chit.</p>
      <Field label="Amount received (₹)" hint={suggested ? `Pot value ${inr(suggested)}` : undefined}>
        <input type="number" className="input" autoFocus value={amount} onChange={e => setAmount(e.target.value)} />
      </Field>
      <Field label="Date received"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      <Field label="Notes / remarks"><input className="input" value={remarks} onChange={e => setRemarks(e.target.value)} placeholder="Optional — a note to remind you later" /></Field>
    </Modal>
  )
}

function RecordContributionModal({ chitId, suggested, nextMonth, onClose, onSaved }: {
  chitId: string; suggested: number; nextMonth: number; onClose: () => void; onSaved: () => void
}) {
  const [amount, setAmount] = useState(suggested ? String(suggested) : '')
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [remarks, setRemarks] = useState('')
  const [busy, setBusy] = useState(false)
  const valid = num(amount) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await recordInvestedContribution({ chitId, amount: num(amount), date, remarks: remarks.trim() || undefined })
    onSaved()
  }

  return (
    <Modal
      title={`Record month ${nextMonth}`}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid || busy} onClick={save}>Record</button>
      </>}
    >
      <Field label="Amount paid (₹)" hint={suggested ? `Suggested ${inr(suggested)} (pot ÷ months)` : undefined}>
        <input type="number" className="input" value={amount} onChange={e => setAmount(e.target.value)} />
      </Field>
      <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
      <Field label="Remarks"><input className="input" value={remarks} onChange={e => setRemarks(e.target.value)} placeholder="Optional" /></Field>
    </Modal>
  )
}
