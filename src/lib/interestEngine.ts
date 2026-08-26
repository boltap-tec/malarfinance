// ── Interest posting engine ──────────────────────────────────────────────────
// Direct port of the Google Apps Script logic (splitLoanDetailsIntoRows_Arul_Fin)
// so the numbers match your existing system exactly:
//   • Per_Day  : days × ratePerLakhPerDay × amount / 100000
//   • Per_Month (full month) : amount × ratePerLakhPerMonth / 100000
//   • Per_Month (partial)    : prorated by actual days / total month days
//   • actualFromDate = max(fromDate, loanGivenDate)
//   • noOfDays = ceil((to - actualFrom)/day) + 1  (inclusive)
//   • final amount rounded to nearest ₹10

import type { Loan, InterestRow } from '../data/types'

const DAY = 1000 * 60 * 60 * 24

const days = (a: Date, b: Date) => Math.ceil((b.getTime() - a.getTime()) / DAY) + 1
export const roundTo10 = (v: number) => Math.round(v / 10) * 10

export interface InterestPreview {
  loan: Loan
  fromDate: string
  toDate: string
  actualFromDate: string
  noOfDays: number
  totalMonthDays: number
  rawInterest: number
  interest: number
  month: string
  description: string
}

export function computeInterest(
  loan: Loan,
  fromDate: string | Date,
  toDate: string | Date,
): InterestPreview {
  const from = new Date(fromDate)
  const to = new Date(toDate)
  const loanDate = loan.Loan_Given_Date ? new Date(loan.Loan_Given_Date) : from
  from.setHours(0, 0, 0, 0); to.setHours(0, 0, 0, 0); loanDate.setHours(0, 0, 0, 0)

  const actualFrom = from < loanDate ? loanDate : from
  const noOfDays = Math.max(0, days(actualFrom, to))
  const totalMonthDays = Math.max(1, days(from, to))

  const amount = Number(loan.Loan_Amount) || 0
  const perDay = Number(loan.Interest_Per_day_Per_Lakh) || 0
  const perMonth = Number(loan.Interest_Per_Month_Per_Lakh) || 0
  const type = loan.Interest_Type || 'Per_Day'

  let raw = 0
  if (type === 'Per_Day') {
    raw = (noOfDays * perDay * amount) / 100000
  } else if (type === 'Per_Month') {
    raw = totalMonthDays === noOfDays
      ? (amount * perMonth) / 100000
      : (noOfDays * ((amount * perMonth) / 100000)) / totalMonthDays
  }

  const month = `${String(to.getMonth() + 1).padStart(2, '0')}-${to.getFullYear()}`
  // Friendly single-month label, e.g. "Interest Jul 2026" (the exact period shows
  // separately as From – To in the interest tables).
  const description = `Interest ${to.toLocaleString('en-US', { month: 'short' })} ${to.getFullYear()}`

  return {
    loan,
    fromDate: from.toISOString().slice(0, 10),
    toDate: to.toISOString().slice(0, 10),
    actualFromDate: actualFrom.toISOString().slice(0, 10),
    noOfDays,
    totalMonthDays,
    rawInterest: raw,
    interest: roundTo10(raw),
    month,
    description,
  }
}

// Build interest rows for every ACTIVE loan for a given billing window — the
// server-side "posting" run, previewable before it commits.
export function previewPosting(
  loans: Loan[],
  fromDate: string,
  toDate: string,
  isPosted?: (loanNo: string, month: string) => boolean,
): InterestPreview[] {
  return loans
    .filter(l => (l.Loan_Status ?? '').toLowerCase() === 'active')
    .filter(l => !l.Loan_Given_Date || new Date(l.Loan_Given_Date) <= new Date(toDate))
    .map(l => computeInterest(l, fromDate, toDate))
    .filter(p => p.interest > 0)
    // Skip loans already billed for this month (no double-posting a period).
    .filter(p => !isPosted || !isPosted(p.loan.Loan_No, p.month))
}

// ── Interest on a repayment ──────────────────────────────────────────────────
// One outstanding debt line (a customer loan, a deposit, or an other-finance
// borrowing) with everything needed to price interest on a repaid slice of it.
export interface DebtLine {
  key: string
  outstanding: number
  type?: string          // 'Per_Day' | 'Per_Month'
  perDay?: number
  perMonth?: number
  lastTo?: string        // last interest To_Date already charged, if any
  givenDate?: string     // loan/deposit start date
}

export interface RepayAccrual {
  key: string
  base: number           // the repaid slice this interest is charged on
  from: string
  to: string
  amount: number
  month: string
}

const dayAfter = (d: string) => { const x = new Date(d); x.setDate(x.getDate() + 1); return x.toISOString().slice(0, 10) }

// Allocate `principal` across `lines` (caller passes them oldest-first) and
// charge interest ONLY on each repaid slice, from the day after that line's last
// interest date up to `calcTo`. Returns one accrual per line plus the total.
// This matches the rule: repay ₹X → interest on ₹X for the unbilled days.
export function accrueOnRepaidPrincipal(lines: DebtLine[], principal: number, calcTo: string): { accruals: RepayAccrual[]; total: number } {
  const accruals: RepayAccrual[] = []
  let left = Math.max(0, principal)
  for (const l of lines) {
    if (left <= 0) break
    const out = Math.max(0, l.outstanding)
    if (out <= 0) continue
    const slice = Math.min(out, left)
    left -= slice
    const from = l.lastTo ? dayAfter(l.lastTo) : (l.givenDate ?? calcTo)
    if (new Date(from) > new Date(calcTo)) continue
    const pr = computeInterest({
      Loan_Amount: slice,
      Interest_Type: l.type,
      Interest_Per_day_Per_Lakh: l.perDay,
      Interest_Per_Month_Per_Lakh: l.perMonth,
      Loan_Given_Date: l.givenDate,
    } as Loan, from, calcTo)
    if (pr.interest <= 0) continue
    accruals.push({ key: l.key, base: slice, from: pr.actualFromDate, to: pr.toDate, amount: pr.interest, month: pr.month })
  }
  return { accruals, total: accruals.reduce((s, a) => s + a.amount, 0) }
}

// Last day of the month for a yyyy-mm-dd date — used to gate posting to month end.
export function isMonthEnd(dateStr: string): boolean {
  const d = new Date(dateStr)
  if (isNaN(d.getTime())) return false
  const next = new Date(d.getFullYear(), d.getMonth(), d.getDate() + 1)
  return next.getMonth() !== d.getMonth()
}

export function toInterestRow(p: InterestPreview): InterestRow {
  const l = p.loan
  return {
    ID: `${l.Customer_Name}-${l.Customer_STL_NO}-${l.Loan_No}-${l.Loan_Amount}-${p.description}`,
    Finance_Name: l.Finance_Name,
    Loan_No: l.Loan_No,
    Customer_STL_NO: l.Customer_STL_NO,
    Customer_Name: l.Customer_Name,
    From_Date: p.fromDate,
    To_Date: p.toDate,
    No_Days: p.noOfDays,
    Interest_Amount: p.interest,
    Loan_Amount: Number(l.Loan_Amount) || 0,
    Month: p.month,
    Description: p.description,
    Amount_Received: 0,
    Status: 'Pending',
    Interest_Pending: p.interest,
    Referred_Partner: l.Referred_Partner,
    Interest_Type: l.Interest_Type,
  }
}
