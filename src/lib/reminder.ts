// Builds the pending-amount reminder text sent to a party over WhatsApp, e.g.
//
//   Mal-STL21-Mahesh Manmangalam
//   Total Interest Pending Rs 60,730,
//   Aug-2025 - Pending Rs 2,275
//   Sep-2025 - Pending Rs 5,250
//
// Used for customers, depositors, other-finance parties and chit members.
import { monthKey, monthName } from './format'

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
  const pending = o.items
    .filter(i => Math.round(i.pending) > 0)
    .sort((a, b) => monthKey(a.month) - monthKey(b.month))

  const monthLabel = (m?: string) => monthName(m).replace(' ', '-') // "Aug 2025" -> "Aug-2025"
  const lines = [o.header]
  if (pending.length === 0) {
    lines.push('No pending amount. Thank you.')
  } else {
    const total = pending.reduce((s, i) => s + i.pending, 0)
    lines.push(`${totalLabel} ${rs(total)},`)
    for (const i of pending) {
      lines.push(`${monthLabel(i.month)} - Pending ${rs(i.pending)}`)
    }
  }
  if (o.footer) lines.push('', o.footer)
  return lines.join('\n')
}

// ── Chit-member message ──────────────────────────────────────────────────────
// A chit member's WhatsApp update uses a fixed layout the finance prefers:
//
//   Chit Details:
//
//   Name : Gopal
//
//   Total Pending: Rs.10362.5
//   Month 6 - Pending Rs. 10362.5
//   Chit Status : Not_Taken
//   Chit Completed Month : 6
//
//
//   <payment note from Settings>
//
// The payment note (UPI / bank details) is configured once in Settings and
// appended to every member's message.
export interface ChitMemberMessageInput {
  name: string
  totalPending: number
  months: { month: number; pending: number }[]   // only months still pending
  status?: string                                 // raw Chit_Taken value
  completedMonth: number                          // months auctioned so far
  note?: string                                   // payment note from Settings
}

// Normalise the messy stored Chit_Taken values ("Yes"/"No"/"Taken"/true/…) to
// the two labels the message shows.
export function chitStatusLabel(v?: string | boolean): string {
  const s = String(v ?? '').trim().toLowerCase()
  return s === 'taken' || s === 'yes' || s === 'true' ? 'Taken' : 'Not_Taken'
}

// Amount without a currency symbol, decimals kept only when present
// (10362.5 -> "10362.5", 10000 -> "10000").
const amt = (n: number) => String(Math.round(Number(n) * 100) / 100)

export function buildChitMemberMessage(o: ChitMemberMessageInput): string {
  const lines = [
    'Chit Details:',
    '',
    `Name : ${o.name}`,
    '',
    `Total Pending: Rs.${amt(o.totalPending)}`,
  ]
  for (const m of o.months) lines.push(`Month ${m.month} - Pending Rs. ${amt(m.pending)}`)
  lines.push(`Chit Status : ${chitStatusLabel(o.status)}`)
  lines.push(`Chit Completed Month : ${o.completedMonth}`)
  const note = o.note?.trim()
  if (note) lines.push('', '', note)
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
