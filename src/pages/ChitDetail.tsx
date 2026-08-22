import { useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, Boxes, Users, Gavel, Coins, HandCoins, Plus, UserPlus, Printer } from 'lucide-react'
import {
  repo, addChit, nextChitId, addChitMember, runChitAuction, assignChitTaker, collectChitDue, payChitTaker,
  getSettings,
} from '../data/repository'
import type { ChitCreation, ChitAuction, ChitTakenMember, ChitLedgerRow, ChitMember } from '../data/types'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { inr, fmtDate, phone, num } from '../lib/format'

type ModalState =
  | { kind: 'member' }
  | { kind: 'auction' }
  | { kind: 'taker'; auction: ChitAuction }
  | { kind: 'collect'; row: ChitLedgerRow }
  | { kind: 'payout'; taker: ChitTakenMember }
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
  const multiTakers = getSettings().chitMultipleTakersPerMonth
  if (!chit) return <EmptyState title="Chit fund not found" />

  const latestMonth = auctions.length ? num(auctions[auctions.length - 1].Month_Count) : null
  const shownMonth = month ?? latestMonth
  const shownAuction = auctions.find(a => num(a.Month_Count) === shownMonth)
  const ledgerRows = shownAuction ? repo.chitLedgerByAuction(shownAuction.Chit_Auction_ID) : []
  const monthDue = ledgerRows.reduce((s, r) => s + num(r.Due_Amount), 0)
  const monthRecv = ledgerRows.reduce((s, r) => s + num(r.Received_Amount), 0)

  return (
    <div>
      <Link to="/chit" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Chit funds</Link>
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

      <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-5">
        <StatCard label="Monthly pot" value={inr(num(chit.Total_Amount))} tone="blue" icon={<Boxes size={18} />} sub={`Commission ${num(chit.Chit_Percentage)}%`} />
        <StatCard label="Total months completed" value={`${num(chit.No_Month_Completed)} / ${num(chit.Total_Month)}`} tone="green" />
        <StatCard label="Total member taken" value={num(chit.Total_Member_Taken)} tone="slate" icon={<Users size={18} />} sub={`of ${num(chit.Total_Chit_Count) || num(chit.No_Members)} shares`} />
        <StatCard label="Total with company" value={Math.max(0, num(chit.No_Month_Completed) - num(chit.Total_Member_Taken))} tone="amber" sub="months held (completed − taken)" />
        <StatCard label="Dues collected" value={inr(summary.collected)} tone="green" sub={`${inr(summary.duePending)} pending`} />
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
                  const takenPct = tk.reduce((s, t) => s + num(t.Percentage_Need_to_Take), 0)
                  const canAssign = multiTakers ? takenPct < 1 : tk.length === 0
                  return (
                    <tr key={a.Chit_Auction_ID} className="hover:bg-slate-800/40">
                      <Td className="font-medium text-slate-200">#{num(a.Month_Count)}</Td>
                      <Td className="text-slate-400">{fmtDate(a.Date_Auction)}</Td>
                      <Td right className="text-slate-300">{inr(num(a.Total_Auction_Amount))}</Td>
                      <Td right className="text-slate-300">{inr(num(a.Indivitual_Member_Amount))}</Td>
                      <Td right className="text-hd">{inr(num(a.Total_Auction_Amount_After_Commission))}</Td>
                      <Td className="text-slate-300">{tk.length ? tk.map(t => t.Member_Name).join(', ') : <span className="text-slate-500">—</span>}</Td>
                      <Td><Badge tone={statusTone(a.Auction_Status)}>{a.Auction_Status ?? '—'}</Badge></Td>
                      {editable && <Td>{canAssign && <button className="btn-ghost !py-1 !px-2 text-xs" onClick={() => setModal({ kind: 'taker', auction: a })}><Plus size={12} /> Assign taker</button>}</Td>}
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
                    <Link to={`/chit/member/${encodeURIComponent(m.Member_ID)}`} className="text-left text-brand-300 hover:underline">{m.Member_Name}</Link>
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
        onSave={(amt, date, pt, remarks) => collectChitDue(modal.row.ID, amt, date, pt, remarks).then(refresh)}
      />}
      {modal?.kind === 'payout' && <AmountModal
        title={`Pay taker — ${modal.taker.Member_Name}`}
        max={num(modal.taker.Pending_Amount)}
        onClose={() => setModal(null)}
        onSave={(amt, date, pt, remarks) => payChitTaker(modal.taker.Chit_Taken_ID, amt, date, pt, remarks).then(refresh)}
      />}
    </div>
  )
}

// ── Create a chit fund you run ──────────────────────────────────────────────
export function CreateChitModal({ defaultFinance, onClose, onSaved }: { defaultFinance: string; onClose: () => void; onSaved: () => void }) {
  const finances = repo.finances()
  const [name, setName] = useState('')
  const [financeName, setFinanceName] = useState(defaultFinance)
  const [fromDate, setFromDate] = useState(new Date().toISOString().slice(0, 10))
  const [totalAmount, setTotalAmount] = useState('')
  const [totalMonth, setTotalMonth] = useState('')
  const [noMembers, setNoMembers] = useState('')
  const [pct, setPct] = useState('3')
  const [busy, setBusy] = useState(false)

  const commission = Math.round(num(pct) / 100 * num(totalAmount))
  const valid = name.trim() && financeName && num(totalAmount) > 0 && num(totalMonth) > 0

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    const chit: ChitCreation = {
      Chit_ID: nextChitId(financeName), Chit_Name: name.trim(), Chit_From_Date: fromDate,
      No_Members: num(noMembers), Total_Month: num(totalMonth), Total_Amount: num(totalAmount),
      Chit_Percentage: num(pct), Finance_Name: financeName, Chit_Status: 'Open',
    }
    await addChit(chit)
    onSaved()
  }

  return (
    <Modal title="New chit fund" onClose={onClose} footer={<>
      <button className="btn-ghost" onClick={onClose}>Cancel</button>
      <button className="btn-primary" disabled={!valid || busy} onClick={save}>Create chit</button>
    </>}>
      <Field label="Chit name"><input className="input" value={name} onChange={e => setName(e.target.value)} placeholder="e.g. A" /></Field>
      <Field label="Finance">
        <select className="input" value={financeName} onChange={e => setFinanceName(e.target.value)}>
          {finances.map(f => <option key={f.Finance_Name} value={f.Finance_Name}>{f.Finance_Name}</option>)}
        </select>
      </Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Start date"><input type="date" className="input" value={fromDate} onChange={e => setFromDate(e.target.value)} /></Field>
        <Field label="No. of members"><input type="number" className="input" value={noMembers} onChange={e => setNoMembers(e.target.value)} placeholder="25" /></Field>
      </div>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Monthly pot (₹)" hint="Full auction amount"><input type="number" className="input" value={totalAmount} onChange={e => setTotalAmount(e.target.value)} placeholder="500000" /></Field>
        <Field label="Total months"><input type="number" className="input" value={totalMonth} onChange={e => setTotalMonth(e.target.value)} placeholder="20" /></Field>
      </div>
      <Field label="Commission %" hint={num(totalAmount) > 0 ? `Firm keeps ${inr(commission)} per full auction` : 'Charged on the pot'}>
        <input type="number" className="input" value={pct} onChange={e => setPct(e.target.value)} />
      </Field>
    </Modal>
  )
}

// ── Add member ──────────────────────────────────────────────────────────────
export function AddMemberModal({ chitId, onClose, onSaved }: { chitId: string; onClose: () => void; onSaved: () => void }) {
  const chit = repo.chit(chitId)!
  const perMemberComm = getSettings().chitPerMemberCommission
  const [name, setName] = useState('')
  const [phoneNo, setPhoneNo] = useState('')
  const [address, setAddress] = useState('')
  const [share, setShare] = useState('1')
  const [commission, setCommission] = useState('')
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
      Member_Commission: perMemberComm && commission.trim() !== '' ? num(commission) : undefined,
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
      {perMemberComm && (
        <Field label="Commission % for this member" hint="Used on payout when they take. Leave blank for the chit-wide %; enter 0 for no commission.">
          <input type="number" className="input" value={commission} onChange={e => setCommission(e.target.value)} placeholder="e.g. 2" />
        </Field>
      )}
      <Field label="Address"><input className="input" value={address} onChange={e => setAddress(e.target.value)} /></Field>
      <Field label="Recommended partner"><input className="input" value={partner} onChange={e => setPartner(e.target.value)} /></Field>
    </Modal>
  )
}

// ── Run auction ─────────────────────────────────────────────────────────────
export function RunAuctionModal({ chitId, onClose, onSaved }: { chitId: string; onClose: () => void; onSaved: () => void }) {
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
  // ── Interest on the auction (estimate) ──────────────────────────────────────
  // Discount = what members save vs the full pot. Months remaining includes this
  // month. Shown so you can gauge the effective interest; exact formula pending.
  const monthsRemaining = Math.max(1, totalMonth - nextMonth + 1)
  const discount = Math.max(0, num(chit.Total_Amount) - num(bid))
  const interestPerMonth = Math.round(discount / monthsRemaining)
  const interestPctEst = num(chit.Total_Amount) > 0 ? (discount / num(chit.Total_Amount) * 100) : 0

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
      <div className="mt-2 rounded-lg border border-dashed border-slate-700 bg-slate-800/30 p-3 text-sm text-slate-300">
        <div className="mb-1 flex items-center gap-1.5 text-xs font-semibold uppercase tracking-wide text-brand-300">Interest on this auction <span className="font-normal normal-case text-slate-500">(estimate)</span></div>
        <div className="flex justify-between"><span className="text-slate-400">Months remaining</span><b>{monthsRemaining}</b></div>
        <div className="flex justify-between"><span className="text-slate-400">Auction discount (pot − bid)</span><b>{inr(discount)}</b></div>
        <div className="flex justify-between"><span className="text-slate-400">Interest ≈ discount ÷ months</span><b>{inr(interestPerMonth)}/mo</b></div>
        <div className="flex justify-between"><span className="text-slate-400">Interest %</span><b>{interestPctEst.toFixed(2)}%</b></div>
        <p className="mt-1 text-xs text-slate-500">Estimate only — tell me your exact interest formula and I'll wire it in.</p>
      </div>
    </Modal>
  )
}

// ── Assign taker ────────────────────────────────────────────────────────────
export function AssignTakerModal({ chitId, auction, onClose, onSaved }: { chitId: string; auction: ChitAuction; onClose: () => void; onSaved: () => void }) {
  const members = repo.chitMembers(chitId)
  const chit = repo.chit(chitId)
  const perMemberComm = getSettings().chitPerMemberCommission
  const [memberId, setMemberId] = useState('')
  const [pct, setPct] = useState('1')
  const [busy, setBusy] = useState(false)
  const member = members.find(m => m.Member_ID === memberId)
  // Mirror the payout math in assignChitTaker so the preview matches what's saved.
  const memComm = (perMemberComm && member && member.Member_Commission !== undefined && member.Member_Commission !== null)
    ? Math.round(num(member.Member_Commission) / 100 * num(chit?.Total_Amount)) : null
  const base = memComm !== null ? num(auction.Total_Auction_Amount) - memComm : num(auction.Total_Auction_Amount_After_Commission)
  const payout = Math.round(base * (num(pct) || 1))
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
        </select>
      </Field>
      <Field label="Share taken" hint="1 = full payout, 0.5 = half. A ½-share member still bids the full auction, but is paid half of it.">
        <select className="input" value={pct} onChange={e => setPct(e.target.value)}><option value="1">1 (full)</option><option value="0.5">0.5 (half)</option></select>
      </Field>
      <div className="rounded-lg bg-slate-800/50 p-3 text-sm text-slate-300">
        {memComm !== null && (
          <div className="mb-1 flex justify-between"><span className="text-slate-400">Member commission ({num(member?.Member_Commission)}%)</span><b className="text-amber-300">− {inr(memComm)}</b></div>
        )}
        <div className="flex justify-between"><span className="text-slate-400">Payout owed to taker</span><b className="text-hd">{inr(payout)}</b></div>
      </div>
    </Modal>
  )
}

// ── Generic amount modal (collect due / pay taker) ──────────────────────────
export function AmountModal({ title, max, onClose, onSave }: { title: string; max: number; onClose: () => void; onSave: (amount: number, date: string, payType: string, remarks?: string) => Promise<void> }) {
  const [amount, setAmount] = useState(String(max))
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [payType, setPayType] = useState('Cash')
  const [remarks, setRemarks] = useState('')
  const [busy, setBusy] = useState(false)
  const amt = num(amount)
  const valid = amt > 0 && amt <= max

  async function save() {
    if (!valid || busy) return
    setBusy(true)
    await onSave(amt, date, payType, remarks.trim() || undefined)
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
      <Field label="Notes / remarks" hint="Optional — a note to remind you later"><input className="input" value={remarks} onChange={e => setRemarks(e.target.value)} placeholder="e.g. paid partial, will clear next week" /></Field>
    </Modal>
  )
}

