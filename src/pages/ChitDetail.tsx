import { useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Boxes, Users, Gavel, Coins, HandCoins, Plus, UserPlus, Printer } from 'lucide-react'
import {
  repo, addChitMember, runChitAuction, assignChitTaker, collectChitDue, payChitTaker,
} from '../data/repository'
import type { ChitAuction, ChitTakenMember, ChitLedgerRow, ChitMember } from '../data/types'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { inr, fmtDate, phone, num } from '../lib/format'

type ModalState =
  | { kind: 'member' }
  | { kind: 'auction' }
  | { kind: 'taker'; auction: ChitAuction }
  | { kind: 'collect'; row: ChitLedgerRow }
  | { kind: 'payout'; taker: ChitTakenMember }
  | { kind: 'statement'; member: ChitMember }
  | null

export default function ChitDetail() {
  const { chitId = '' } = useParams()
  const id = decodeURIComponent(chitId)
  const role = useApp(s => s.user?.role)
  const editable = canEdit(role)
  const [tick, setTick] = useState(0)
  const [modal, setModal] = useState<ModalState>(null)
  const refresh = () => { setModal(null); setTick(t => t + 1) }

  const data = useMemo(() => {
    const chit = repo.chit(id)
    const members = repo.chitMembers(id)
    const auctions = repo.chitAuctions(id)
    const takers = repo.chitTakers(id)
    const summary = repo.chitSummary(id)
    const takenByAuction = new Map<string, ChitTakenMember[]>()
    for (const t of takers) {
      const arr = takenByAuction.get(t.Chit_Auction_ID) ?? []
      arr.push(t); takenByAuction.set(t.Chit_Auction_ID, arr)
    }
    return { chit, members, auctions, takers, summary, takenByAuction }
  }, [id, tick])

  const [month, setMonth] = useState<number | null>(null)
  const { chit, members, auctions, takers, summary, takenByAuction } = data
  if (!chit) return <EmptyState title="Chit fund not found" />

  const latestMonth = auctions.length ? num(auctions[auctions.length - 1].Month_Count) : null
  const shownMonth = month ?? latestMonth
  const shownAuction = auctions.find(a => num(a.Month_Count) === shownMonth)
  const ledgerRows = shownAuction ? repo.chitLedgerByAuction(shownAuction.Chit_Auction_ID) : []
  const monthDue = ledgerRows.reduce((s, r) => s + num(r.Due_Amount), 0)
  const monthRecv = ledgerRows.reduce((s, r) => s + num(r.Received_Amount), 0)

  return (
    <div>
      <Link to="/chits" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Chits</Link>
      <PageHeader
        title={`Chit ${chit.Chit_Name}`}
        subtitle={`${chit.Chit_ID} · ${chit.Finance_Name}`}
        action={
          <div className="flex flex-wrap items-center gap-2">
            <Badge tone={statusTone(chit.Chit_Status)}>{chit.Chit_Status ?? '—'}</Badge>
            {editable && <button className="btn-ghost !py-1.5" onClick={() => setModal({ kind: 'member' })}><UserPlus size={15} /> Add member</button>}
            {editable && <button className="btn-primary !py-1.5" onClick={() => setModal({ kind: 'auction' })}><Gavel size={15} /> Run auction</button>}
          </div>
        }
      />

      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard label="Monthly pot" value={inr(num(chit.Total_Amount))} tone="blue" icon={<Boxes size={18} />} sub={`Commission ${num(chit.Chit_Percentage)}%`} />
        <StatCard label="Members" value={members.length} tone="slate" icon={<Users size={18} />} sub={`${num(chit.Total_Member_Taken)} / ${num(chit.Total_Chit_Count) || num(chit.No_Members)} shares taken`} />
        <StatCard label="Months completed" value={`${num(chit.No_Month_Completed)} / ${num(chit.Total_Month)}`} tone="green" />
        <StatCard label="Dues collected" value={inr(summary.collected)} tone="amber" sub={`${inr(summary.duePending)} pending`} />
      </div>

      {/* ── Auctions ───────────────────────────────────────────────────────── */}
      <div className="mb-2 mt-8 flex items-center gap-2"><Gavel size={16} className="text-brand-400" /><h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Monthly auctions</h2></div>
      {auctions.length === 0 ? <EmptyState title="No auctions yet" hint={editable ? 'Use “Run auction” to start month 1.' : undefined} /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Month</Th><Th>Date</Th><Th right>Bid pot</Th><Th right>Per share</Th><Th right>Payout</Th><Th>Taken by</Th><Th>Status</Th>{editable && <Th>Action</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {auctions.map(a => {
                  const tk = takenByAuction.get(a.Chit_Auction_ID) ?? []
                  return (
                    <tr key={a.Chit_Auction_ID} className="hover:bg-slate-800/40">
                      <Td className="font-medium text-slate-200">#{num(a.Month_Count)}</Td>
                      <Td className="text-slate-400">{fmtDate(a.Date_Auction)}</Td>
                      <Td right className="text-slate-300">{inr(num(a.Total_Auction_Amount))}</Td>
                      <Td right className="text-slate-300">{inr(num(a.Indivitual_Member_Amount))}</Td>
                      <Td right className="text-hd">{inr(num(a.Total_Auction_Amount_After_Commission))}</Td>
                      <Td className="text-slate-300">{tk.length ? tk.map(t => t.Member_Name).join(', ') : <span className="text-slate-500">—</span>}</Td>
                      <Td><Badge tone={statusTone(a.Auction_Status)}>{a.Auction_Status ?? '—'}</Badge></Td>
                      {editable && <Td>{tk.length === 0 && <button className="btn-ghost !py-1 !px-2 text-xs" onClick={() => setModal({ kind: 'taker', auction: a })}><Plus size={12} /> Assign taker</button>}</Td>}
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {/* ── Chit Ledger (per-member monthly dues) ──────────────────────────── */}
      <div className="mb-2 mt-8 flex flex-wrap items-center justify-between gap-2">
        <div className="flex items-center gap-2"><Coins size={16} className="text-brand-400" /><h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Chit ledger — monthly dues</h2></div>
        {auctions.length > 0 && (
          <select className="input !w-auto !py-1 text-sm" value={shownMonth ?? ''} onChange={e => setMonth(Number(e.target.value))}>
            {auctions.map(a => <option key={a.Chit_Auction_ID} value={num(a.Month_Count)}>Month {num(a.Month_Count)} · {fmtDate(a.Date_Auction)}</option>)}
          </select>
        )}
      </div>
      {!shownAuction ? <EmptyState title="Run an auction to generate dues" /> : (
        <>
          <div className="mb-3 flex flex-wrap gap-4 text-sm text-slate-400">
            <span>Due this month: <b className="text-hd">{inr(monthDue)}</b></span>
            <span>Collected: <b className="text-emerald-400">{inr(monthRecv)}</b></span>
            <span>Pending: <b className="text-rose-300">{inr(monthDue - monthRecv)}</b></span>
          </div>
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Member</Th><Th right>Share</Th><Th right>Due</Th><Th right>Received</Th><Th right>Pending</Th><Th>Status</Th>{editable && <Th>Action</Th>}</tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {ledgerRows.map(r => (
                    <tr key={r.ID} className="hover:bg-slate-800/40">
                      <Td className="text-slate-200">{r.Member_Name}</Td>
                      <Td right className="text-slate-400">{num(r.Member_Percentage)}</Td>
                      <Td right className="text-slate-300">{inr(num(r.Due_Amount))}</Td>
                      <Td right className="text-emerald-400">{inr(num(r.Received_Amount))}</Td>
                      <Td right className="text-rose-300">{num(r.Pending_Amount) ? inr(num(r.Pending_Amount)) : '—'}</Td>
                      <Td><Badge tone={statusTone(r.Status)}>{r.Status ?? '—'}</Badge></Td>
                      {editable && <Td>{num(r.Pending_Amount) > 0 && <button className="btn-ghost !py-1 !px-2 text-xs text-emerald-300" onClick={() => setModal({ kind: 'collect', row: r })}><HandCoins size={12} /> Collect</button>}</Td>}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </>
      )}

      {/* ── Payouts to takers ──────────────────────────────────────────────── */}
      {takers.length > 0 && (
        <>
          <div className="mb-2 mt-8 flex items-center gap-2"><HandCoins size={16} className="text-brand-400" /><h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Payouts to takers</h2></div>
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>Month</Th><Th>Member</Th><Th right>Share</Th><Th right>Payout</Th><Th right>Given</Th><Th right>Pending</Th><Th>Status</Th>{editable && <Th>Action</Th>}</tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {takers.map(t => (
                    <tr key={t.Chit_Taken_ID} className="hover:bg-slate-800/40">
                      <Td className="text-slate-400">#{num(t.Month_Count)}</Td>
                      <Td className="text-slate-200">{t.Member_Name}{t.Member_Type === 'Company_Chit' && <span className="ml-1 text-xs text-slate-500">(company)</span>}</Td>
                      <Td right className="text-slate-400">{num(t.Percentage_Need_to_Take)}</Td>
                      <Td right className="text-hd">{inr(num(t.Total_Amount_to_Member))}</Td>
                      <Td right className="text-emerald-400">{inr(num(t.Amount_Given_to_Member))}</Td>
                      <Td right className="text-rose-300">{num(t.Pending_Amount) ? inr(num(t.Pending_Amount)) : '—'}</Td>
                      <Td><Badge tone={statusTone(t.Status)}>{t.Status ?? '—'}</Badge></Td>
                      {editable && <Td>{num(t.Pending_Amount) > 0 && <button className="btn-ghost !py-1 !px-2 text-xs text-emerald-300" onClick={() => setModal({ kind: 'payout', taker: t })}><HandCoins size={12} /> Pay</button>}</Td>}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </>
      )}

      {/* ── Members ────────────────────────────────────────────────────────── */}
      <div className="mb-2 mt-8 flex items-center gap-2"><Users size={16} className="text-slate-400" /><h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Members</h2></div>
      <Card className="!p-0 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-900/60">
              <tr><Th>Member</Th><Th>Phone</Th><Th right>Share</Th><Th>Chit</Th><Th right>Taken amount</Th><Th right>Payout pending</Th></tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {members.map(m => (
                <tr key={m.Member_ID} className="hover:bg-slate-800/40">
                  <Td>
                    <button className="text-left text-brand-300 hover:underline" onClick={() => setModal({ kind: 'statement', member: m })}>{m.Member_Name}</button>
                    {m.Member_Type && m.Member_Type !== 'Member' && <p className="text-xs text-slate-500">{m.Member_Type}</p>}
                  </Td>
                  <Td className="text-slate-400">{phone(m.Member_Phone_No)}</Td>
                  <Td right className="text-slate-400">{num(m.Member_Percentage)}</Td>
                  <Td><Badge tone={(m.Chit_Taken === 'Taken') ? 'green' : 'slate'}>{m.Chit_Taken === 'Taken' ? 'Taken' : 'Not taken'}</Badge></Td>
                  <Td right className="text-slate-300">{num(m.Chit_Taken_Amount) ? inr(num(m.Chit_Taken_Amount)) : '—'}</Td>
                  <Td right className="text-rose-300">{num(m.Remaining_Amount) ? inr(num(m.Remaining_Amount)) : '—'}</Td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </Card>

      {/* ── Modals ─────────────────────────────────────────────────────────── */}
      {modal?.kind === 'member' && <AddMemberModal chitId={id} onClose={() => setModal(null)} onSaved={refresh} />}
      {modal?.kind === 'auction' && <RunAuctionModal chitId={id} onClose={() => setModal(null)} onSaved={refresh} />}
      {modal?.kind === 'taker' && <AssignTakerModal chitId={id} auction={modal.auction} onClose={() => setModal(null)} onSaved={refresh} />}
      {modal?.kind === 'collect' && <AmountModal
        title={`Collect due — ${modal.row.Member_Name}`}
        max={num(modal.row.Pending_Amount)}
        onClose={() => setModal(null)}
        onSave={(amt, date, pt) => collectChitDue(modal.row.ID, amt, date, pt).then(refresh)}
      />}
      {modal?.kind === 'payout' && <AmountModal
        title={`Pay taker — ${modal.taker.Member_Name}`}
        max={num(modal.taker.Pending_Amount)}
        onClose={() => setModal(null)}
        onSave={(amt, date, pt) => payChitTaker(modal.taker.Chit_Taken_ID, amt, date, pt).then(refresh)}
      />}
      {modal?.kind === 'statement' && <MemberStatementModal member={modal.member} onClose={() => setModal(null)} />}
    </div>
  )
}

// ── Per-member statement: dues across all months + payout taken ─────────────
function MemberStatementModal({ member, onClose }: { member: ChitMember; onClose: () => void }) {
  const chit = repo.chit(member.Chit_ID)
  const dues = repo.chitLedgerByMember(member.Member_ID)
  const takings = repo.chitTakers(member.Chit_ID).filter(t => t.Member_ID === member.Member_ID)
  const totDue = dues.reduce((s, r) => s + num(r.Due_Amount), 0)
  const totRecv = dues.reduce((s, r) => s + num(r.Received_Amount), 0)
  const totPend = dues.reduce((s, r) => s + num(r.Pending_Amount), 0)
  const payout = takings.reduce((s, t) => s + num(t.Total_Amount_to_Member), 0)
  const payoutGiven = takings.reduce((s, t) => s + num(t.Amount_Given_to_Member), 0)

  function printStatement() {
    printChitStatement({ member, chitName: chit?.Chit_Name, dues, takings, totDue, totRecv, totPend, payout, payoutGiven })
  }

  return (
    <Modal title={`Statement — ${member.Member_Name}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={printStatement}><Printer size={15} /> Print / PDF</button>
      <button className="btn-primary" onClick={onClose}>Close</button>
    </>}>
      <div className="flex flex-wrap gap-x-4 gap-y-1 text-xs text-slate-400">
        <span>{member.Member_ID}</span>
        <span>Share {num(member.Member_Percentage)}</span>
        <span>{phone(member.Member_Phone_No)}</span>
        <span>Chit {member.Chit_Taken === 'Taken' ? 'taken' : 'not taken'}</span>
      </div>

      <div className="mt-2 grid grid-cols-3 gap-2 text-center">
        <div className="rounded-lg bg-slate-800/50 p-2"><p className="label">Due</p><p className="text-sm font-bold text-hd">{inr(totDue)}</p></div>
        <div className="rounded-lg bg-slate-800/50 p-2"><p className="label">Paid</p><p className="text-sm font-bold text-emerald-400">{inr(totRecv)}</p></div>
        <div className="rounded-lg bg-slate-800/50 p-2"><p className="label">Pending</p><p className="text-sm font-bold text-rose-300">{inr(totPend)}</p></div>
      </div>

      <h4 className="mt-4 mb-1 text-xs font-semibold uppercase tracking-wide text-slate-400">Monthly dues</h4>
      <div className="overflow-x-auto rounded-lg ring-1 ring-inset ring-slate-800">
        <table className="w-full">
          <thead className="bg-slate-900/60"><tr><Th>Month</Th><Th right>Due</Th><Th right>Paid</Th><Th right>Pending</Th><Th>Status</Th></tr></thead>
          <tbody className="divide-y divide-slate-800">
            {dues.map(r => (
              <tr key={r.ID}>
                <Td className="text-slate-400">#{num(r.Month_Count)} · {fmtDate(r.Date_Auction)}</Td>
                <Td right className="text-slate-300">{inr(num(r.Due_Amount))}</Td>
                <Td right className="text-emerald-400">{inr(num(r.Received_Amount))}</Td>
                <Td right className="text-rose-300">{num(r.Pending_Amount) ? inr(num(r.Pending_Amount)) : '—'}</Td>
                <Td><Badge tone={statusTone(r.Status)}>{r.Status ?? '—'}</Badge></Td>
              </tr>
            ))}
            {dues.length === 0 && <tr><Td className="text-slate-500">No dues yet.</Td><Td>{''}</Td><Td>{''}</Td><Td>{''}</Td><Td>{''}</Td></tr>}
          </tbody>
        </table>
      </div>

      {takings.length > 0 && (
        <>
          <h4 className="mt-4 mb-1 text-xs font-semibold uppercase tracking-wide text-slate-400">Chit taken — payout {inr(payoutGiven)} of {inr(payout)}</h4>
          <div className="overflow-x-auto rounded-lg ring-1 ring-inset ring-slate-800">
            <table className="w-full">
              <thead className="bg-slate-900/60"><tr><Th>Month</Th><Th right>Share</Th><Th right>Payout</Th><Th right>Given</Th><Th right>Pending</Th></tr></thead>
              <tbody className="divide-y divide-slate-800">
                {takings.map(t => (
                  <tr key={t.Chit_Taken_ID}>
                    <Td className="text-slate-400">#{num(t.Month_Count)} · {fmtDate(t.Date_Auction)}</Td>
                    <Td right className="text-slate-400">{num(t.Percentage_Need_to_Take)}</Td>
                    <Td right className="text-hd">{inr(num(t.Total_Amount_to_Member))}</Td>
                    <Td right className="text-emerald-400">{inr(num(t.Amount_Given_to_Member))}</Td>
                    <Td right className="text-rose-300">{num(t.Pending_Amount) ? inr(num(t.Pending_Amount)) : '—'}</Td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </>
      )}
    </Modal>
  )
}

// ── Add member ──────────────────────────────────────────────────────────────
function AddMemberModal({ chitId, onClose, onSaved }: { chitId: string; onClose: () => void; onSaved: () => void }) {
  const chit = repo.chit(chitId)!
  const [name, setName] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const [address, setAddress] = useState('')
  const [share, setShare] = useState('1')
  const [partner, setPartner] = useState('')
  const [busy, setBusy] = useState(false)
  const valid = name.trim().length > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await addChitMember({
      Chit_ID: chitId, Finance_Name: chit.Finance_Name, Member_Name: name.trim(),
      Member_Phone_No: phoneNo ? num(phoneNo) : undefined, Member_Address: address || undefined,
      Member_Percentage: num(share) || 1, Recommended_Partner: partner || undefined,
      Date_Added: new Date().toISOString().slice(0, 10),
    })
    onSaved()
  }

  return (
    <Modal title="Add member" onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Add member</button>
    </>}>
      <Field label="Name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Phone"><input className="input" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
        <Field label="Share" hint="1 = full, 0.5 = half">
          <select className="input" value={share} onChange={e => setShare(e.target.value)}><option value="1">1 (full)</option><option value="0.5">0.5 (half)</option></select>
        </Field>
      </div>
      <Field label="Address"><input className="input" value={address} onChange={e => setAddress(e.target.value)} /></Field>
      <Field label="Recommended partner"><input className="input" value={partner} onChange={e => setPartner(e.target.value)} /></Field>
    </Modal>
  )
}

// ── Run auction ─────────────────────────────────────────────────────────────
function RunAuctionModal({ chitId, onClose, onSaved }: { chitId: string; onClose: () => void; onSaved: () => void }) {
  const chit = repo.chit(chitId)!
  const nextMonth = repo.chitAuctions(chitId).reduce((m, a) => Math.max(m, num(a.Month_Count)), 0) + 1
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [bid, setBid] = useState(String(num(chit.Total_Amount)))
  const [interest, setInterest] = useState(nextMonth === 1 ? '0' : '1')
  const [type, setType] = useState(nextMonth === 1 ? 'Finance' : 'Member')
  const [busy, setBusy] = useState(false)

  const totalMonth = num(chit.Total_Month) || num(chit.No_Members) || 1
  const perShare = Math.round(num(bid) / totalMonth)
  const commission = type === 'Finance' ? 0 : Math.round(num(chit.Chit_Percentage) / 100 * num(chit.Total_Amount))
  const payout = num(bid) - commission
  const valid = num(bid) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await runChitAuction({ chitId, date, totalAuctionAmount: num(bid), interestPercentage: num(interest), memberType: type })
    onSaved()
  }

  return (
    <Modal title={`Run auction — month ${nextMonth}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Run auction</button>
    </>}>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Auction date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Auction discount %"><input type="number" className="input" value={interest} onChange={e => setInterest(e.target.value)} /></Field>
      </div>
      <Field label="Bid pot (₹)" hint="What members collectively pay this month"><input type="number" className="input" value={bid} onChange={e => setBid(e.target.value)} /></Field>
      <Field label="Winner type" hint="“Finance” waives commission (usually month 1)">
        <select className="input" value={type} onChange={e => setType(e.target.value)}><option value="Member">Member</option><option value="Finance">Finance</option><option value="Other">Other</option></select>
      </Field>
      <div className="rounded-lg bg-slate-800/50 p-3 text-sm text-slate-300">
        <div className="flex justify-between"><span className="text-slate-400">Per full share</span><b>{inr(perShare)}</b></div>
        <div className="flex justify-between"><span className="text-slate-400">Commission</span><b>{inr(commission)}</b></div>
        <div className="flex justify-between"><span className="text-slate-400">Payout to taker</span><b className="text-hd">{inr(payout)}</b></div>
      </div>
    </Modal>
  )
}

// ── Assign taker ────────────────────────────────────────────────────────────
function AssignTakerModal({ chitId, auction, onClose, onSaved }: { chitId: string; auction: ChitAuction; onClose: () => void; onSaved: () => void }) {
  const members = repo.chitMembers(chitId)
  const [memberId, setMemberId] = useState('')
  const [pct, setPct] = useState('1')
  const [busy, setBusy] = useState(false)
  const payout = Math.round(num(auction.Total_Auction_Amount_After_Commission) * (num(pct) || 1))
  const valid = memberId.length > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await assignChitTaker({ auctionId: auction.Chit_Auction_ID, memberId, percentageNeedToTake: num(pct) || 1 })
    onSaved()
  }

  return (
    <Modal title={`Assign taker — month ${num(auction.Month_Count)}`} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Assign taker</button>
    </>}>
      <Field label="Who took this month's chit?">
        <select className="input" value={memberId} onChange={e => setMemberId(e.target.value)}>
          <option value="">Select…</option>
          {members.map(m => <option key={m.Member_ID} value={m.Member_ID}>{m.Member_Name} ({num(m.Member_Percentage)})</option>)}
          <option value="Company_Chit">Company Chit (unsold)</option>
        </select>
      </Field>
      <Field label="Share taken" hint="1 = full payout, 0.5 = half">
        <select className="input" value={pct} onChange={e => setPct(e.target.value)}><option value="1">1 (full)</option><option value="0.5">0.5 (half)</option></select>
      </Field>
      <div className="rounded-lg bg-slate-800/50 p-3 text-sm text-slate-300">
        <div className="flex justify-between"><span className="text-slate-400">Payout owed to taker</span><b className="text-hd">{inr(payout)}</b></div>
      </div>
    </Modal>
  )
}

// ── Generic amount modal (collect due / pay taker) ──────────────────────────
function AmountModal({ title, max, onClose, onSave }: { title: string; max: number; onClose: () => void; onSave: (amount: number, date: string, payType: string) => Promise<void> }) {
  const [amount, setAmount] = useState(String(max))
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [payType, setPayType] = useState('Cash')
  const [busy, setBusy] = useState(false)
  const amt = num(amount)
  const valid = amt > 0 && amt <= max

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await onSave(amt, date, payType)
  }

  return (
    <Modal title={title} onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Save</button>
    </>}>
      <Field label="Amount (₹)" hint={`Pending ${inr(max)}`}><input type="number" className="input" value={amount} onChange={e => setAmount(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Date"><input type="date" className="input" value={date} onChange={e => setDate(e.target.value)} /></Field>
        <Field label="Payment type">
          <select className="input" value={payType} onChange={e => setPayType(e.target.value)}><option>Cash</option><option>UPI</option><option>Account</option><option>Other</option></select>
        </Field>
      </div>
    </Modal>
  )
}

// ── Printable / PDF-exportable member statement ─────────────────────────────
// Builds a standalone, self-contained HTML document and opens it in a new window
// for the browser's Print dialog (which also offers “Save as PDF”).
interface PrintData {
  member: ChitMember
  chitName?: string
  dues: ChitLedgerRow[]
  takings: ChitTakenMember[]
  totDue: number; totRecv: number; totPend: number; payout: number; payoutGiven: number
}
function printChitStatement(d: PrintData): void {
  const esc = (s: unknown) => String(s ?? '').replace(/[&<>]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string))
  const rup = (n: number) => `₹${Math.round(n).toLocaleString('en-IN')}`
  const today = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })

  const dueRows = d.dues.map(r => `<tr>
    <td>#${num(r.Month_Count)} · ${esc(fmtDate(r.Date_Auction))}</td>
    <td class="r">${rup(num(r.Due_Amount))}</td>
    <td class="r">${rup(num(r.Received_Amount))}</td>
    <td class="r">${num(r.Pending_Amount) ? rup(num(r.Pending_Amount)) : '—'}</td>
    <td>${esc(r.Status)}</td></tr>`).join('')

  const payoutSection = d.takings.length ? `
    <h3>Chit taken — payout ${rup(d.payoutGiven)} of ${rup(d.payout)}</h3>
    <table><thead><tr><th>Month</th><th class="r">Share</th><th class="r">Payout</th><th class="r">Given</th><th class="r">Pending</th></tr></thead>
    <tbody>${d.takings.map(t => `<tr>
      <td>#${num(t.Month_Count)} · ${esc(fmtDate(t.Date_Auction))}</td>
      <td class="r">${num(t.Percentage_Need_to_Take)}</td>
      <td class="r">${rup(num(t.Total_Amount_to_Member))}</td>
      <td class="r">${rup(num(t.Amount_Given_to_Member))}</td>
      <td class="r">${num(t.Pending_Amount) ? rup(num(t.Pending_Amount)) : '—'}</td></tr>`).join('')}</tbody></table>` : ''

  const html = `<!doctype html><html><head><meta charset="utf-8"><title>Chit statement — ${esc(d.member.Member_Name)}</title>
  <style>
    *{box-sizing:border-box} body{font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#0f172a;margin:32px;font-size:13px}
    h1{font-size:20px;margin:0} h2{font-size:14px;color:#475569;margin:2px 0 16px} h3{font-size:13px;margin:20px 0 6px;text-transform:uppercase;letter-spacing:.04em;color:#475569}
    .meta{color:#475569;font-size:12px;margin-bottom:14px} .meta span{margin-right:14px}
    .cards{display:flex;gap:10px;margin:10px 0 4px} .cards div{flex:1;border:1px solid #e2e8f0;border-radius:8px;padding:8px 10px}
    .cards .k{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .cards .v{font-size:16px;font-weight:700}
    table{width:100%;border-collapse:collapse;margin-top:4px} th,td{border-bottom:1px solid #e2e8f0;padding:6px 8px;text-align:left}
    th{font-size:10px;text-transform:uppercase;letter-spacing:.04em;color:#64748b} .r{text-align:right;font-variant-numeric:tabular-nums}
    .foot{margin-top:24px;color:#94a3b8;font-size:11px} @media print{body{margin:12mm}}
  </style></head><body>
    <h1>Chit Statement</h1>
    <h2>${esc(d.member.Finance_Name)}${d.chitName ? ` · Chit ${esc(d.chitName)}` : ''}</h2>
    <div class="meta">
      <span><b>${esc(d.member.Member_Name)}</b></span>
      <span>${esc(d.member.Member_ID)}</span>
      <span>Share ${num(d.member.Member_Percentage)}</span>
      <span>${esc(d.member.Member_Phone_No ?? '')}</span>
      <span>Chit ${d.member.Chit_Taken === 'Taken' ? 'taken' : 'not taken'}</span>
    </div>
    <div class="cards">
      <div><div class="k">Total due</div><div class="v">${rup(d.totDue)}</div></div>
      <div><div class="k">Paid</div><div class="v">${rup(d.totRecv)}</div></div>
      <div><div class="k">Pending</div><div class="v">${rup(d.totPend)}</div></div>
    </div>
    <h3>Monthly dues</h3>
    <table><thead><tr><th>Month</th><th class="r">Due</th><th class="r">Paid</th><th class="r">Pending</th><th>Status</th></tr></thead>
    <tbody>${dueRows || '<tr><td colspan="5">No dues yet.</td></tr>'}</tbody></table>
    ${payoutSection}
    <div class="foot">Generated ${today} · Arul Finance</div>
    <script>window.onload=function(){window.print()}</script>
  </body></html>`

  const w = window.open('', '_blank')
  if (!w) { alert('Allow pop-ups to print the statement.'); return }
  w.document.open(); w.document.write(html); w.document.close()
}
