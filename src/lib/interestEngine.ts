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

  // Guard against an invalid/empty date (e.g. a half-typed date field): return a
  // zero preview instead of throwing on toISOString() — which would white-screen
  // the whole app the moment a repay date is being edited.
  if (isNaN(from.getTime()) || isNaN(to.getTime())) {
    const safe = (d: Date) => isNaN(d.getTime()) ? '' : d.toISOString().slice(0, 10)
    return {
      loan, fromDate: safe(from), toDate: safe(to), actualFromDate: safe(from),
      noOfDays: 0, totalMonthDays: 1, rawInterest: 0, interest: 0, month: '', description: '',
    }
  }

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

// Round to ₹10 at the GROUP level, not per row: sum each group's raw interest,
// round that sum to ₹10, then hand each row its ₹1-rounded raw with the leftover
// put on the group's biggest row — so rows still sum exactly to the ₹10 total.
// Used so a customer/depositor/lender with several loans is rounded once overall.
export function distributeRounding<T>(items: T[], rawOf: (t: T) => number, keyOf: (t: T) => string): Map<T, number> {
  const groups = new Map<string, T[]>()
  for (const it of items) {
    const k = keyOf(it)
    if (!groups.has(k)) groups.set(k, [])
    groups.get(k)!.push(it)
  }
  const out = new Map<T, number>()
  for (const arr of groups.values()) {
    const target = roundTo10(arr.reduce((s, it) => s + rawOf(it), 0))
    const assigned = arr.map(it => Math.round(rawOf(it)))
    const diff = target - assigned.reduce((s, a) => s + a, 0)
    if (arr.length && diff !== 0) {
      let mi = 0
      for (let i = 1; i < arr.length; i++) if (rawOf(arr[i]) > rawOf(arr[mi])) mi = i
      assigned[mi] += diff
    }
    arr.forEach((it, i) => out.set(it, Math.max(0, assigned[i])))
  }
  return out
}

// The date a monthly posting should RESUME interest from: the day after the
// item's stored "posted till" date, but never before the item itself existed
// (its given date). Returns the effective given-date to hand to computeInterest,
// which then floors the accrual at max(monthStart, thisDate). This is the rule
//   start = max(givenDate, postedTill + 1)
// — the same one repayment uses (see accrueOnRepaidPrincipal).
export function resumeFrom(givenDate?: string, postedTill?: string): string | undefined {
  if (!postedTill) return givenDate
  const resume = dayAfter(postedTill)
  if (!givenDate) return resume
  return new Date(resume) > new Date(givenDate) ? resume : givenDate
}

// Build interest rows for every ACTIVE loan for a given billing window — the
// server-side "posting" run, previewable before it commits. `fromDate`/`toDate`
// are the calendar-month window (from = the per-month proration denominator);
// each loan's accrual instead starts from its own posted-till via `postedUptoOf`,
// so an already-billed period can't be posted twice and a new/partly-billed loan
// bills only the days it owes.
export function previewPosting(
  loans: Loan[],
  fromDate: string,
  toDate: string,
  postedUptoOf?: (loan: Loan) => string | undefined,
): InterestPreview[] {
  return loans
    .filter(l => (l.Loan_Status ?? '').toLowerCase() === 'active')
    .filter(l => !l.Loan_Given_Date || new Date(l.Loan_Given_Date) <= new Date(toDate))
    .map(l => computeInterest(
      { ...l, Loan_Given_Date: resumeFrom(l.Loan_Given_Date, postedUptoOf?.(l)) },
      fromDate, toDate,
    ))
    .filter(p => p.interest > 0)
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
    // Start billing the day after the last interest (or the Settings cut-over
    // date when none). But never before the loan/deposit existed: if it was
    // given AFTER that fallback date, bill from its own given date instead.
    let from = l.lastTo ? dayAfter(l.lastTo) : (l.givenDate ?? calcTo)
    if (l.givenDate && new Date(l.givenDate) > new Date(from)) from = l.givenDate
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
