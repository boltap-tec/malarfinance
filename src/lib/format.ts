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
