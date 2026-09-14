import { useEffect, useMemo, useRef, useState } from 'react'
import { Link, useParams, useNavigate } from 'react-router-dom'
import { createPortal } from 'react-dom'
import {
  ArrowLeft, Pencil, Trash2, ImagePlus, X, ChevronLeft, ChevronRight, Camera, CheckCircle2, RotateCcw,
} from 'lucide-react'
import {
  repo, fetchJewelPhotos, addJewelPhotos, deleteJewelPhoto, deleteJewelLoan, updateJewelLoan,
} from '../data/repository'
import { useApp, canEdit } from '../store/app'
import { PageHeader, Card, StatCard, Badge, statusTone, EmptyState, ConfirmModal, Modal, Field } from '../components/ui'
import { inr, fmtDate, num } from '../lib/format'
import { shrinkImages } from '../lib/image'
import { JewelForm, DueCell, accruedInterest } from './Jewel'
import type { JewelPhoto } from '../data/types'

export default function JewelDetail() {
  const { loanNo = '' } = useParams()
  const id = decodeURIComponent(loanNo)
  const role = useApp(s => s.user?.role)
  const finance = useApp(s => s.finance)
  const navigate = useNavigate()
  const editable = canEdit(role) && finance !== 'ALL'
  const isMd = role === 'md' && finance !== 'ALL'

  const [tick, setTick] = useState(0)
  const [photos, setPhotos] = useState<JewelPhoto[] | null>(null)
  const [busy, setBusy] = useState('')
  const [edit, setEdit] = useState(false)
  const [del, setDel] = useState(false)
  const [delPhoto, setDelPhoto] = useState<JewelPhoto | null>(null)
  const [confirmClose, setConfirmClose] = useState(false)
  const [closeInterest, setCloseInterest] = useState('')
  const [closeDate, setCloseDate] = useState(new Date().toISOString().slice(0, 10))
  const [lightbox, setLightbox] = useState<number | null>(null)
  const fileRef = useRef<HTMLInputElement>(null)

  const loan = useMemo(() => repo.jewelLoan(id), [id, tick])

  // Load this loan's photos on demand (they're not part of the startup pull).
  useEffect(() => {
    let alive = true
    setPhotos(null)
    fetchJewelPhotos(id).then(p => { if (alive) setPhotos(p) })
    return () => { alive = false }
  }, [id, tick])

  if (!loan) return (
    <div>
      <Link to="/jewel" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Jewel Loans</Link>
      <EmptyState title="Jewel loan not found" />
    </div>
  )

  const closed = (loan.Loan_Status ?? 'Active') === 'Closed'

  async function onPick(e: React.ChangeEvent<HTMLInputElement>) {
    const files = Array.from(e.target.files ?? [])
    e.target.value = ''
    if (!files.length) return
    setBusy(`Processing 0 / ${files.length}…`)
    const urls = await shrinkImages(files, (d, t) => setBusy(`Processing ${d} / ${t}…`))
    setBusy('Saving…')
    const next = await addJewelPhotos(id, loan!.Finance_Name, urls)
    setPhotos(next)
    setBusy('')
    setTick(t => t + 1) // refresh the cached photo count
  }

  const list = photos ?? []

  return (
    <div>
      <Link to="/jewel" className="mb-4 inline-flex items-center gap-1 text-sm text-slate-400 hover:text-slate-200"><ArrowLeft size={16} /> Jewel Loans</Link>
      <PageHeader
        title={loan.Loan_Taken_From || 'Jewel loan'}
        subtitle={`${loan.Loan_No} · ${loan.Finance_Name}`}
        action={
          <div className="flex flex-wrap items-center gap-2">
            <Badge tone={statusTone(loan.Loan_Status)}>{loan.Loan_Status ?? 'Open'}</Badge>
            {editable && <button className="btn-ghost !py-1.5" onClick={() => setEdit(true)}><Pencil size={15} /> Edit</button>}
            {editable && (closed
              ? <button className="btn-ghost !py-1.5 text-amber-300" onClick={async () => { await updateJewelLoan(id, { Loan_Closed_Date: undefined }); setTick(t => t + 1) }}><RotateCcw size={15} /> Reopen</button>
              : <button className="btn-ghost !py-1.5 text-emerald-300" onClick={() => { setCloseInterest(String(accruedInterest(loan) || '')); setCloseDate(new Date().toISOString().slice(0, 10)); setConfirmClose(true) }}><CheckCircle2 size={15} /> Close</button>)}
            {isMd && <button className="btn-ghost !py-1.5 text-rose-300" onClick={() => setDel(true)}><Trash2 size={15} /> Delete</button>}
          </div>
        }
      />

      <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
        <StatCard label="Loan amount" value={inr(num(loan.Loan_Amount))} tone="amber" />
        <StatCard label="Gold pledged" value={num(loan.Loan_Total_grams) ? `${num(loan.Loan_Total_grams)} g` : '—'} tone="slate" />
        <StatCard label="Interest / month" value={num(loan.Interest_Amount) ? inr(num(loan.Interest_Amount)) : '—'} sub={num(loan.Interest_Rate) ? `₹${num(loan.Interest_Rate)} / lakh` : undefined} tone="slate" />
        <StatCard label="Photos" value={list.length} tone="blue" icon={<Camera size={18} />} />
      </div>

      <Card className="mb-4">
        <h3 className="mb-3 text-sm font-semibold text-hd">Details</h3>
        <dl className="grid grid-cols-2 gap-x-4 gap-y-3 text-sm sm:grid-cols-3">
          <Detail label="Taken from" value={loan.Loan_Taken_From} />
          <Detail label="Taken by" value={loan.Loan_Taken_By} />
          <Detail label="Taken date" value={fmtDate(loan.Loan_Taken_Date)} />
          <Detail label="Rate" value={num(loan.Interest_Rate) ? `₹${num(loan.Interest_Rate)} / lakh · mo` : undefined} />
          <div>
            <dt className="label">Settle by (period)</dt>
            <dd className="mt-0.5"><DueCell loan={loan} /></dd>
          </div>
          <div>
            <dt className="label">{closed ? 'Interest paid' : 'Interest so far'}</dt>
            <dd className="mt-0.5 text-amber-300">{closed ? (num(loan.Total_Interest_Paid) ? inr(num(loan.Total_Interest_Paid)) : '—') : inr(accruedInterest(loan))}</dd>
          </div>
          <Detail label="Closed date" value={loan.Loan_Closed_Date ? fmtDate(loan.Loan_Closed_Date) : undefined} />
          <Detail label="Remark" value={loan.Remark1} />
        </dl>
        {loan.Particular_Description && (
          <div className="mt-3 border-t border-slate-800 pt-3">
            <p className="label">Item particulars</p>
            <p className="mt-1 whitespace-pre-wrap text-sm text-slate-200">{loan.Particular_Description}</p>
          </div>
        )}
      </Card>

      <Card>
        <div className="mb-3 flex items-center justify-between">
          <h3 className="text-sm font-semibold text-hd">Jewel photos {list.length > 0 && <span className="text-slate-500">· {list.length}</span>}</h3>
          {editable && (
            <button className="btn-ghost !py-1.5 text-brand-300 ring-1 ring-inset ring-brand-500/30" onClick={() => fileRef.current?.click()}>
              <ImagePlus size={15} /> Add photos
            </button>
          )}
        </div>
        <input ref={fileRef} type="file" accept="image/*" multiple hidden onChange={onPick} />
        {busy && <p className="mb-3 text-xs text-amber-300">{busy}</p>}

        {photos === null ? (
          <p className="py-8 text-center text-sm text-slate-500">Loading photos…</p>
        ) : list.length === 0 ? (
          <div className="grid place-items-center gap-2 py-10 text-center">
            <Camera size={28} className="text-slate-600" />
            <p className="text-sm text-slate-400">No photos yet.</p>
            {editable && <p className="text-xs text-slate-500">Tap “Add photos” to attach pictures of the pledged jewels.</p>}
          </div>
        ) : (
          <div className="grid grid-cols-3 gap-2 sm:grid-cols-4 md:grid-cols-5">
            {list.map((p, i) => (
              <div key={p.id} className="group relative aspect-square overflow-hidden rounded-xl ring-1 ring-slate-700">
                <button type="button" className="h-full w-full" onClick={() => setLightbox(i)}>
                  <img src={p.Data} alt={p.Caption || `Jewel ${i + 1}`} loading="lazy" className="h-full w-full object-cover transition group-hover:scale-105" />
                </button>
                {editable && (
                  <button type="button" title="Remove photo" onClick={() => setDelPhoto(p)}
                    className="absolute right-1.5 top-1.5 grid h-7 w-7 place-items-center rounded-full bg-black/60 text-white opacity-0 transition group-hover:opacity-100">
                    <Trash2 size={14} />
                  </button>
                )}
              </div>
            ))}
          </div>
        )}
      </Card>

      {lightbox !== null && list[lightbox] && (
        <Lightbox
          photos={list} index={lightbox}
          onClose={() => setLightbox(null)}
          onIndex={setLightbox}
        />
      )}

      {edit && loan && (
        <JewelForm finance={loan.Finance_Name} initial={loan} onClose={() => setEdit(false)} onSaved={() => { setEdit(false); setTick(t => t + 1) }} />
      )}
      {confirmClose && (
        <Modal
          title={`Close ${loan.Loan_No}`}
          onClose={() => setConfirmClose(false)}
          footer={<>
            <button className="btn-ghost" onClick={() => setConfirmClose(false)}>Cancel</button>
            <button className="btn-primary" onClick={async () => {
              await updateJewelLoan(id, { Loan_Closed_Date: closeDate || new Date().toISOString().slice(0, 10), Total_Interest_Paid: closeInterest ? num(closeInterest) : undefined })
              setConfirmClose(false); setTick(t => t + 1)
            }}>Mark closed</button>
          </>}
        >
          <p className="text-sm text-slate-400">Interest accrued so far is about <b className="text-amber-300">{inr(accruedInterest(loan))}</b> — enter the total interest you actually paid.</p>
          <Field label="Total interest paid (₹)">
            <input className="input" inputMode="numeric" autoFocus value={closeInterest} onChange={e => setCloseInterest(e.target.value.replace(/[^\d.]/g, ''))} />
          </Field>
          <Field label="Closed date">
            <input type="date" className="input" value={closeDate} onChange={e => setCloseDate(e.target.value)} />
          </Field>
        </Modal>
      )}
      {delPhoto && (
        <ConfirmModal
          title="Remove photo" confirmLabel="Remove"
          message="Remove this photo from the loan?"
          onConfirm={async () => { await deleteJewelPhoto(delPhoto.id, id); setPhotos(repo.jewelPhotos(id)); setDelPhoto(null); setTick(t => t + 1) }}
          onClose={() => setDelPhoto(null)}
        />
      )}
      {del && (
        <ConfirmModal
          title="Delete jewel loan"
          message={<>Delete <b className="text-hd">{loan.Loan_No}</b> and its {list.length} photo(s)?</>}
          onConfirm={async () => { await deleteJewelLoan(id); navigate('/jewel') }}
          onClose={() => setDel(false)}
        />
      )}
    </div>
  )
}

function Detail({ label, value }: { label: string; value?: string | null }) {
  return (
    <div>
      <dt className="label">{label}</dt>
      <dd className="mt-0.5 text-slate-200">{value || '—'}</dd>
    </div>
  )
}

// Full-screen photo viewer with prev / next and keyboard arrows.
function Lightbox({ photos, index, onClose, onIndex }: {
  photos: JewelPhoto[]; index: number; onClose: () => void; onIndex: (i: number) => void
}) {
  const go = (d: number) => onIndex((index + d + photos.length) % photos.length)
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose()
      else if (e.key === 'ArrowLeft') go(-1)
      else if (e.key === 'ArrowRight') go(1)
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  })
  const p = photos[index]
  const overlay = (
    <div className="fixed inset-0 z-[80] flex flex-col bg-black/90" onClick={onClose}>
      <div className="flex items-center justify-between p-3 text-sm text-slate-300" onClick={e => e.stopPropagation()}>
        <span>{index + 1} / {photos.length}</span>
        <button onClick={onClose} className="grid h-9 w-9 place-items-center rounded-full bg-white/10 text-white hover:bg-white/20"><X size={18} /></button>
      </div>
      <div className="relative flex flex-1 items-center justify-center overflow-hidden px-2 pb-4" onClick={e => e.stopPropagation()}>
        {photos.length > 1 && (
          <button onClick={() => go(-1)} className="absolute left-2 grid h-11 w-11 place-items-center rounded-full bg-white/10 text-white hover:bg-white/20"><ChevronLeft size={22} /></button>
        )}
        <img src={p.Data} alt={p.Caption || ''} className="max-h-full max-w-full rounded-lg object-contain" />
        {photos.length > 1 && (
          <button onClick={() => go(1)} className="absolute right-2 grid h-11 w-11 place-items-center rounded-full bg-white/10 text-white hover:bg-white/20"><ChevronRight size={22} /></button>
        )}
      </div>
    </div>
  )
  return typeof document !== 'undefined' ? createPortal(overlay, document.body) : overlay
}
