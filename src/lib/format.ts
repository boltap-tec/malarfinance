export const inr = (n: number | undefined | null): string => {
  const v = Number(n ?? 0)
  return '₹' + v.toLocaleString('en-IN', { maximumFractionDigits: 0 })
}

export const inrShort = (n: number | undefined | null): string => {
  const v = Number(n ?? 0)
  if (Math.abs(v) >= 1e7) return '₹' + (v / 1e7).toFixed(2) + ' Cr'
  if (Math.abs(v) >= 1e5) return '₹' + (v / 1e5).toFixed(2) + ' L'
  if (Math.abs(v) >= 1e3) return '₹' + (v / 1e3).toFixed(1) + 'K'
  return '₹' + v.toFixed(0)
}

export const fmtDate = (d?: string | Date | null): string => {
  if (!d) return '—'
  const dt = typeof d === 'string' ? new Date(d) : d
  if (isNaN(dt.getTime())) return String(d)
  return dt.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
}

export const num = (v: unknown): number => {
  const n = Number(v)
  return isNaN(n) ? 0 : n
}

// The later of two dates (yyyy-mm-dd or ISO), ignoring blanks. Used to pick the
// interest "posted up to" reference from several sources.
export const laterDate = (a?: string | null, b?: string | null): string | undefined => {
  if (!a) return b || undefined
  if (!b) return a || undefined
  return new Date(a).getTime() >= new Date(b).getTime() ? a : b
}

// Amount spelled out in the Indian system, e.g. 150000 -> "One Lakh Fifty
// Thousand", 6073050 -> "Sixty Lakh Seventy Three Thousand Fifty".
export const amountWords = (v: number | string | undefined | null): string => {
  let n = Math.round(Number(v ?? 0))
  if (!n || isNaN(n)) return ''
  if (n < 0) return 'Minus ' + amountWords(-n)
  const ones = ['', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten',
    'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen']
  const tens = ['', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety']
  const two = (x: number): string => x < 20 ? ones[x] : (tens[Math.floor(x / 10)] + (x % 10 ? ' ' + ones[x % 10] : ''))
  const three = (x: number): string => {
    const h = Math.floor(x / 100), r = x % 100
    return (h ? ones[h] + ' Hundred' + (r ? ' ' : '') : '') + (r ? two(r) : '')
  }
  const parts: string[] = []
  const crore = Math.floor(n / 10000000); n %= 10000000
  const lakh = Math.floor(n / 100000); n %= 100000
  const thousand = Math.floor(n / 1000); n %= 1000
  if (crore) parts.push(three(crore) + ' Crore')
  if (lakh) parts.push(two(lakh) + ' Lakh')
  if (thousand) parts.push(two(thousand) + ' Thousand')
  if (n) parts.push(three(n))
  return parts.join(' ').trim()
}

// Friendly label from a "MM-YYYY" month (e.g. "07-2026" -> "Jul 2026").
export const monthName = (m?: string): string => {
  const [mm, yy] = String(m ?? '').split('-')
  const names = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  const i = Number(mm)
  return i >= 1 && i <= 12 && yy ? `${names[i]} ${yy}` : String(m ?? '—')
}

// "MM-YYYY" label from a date (e.g. a 2026-07-12 auction date -> "07-2026").
export const mmYyyy = (d?: string | Date | null): string | undefined => {
  if (!d) return undefined
  const dt = typeof d === 'string' ? new Date(d) : d
  if (isNaN(dt.getTime())) return undefined
  return `${String(dt.getMonth() + 1).padStart(2, '0')}-${dt.getFullYear()}`
}

// Sortable key from a "MM-YYYY" month label (e.g. "08-2025" -> 202508).
export const monthKey = (m: unknown): number => {
  const [mm, yy] = String(m ?? '').split('-')
  const y = Number(yy), mo = Number(mm)
  return (isNaN(y) ? 0 : y) * 100 + (isNaN(mo) ? 0 : mo)
}

export const phone = (p?: number | string): string => {
  if (!p) return '—'
  return String(p).replace(/\.0$/, '')
}

// True when a status column reads "active" — used to group lists so live rows
// sort ahead of closed/settled ones.
export const isActive = (status?: string): boolean => (status ?? '').trim().toLowerCase() === 'active'

// Status derived purely from the outstanding balance: anything still owed is
// "Active", a zero (or nil) balance is "Inactive". Used for Customers, Depositors
// and Other-Finance loans so the badge always matches reality.
export const balanceStatus = (outstanding: number | undefined | null): 'Active' | 'Inactive' =>
  num(outstanding) > 0 ? 'Active' : 'Inactive'
