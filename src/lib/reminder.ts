// Builds the pending-amount reminder text sent to a party over WhatsApp, e.g.
//
//   Mal-STL22-Pradeep
//   Total Interest Pending Rs 5,425,
//   07-2026 - Int_Amount Rs 5,425 - Pending Rs 5,425
//
// Used for customers, depositors, other-finance parties and chit members.
import { monthKey } from './format'

export interface ReminderItem {
  month?: string   // label for the period, usually "MM-YYYY"
  amount: number   // the billed amount that month (interest / due)
  pending: number  // still-pending part of it
}

const rs = (n: number) => 'Rs ' + Math.round(n).toLocaleString('en-IN')

export function buildReminder(o: {
  header: string
  items: ReminderItem[]
  totalLabel?: string   // e.g. "Total Interest Pending"
  amountWord?: string   // e.g. "Int_Amount" or "Due"
  footer?: string
}): string {
  const totalLabel = o.totalLabel ?? 'Total Interest Pending'
  const amountWord = o.amountWord ?? 'Int_Amount'
  const pending = o.items
    .filter(i => Math.round(i.pending) > 0)
    .sort((a, b) => monthKey(a.month) - monthKey(b.month))

  const lines = [o.header]
  if (pending.length === 0) {
    lines.push('No pending amount. Thank you.')
  } else {
    const total = pending.reduce((s, i) => s + i.pending, 0)
    lines.push(`${totalLabel} ${rs(total)},`)
    for (const i of pending) {
      lines.push(`${i.month ?? '—'} - ${amountWord} ${rs(i.amount)} - Pending ${rs(i.pending)}`)
    }
  }
  if (o.footer) lines.push('', o.footer)
  return lines.join('\n')
}

// Normalise a stored phone to a wa.me number (adds India country code for
// bare 10-digit numbers). Returns null when there's nothing usable.
export function waPhone(p?: number | string): string | null {
  const digits = String(p ?? '').replace(/\D/g, '')
  if (!digits) return null
  if (digits.length === 10) return '91' + digits
  if (digits.length === 11 && digits.startsWith('0')) return '91' + digits.slice(1)
  return digits
}

export function waLink(p: number | string | undefined, text: string): string | null {
  const ph = waPhone(p)
  return ph ? `https://wa.me/${ph}?text=${encodeURIComponent(text)}` : null
}
