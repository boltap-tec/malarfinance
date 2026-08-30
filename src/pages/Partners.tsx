import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Users2, Plus, Pencil, Trash2 } from 'lucide-react'
import { repo, addPartner, updatePartner, deletePartner } from '../data/repository'
import { useApp, financeFilter, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Th, Td, EmptyState, Modal, Field } from '../components/ui'
import { phone, inr, num } from '../lib/format'
import type { Partner } from '../data/types'

export default function Partners() {
  const finance = useApp(s => s.finance)
  const role = useApp(s => s.user?.role)
  const isMd = role === 'md'
  const [tick, setTick] = useState(0)
  const [form, setForm] = useState<{ mode: 'new' | 'edit'; partner?: Partner } | null>(null)
  const [confirm, setConfirm] = useState<Partner | null>(null)

  // Per-partner exposure: outstanding on the loans they referred, plus the
  // pending interest on those loans.
  const { rows, totals } = useMemo(() => {
    const f = financeFilter(finance)
    const list = repo.partners(f)
    const loans = repo.loans(f)
    const interest = repo.interest(f)
    const totals: Record<string, { loan: number; interest: number }> = {}
    for (const p of list) {
      const loan = loans.filter(l => l.Referred_Partner === p.Partner_ID).reduce((s, l) => s + num(l.Outstand_Amount), 0)
      const int = interest.filter(i => i.Referred_Partner === p.Partner_ID).reduce((s, i) => s + num(i.Interest_Pending), 0)
      totals[p.Partner_ID] = { loan, interest: int }
    }
    // Group active partners (still carrying outstanding loan or interest) first,
    // then by outstanding loan. Partners have no explicit status column.
    const active = (p: Partner) => (totals[p.Partner_ID]?.loan ?? 0) > 0 || (totals[p.Partner_ID]?.interest ?? 0) > 0
    const sorted = list.slice().sort((a, b) =>
      (Number(active(b)) - Number(active(a))) ||
      ((totals[b.Partner_ID]?.loan ?? 0) - (totals[a.Partner_ID]?.loan ?? 0)),
    )
    return { rows: sorted, totals }
  }, [finance, tick])
  const finances = repo.finances()

  return (
    <div>
      <PageHeader
        title="Partners"
        subtitle="Owners / partners across your finances."
        action={isMd && <button className="btn-primary" onClick={() => setForm({ mode: 'new' })}><Plus size={16} /> New partner</button>}
      />

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-3">
        <StatCard label="Partners" value={rows.length} tone="blue" icon={<Users2 size={18} />} />
        <StatCard label="Finances" value={finances.length} tone="slate" />
      </div>

      {rows.length === 0 ? <EmptyState title="No partners" /> : (
        <Card className="!p-0 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="border-b border-slate-800 bg-slate-900/60">
                <tr><Th>Partner</Th><Th>ID</Th><Th>Finance</Th><Th>Phone</Th><Th right>Outstanding loan</Th><Th right>Outstanding interest</Th>{isMd && <Th>Actions</Th>}</tr>
              </thead>
              <tbody className="divide-y divide-slate-800">
                {rows.map((p, i) => (
                  <tr key={i} className="hover:bg-slate-800/40">
                    <Td>
                      <div className="flex items-center gap-2">
                        <span className="grid h-8 w-8 place-items-center rounded-full bg-brand-600 text-xs font-bold text-white">
                          {p.Partner_Name?.[0]?.toUpperCase() ?? 'P'}
                        </span>
                        <Link to={`/partners/${encodeURIComponent(p.Partner_ID)}`} className="text-brand-300 hover:underline">{p.Partner_Name}</Link>
                      </div>
                    </Td>
                    <Td className="text-slate-400">{p.Partner_ID}</Td>
                    <Td className="text-slate-300">{p.Finance_Name}</Td>
                    <Td className="text-slate-400">{phone(p.Phone_Number)}</Td>
                    <Td right className="font-semibold text-hd">{inr(totals[p.Partner_ID]?.loan ?? 0)}</Td>
                    <Td right className={num(totals[p.Partner_ID]?.interest) > 0 ? 'font-semibold text-amber-400' : 'text-slate-400'}>{inr(totals[p.Partner_ID]?.interest ?? 0)}</Td>
                    {isMd && (
                      <Td>
                        <div className="flex gap-1.5">
                          <button className="btn-ghost !px-2.5 !py-1 text-xs" onClick={() => setForm({ mode: 'edit', partner: p })}><Pencil size={13} /> Edit</button>
                          <button className="btn-ghost !px-2.5 !py-1 text-xs text-rose-300" onClick={() => setConfirm(p)}><Trash2 size={13} /> Delete</button>
                        </div>
                      </Td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {form && (
        <PartnerForm
          mode={form.mode}
          partner={form.partner}
          finances={finances.map(f => f.Finance_Name)}
          onClose={() => setForm(null)}
          onSaved={() => { setForm(null); setTick(t => t + 1) }}
        />
      )}

      {confirm && (
        <Modal
          title="Delete partner"
          onClose={() => setConfirm(null)}
          footer={<>
            <button className="btn-ghost" onClick={() => setConfirm(null)}>Cancel</button>
            <button className="btn-primary !bg-rose-600 hover:!bg-rose-500" onClick={async () => { await deletePartner(confirm.Partner_ID); setConfirm(null); setTick(t => t + 1) }}>Delete</button>
          </>}
        >
          <p className="text-sm text-slate-300">Delete <b className="text-hd">{confirm.Partner_Name}</b> ({confirm.Partner_ID})?</p>
          <p className="mt-2 text-xs text-slate-500">This is recorded in the Log and can be restored from there.</p>
        </Modal>
      )}
    </div>
  )
}

function PartnerForm({ mode, partner, finances, onClose, onSaved }: {
  mode: 'new' | 'edit'; partner?: Partner; finances: string[]; onClose: () => void; onSaved: () => void
}) {
  const [name, setName] = useState(partner?.Partner_Name ?? '')
  const [phoneNo, setPhoneNo] = useState(String(partner?.Phone_Number ?? ''))
  const [email, setEmail] = useState(partner?.Email_Address ?? '')
  const [finance, setFinance] = useState(partner?.Finance_Name ?? finances[0] ?? '')
  const valid = name.trim() && phoneNo.trim() && finance

  function nextPartnerId(fin: string): string {
    const prefix = fin.slice(0, 3) || 'Fin'
    const max = repo.partners(fin).reduce((m, p) => {
      const n = Number(String(p.Partner_ID).replace(/\D/g, ''))
      return isNaN(n) ? m : Math.max(m, n)
    }, 0)
    return `${prefix}-P${max + 1}`
  }

  async function save() {
    if (mode === 'edit' && partner) {
      await updatePartner(partner.Partner_ID, {
        Partner_Name: name.trim(), Phone_Number: phoneNo.trim(),
        Email_Address: email || undefined, Finance_Name: finance,
      })
    } else {
      await addPartner({
        Partner_ID: nextPartnerId(finance), Finance_Name: finance,
        Partner_Name: name.trim(), Phone_Number: phoneNo.trim(), Email_Address: email || undefined,
      })
    }
    onSaved()
  }

  return (
    <Modal
      title={mode === 'edit' ? 'Edit partner' : 'New partner'}
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={onClose}>Cancel</button>
        <button className="btn-primary" disabled={!valid} onClick={save}>{mode === 'edit' ? 'Save changes' : 'Create partner'}</button>
      </>}
    >
      <Field label="Partner name"><input className="input" value={name} onChange={e => setName(e.target.value)} /></Field>
      <div className="grid grid-cols-2 gap-3">
        <Field label="Phone (their login)"><input className="input" inputMode="tel" value={phoneNo} onChange={e => setPhoneNo(e.target.value)} /></Field>
        <Field label="Finance">
          <select className="input" value={finance} onChange={e => setFinance(e.target.value)} disabled={mode === 'edit'}>
            {finances.map(f => <option key={f} value={f}>{f}</option>)}
          </select>
        </Field>
      </div>
      <Field label="Email"><input className="input" value={email} onChange={e => setEmail(e.target.value)} /></Field>
      {mode === 'new' && <p className="text-xs text-slate-500">They sign in with this phone and password <span className="font-semibold">1234</span>.</p>}
    </Modal>
  )
}
