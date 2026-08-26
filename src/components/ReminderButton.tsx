import { useState } from 'react'
import { MessageCircle, Copy, Check } from 'lucide-react'
import { Modal } from './ui'
import { buildReminder, waLink, waPhone, type ReminderItem } from '../lib/reminder'

// A "Send reminder on WhatsApp" button. Opens a preview modal with the composed
// pending-amount message (editable) — the user reviews, then taps to open
// WhatsApp (they still send it themselves) or copies the text.
export default function ReminderButton({
  header, phone, items, totalLabel, amountWord, footer,
  label = 'WhatsApp', className,
}: {
  header: string
  phone?: number | string
  items: ReminderItem[]
  totalLabel?: string
  amountWord?: string
  footer?: string
  label?: string
  className?: string
}) {
  const [open, setOpen] = useState(false)
  return (
    <>
      <button
        className={className ?? 'btn-ghost !py-1.5 text-emerald-300 ring-1 ring-inset ring-emerald-500/30'}
        onClick={() => setOpen(true)}
        title="Send a pending-amount reminder on WhatsApp"
      >
        <MessageCircle size={15} /> {label}
      </button>
      {open && (
        <ReminderModal
          initial={buildReminder({ header, items, totalLabel, amountWord, footer })}
          phone={phone}
          onClose={() => setOpen(false)}
        />
      )}
    </>
  )
}

function ReminderModal({ initial, phone, onClose }: { initial: string; phone?: number | string; onClose: () => void }) {
  const [text, setText] = useState(initial)
  const [copied, setCopied] = useState(false)
  const link = waLink(phone, text)

  async function copy() {
    try {
      await navigator.clipboard.writeText(text)
      setCopied(true)
      setTimeout(() => setCopied(false), 1500)
    } catch { /* clipboard blocked — user can select manually */ }
  }

  return (
    <Modal
      title="WhatsApp reminder"
      onClose={onClose}
      footer={<>
        <button className="btn-ghost" onClick={copy}>{copied ? <><Check size={15} /> Copied</> : <><Copy size={15} /> Copy</>}</button>
        {link
          ? <a className="btn-primary !bg-emerald-600 hover:!bg-emerald-500" href={link} target="_blank" rel="noopener noreferrer" onClick={onClose}><MessageCircle size={15} /> Open WhatsApp</a>
          : <button className="btn-primary" disabled title="No phone number on file">No phone number</button>}
      </>}
    >
      <p className="text-xs text-slate-500">Review or edit the message, then open WhatsApp — you send it yourself.{!waPhone(phone) && ' No phone number is saved for this party, so copy the text and send it manually.'}</p>
      <textarea
        className="input min-h-[160px] font-mono text-sm leading-relaxed"
        value={text}
        onChange={e => setText(e.target.value)}
      />
    </Modal>
  )
}
