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

export const phone = (p?: number | string): string => {
  if (!p) return '—'
  return String(p).replace(/\.0$/, '')
}
