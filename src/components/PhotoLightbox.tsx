import { useEffect } from 'react'
import { createPortal } from 'react-dom'
import { X, ChevronLeft, ChevronRight } from 'lucide-react'
import type { JewelPhoto } from '../data/types'

// Full-screen photo viewer with prev / next and keyboard arrows. Shared by the
// jewel loan list, the close dialog and the loan detail page.
export default function PhotoLightbox({ photos, index, onClose, onIndex }: {
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
  if (!p) return null
  const overlay = (
    <div className="fixed inset-0 z-[90] flex flex-col bg-black/90" onClick={onClose}>
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
