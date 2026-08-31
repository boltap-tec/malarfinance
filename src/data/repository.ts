// ── Data access layer ────────────────────────────────────────────────────────
// Today it reads the seeded snapshot of your real sheets from seed.json and keeps
// working changes in memory (persisted to localStorage). This is the ONLY file
// that knows *where* data comes from — when you move to Supabase, you reimplement
// these same functions with supabase-js and nothing else in the app changes.

import seed from './seed.json'
import { supabase, isSupabaseConfigured } from './supabase'
import type {
  Dataset, Loan, Customer, InterestRow, LedgerRow, Partner, Finance, Deposit,
  OtherFinanceLoan, Worker, AppNotification, LogEntry, Message,
  ChitCreation, ChitMember, ChitAuction, ChitTakenMember, ChitLedgerRow,
  InvestedChit, InvestedChitTrans, HandExchange, PostingLog,
} from './types'

const STORAGE_KEY = 'arul-finance:data:v1'

function fromSeed(): Dataset {
  return structuredClone(seed) as unknown as Dataset
}

function load(): Dataset {
  // In Supabase mode we always start from a fresh pull, so ignore any local snapshot.
  if (!isSupabaseConfigured) {
    const saved = localStorage.getItem(STORAGE_KEY)
    if (saved) {
      try { return JSON.parse(saved) } catch { /* fall through */ }
    }
  }
  return fromSeed()
}

let db: Dataset = load()

// Tells the UI where the data came from, so we can show a badge / banner.
export const source = { mode: (isSupabaseConfigured ? 'supabase' : 'local') as 'supabase' | 'local', live: false }

// ── Row-level view scoping ───────────────────────────────────────────────────
// A partner may only see rows tied to loans they referred. The store sets the
// current viewer at login; readers below narrow their output accordingly.
export interface Viewer { role: 'md' | 'partner' | 'worker'; partnerId?: string; finance?: string; name?: string }
let viewer: Viewer | null = null
export function setViewer(v: Viewer | null) { viewer = v }
const actor = () => viewer?.name || viewer?.role || 'system'

// ── Audit log ────────────────────────────────────────────────────────────────
function writeLog(e: Omit<LogEntry, 'id' | 'Date' | 'User'>): void {
  const entry: LogEntry = {
    id: `L-${Date.now()}-${Math.random().toString(36).slice(2, 6)}`,
    Date: new Date().toISOString(),
    User: actor(),
    ...e,
  }
  db.Log = [entry, ...(db.Log ?? [])]
  void sInsert('Log', entry)
}

function partnerLoanNos(): Set<string> {
  const pid = viewer?.partnerId
  return new Set((db.Loan_Processing ?? []).filter(l => l.Referred_Partner === pid).map(l => l.Loan_No))
}

function persist() {
  if (isSupabaseConfigured) return // don't cache Supabase data locally
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(db)) } catch { /* quota */ }
}

export function resetToSeed() {
  db = fromSeed()
  persist()
}

// A full snapshot of every table as pretty JSON — used by the in-app
// "Download backup" button. (The daily Google Drive backup is a separate
// Apps Script; see scripts/GoogleDriveBackup.gs.)
export function datasetSnapshot(): string {
  return JSON.stringify(db, null, 2)
}

// Pull every table from Supabase into memory once at startup. If a table is
// missing or the request fails, that table keeps its seeded values — so the app
// works both before and after migrate.sql has been run.
export async function hydrate(): Promise<void> {
  const client = supabase
  if (!client) return
  const tables = Object.keys(seed) as (keyof Dataset)[]
  const results = await Promise.all(
    tables.map(async (t) => {
      const { data, error } = await client.from(t as string).select('*').limit(5000)
      // error => table not migrated yet; keep the seeded rows for it
      return error || !data ? null : { t, data }
    }),
  )
  let anyLive = false
  for (const r of results) {
    if (!r) continue
    ;(db as any)[r.t] = r.data
    anyLive = true
  }
  source.live = anyLive
}

// A finance's interest cut-over: the fallback posted-till for that finance's
// entities that have none of their own. Read per-finance from Finance_Details so
// each finance posts independently; falls back to the legacy global setting only
// while a finance hasn't set its own date, so nothing breaks pre-migration.
function financeCutoverOf(finance?: string): string | undefined {
  const f = (db.Finance_Details ?? []).find(x => x.Finance_Name === finance)
  return f?.Interest_Posted_Upto || (getSettings().lastPostedDate || undefined)
}

// ── Read helpers ─────────────────────────────────────────────────────────────
export const repo = {
  finances(): Finance[] { return db.Finance_Details ?? [] },
  partners(finance?: string): Partner[] {
    return (db.Partner ?? []).filter(p => !finance || p.Finance_Name === finance)
  },
  customers(finance?: string): Customer[] {
    let list = (db.STL_CRM ?? []).filter(c => !finance || c.Finance_Name === finance)
    if (viewer?.role === 'partner') {
      const stls = new Set((db.Loan_Processing ?? []).filter(l => l.Referred_Partner === viewer!.partnerId).map(l => l.Customer_STL_NO))
      list = list.filter(c => stls.has(c.Customer_STL_NO))
    }
    return list
  },
  customer(stl: string): Customer | undefined {
    return (db.STL_CRM ?? []).find(c => c.Customer_STL_NO === stl)
  },
  loans(finance?: string): Loan[] {
    let list = (db.Loan_Processing ?? []).filter(l => !finance || l.Finance_Name === finance)
    if (viewer?.role === 'partner') list = list.filter(l => l.Referred_Partner === viewer!.partnerId)
    return list
  },
  loan(loanNo: string): Loan | undefined {
    return (db.Loan_Processing ?? []).find(l => l.Loan_No === loanNo)
  },
  loansByCustomer(stl: string): Loan[] {
    return (db.Loan_Processing ?? []).filter(l => l.Customer_STL_NO === stl)
  },
  interest(finance?: string): InterestRow[] {
    let list = (db.Interest_Details ?? []).filter(i => !finance || i.Finance_Name === finance)
    if (viewer?.role === 'partner') {
      const nos = partnerLoanNos()
      list = list.filter(i => nos.has(String(i.Loan_No)))
    }
    return list
  },
  interestByLoan(loanNo: string): InterestRow[] {
    return (db.Interest_Details ?? []).filter(i => String(i.Loan_No).split('-').includes(loanNo) || i.Loan_No === loanNo)
  },
  interestByCustomer(stl: string): InterestRow[] {
    return (db.Interest_Details ?? []).filter(i => i.Customer_STL_NO === stl)
  },
  ledger(finance?: string): LedgerRow[] {
    let list = (db.Transaction_Ledger ?? []).filter(t => !finance || t.Finance_Name === finance)
    if (viewer?.role === 'partner') {
      const nos = partnerLoanNos()
      list = list.filter(t => t.Loan_No != null && nos.has(String(t.Loan_No)))
    }
    return list
  },
  deposits(finance?: string): Deposit[] {
    return (db.Deposit_Amount ?? []).filter(d => !finance || d.Finance_Name === finance)
  },
  otherFinanceLoans(finance?: string): OtherFinanceLoan[] {
    return (db.Other_Finance_Loan ?? []).filter(o => !finance || o.Finance_Name === finance)
  },
  depositsByCode(code: string): Deposit[] {
    return (db.Deposit_Amount ?? []).filter(d => d.Deposit_No === code)
  },
  otherFinanceByCode(code: string): OtherFinanceLoan[] {
    return (db.Other_Finance_Loan ?? []).filter(o => o.Loan_No === code)
  },
  // Distinct depositors (like customers) — one row per depositor, linked deposits summed.
  depositors(finance?: string): { code: string; name: string; phone?: number | string; deposited: number; out: number; count: number; finance: string }[] {
    const map = new Map<string, { code: string; name: string; phone?: number | string; deposited: number; out: number; count: number; finance: string }>()
    for (const d of db.Deposit_Amount ?? []) {
      if (finance && d.Finance_Name !== finance) continue
      const key = `${d.Finance_Name}::${(d.Depositer_Name || '').toLowerCase()}`
      const cur = map.get(key) ?? { code: d.Deposit_No, name: d.Depositer_Name, phone: d.Depositer_Phone_No, deposited: 0, out: 0, count: 0, finance: d.Finance_Name }
      cur.deposited += num(d.Deposit_Amount); cur.out += num(d.Outstand_Amount); cur.count++
      map.set(key, cur)
    }
    return [...map.values()]
  },
  // Distinct lender finances (like customers) — one row per lender, linked loans summed.
  otherFinances(finance?: string): { code: string; name: string; phone?: number | string; borrowed: number; out: number; count: number; finance: string }[] {
    const map = new Map<string, { code: string; name: string; phone?: number | string; borrowed: number; out: number; count: number; finance: string }>()
    for (const o of db.Other_Finance_Loan ?? []) {
      if (finance && o.Finance_Name !== finance) continue
      const key = `${o.Finance_Name}::${(o.Loan_bought_Finance_Name || '').toLowerCase()}`
      const cur = map.get(key) ?? { code: o.Loan_No, name: o.Loan_bought_Finance_Name, phone: o.Loan_bought_Finance_Phone_No, borrowed: 0, out: 0, count: 0, finance: o.Finance_Name }
      cur.borrowed += num(o.Loan_Amount); cur.out += num(o.Outstand_Amount); cur.count++
      map.set(key, cur)
    }
    return [...map.values()]
  },
  depositInterest(finance?: string): any[] {
    return (db.Depositer_Interest ?? []).filter((i: any) => !finance || i.Finance_Name === finance)
  },
  depositInterestByCode(code: string): any[] {
    return (db.Depositer_Interest ?? []).filter((i: any) => i.Deposit_No === code)
  },
  depositInterestPending(code: string): number {
    return (db.Depositer_Interest ?? []).filter((i: any) => i.Deposit_No === code).reduce((s: number, i: any) => s + num(i.Interest_Pending), 0)
  },
  depositPostedMonths(code: string): Set<string> {
    return new Set((db.Depositer_Interest ?? []).filter((i: any) => i.Deposit_No === code && i.Month).map((i: any) => i.Month as string))
  },
  // Interest "posted up to" for an entity — its OWN stored Interest_Posted_Upto
  // column when it has one, otherwise the global Settings cut-over as a FALLBACK
  // (never a floor). This is the single source of truth for both posting (its
  // resume date) and repayment. It is advanced ONLY by a monthly posting (which
  // stamps the column) and rolled back ONLY by a revoke; a repayment deliberately
  // does NOT move it. Using the column verbatim (not max-with-global) is what lets
  // a revoke's rollback actually take effect — a stale-high global cut-over must
  // not silently re-floor an entity the revoke just moved back. Interest rows are
  // NOT consulted here — repay writes rows too, and reading them would let a repay
  // silently push the posted-till forward.
  // A finance's own interest cut-over (from its Finance_Details row).
  financeCutover(finance?: string): string | undefined { return financeCutoverOf(finance) },
  // Posted-till for a CUSTOMER (shared by all their loans) — read from the
  // customer master (STL_CRM), not the loan row.
  customerPostedUpto(stl: string): string | undefined {
    const cust = (db.STL_CRM ?? []).find(c => c.Customer_STL_NO === stl)
    return cust?.Interest_Posted_Upto || financeCutoverOf(cust?.Finance_Name)
  },
  loanPostedUpto(loanNo: string): string | undefined {
    const loan = (db.Loan_Processing ?? []).find(l => l.Loan_No === loanNo)
    const cust = loan ? (db.STL_CRM ?? []).find(c => c.Customer_STL_NO === loan.Customer_STL_NO) : undefined
    return cust?.Interest_Posted_Upto || financeCutoverOf(cust?.Finance_Name ?? loan?.Finance_Name)
  },
  depositPostedUpto(code: string): string | undefined {
    const rows = (db.Deposit_Amount ?? []).filter(d => d.Deposit_No === code)
    const col = rows.map(d => d.Interest_Posted_Upto).filter(Boolean).sort().slice(-1)[0]
    return col || financeCutoverOf(rows[0]?.Finance_Name)
  },
  otherFinancePostedUpto(code: string): string | undefined {
    const rows = (db.Other_Finance_Loan ?? []).filter(o => o.Loan_No === code)
    const col = rows.map(o => o.Interest_Posted_Upto).filter(Boolean).sort().slice(-1)[0]
    return col || financeCutoverOf(rows[0]?.Finance_Name)
  },
  // The effective ₹/lakh/month rate for a depositor when it's not stored on the
  // deposit — derived from a full-month past interest row (Interest ÷ amount).
  derivedDepositRate(code: string): number {
    const cand = (db.Depositer_Interest ?? []).filter((i: any) => i.Deposit_No === code && num(i.Interest_Amount) > 0 && num(i.Deposit_Amount) > 0)
    const full = cand.filter((i: any) => num(i.No_Days) >= 28)
    const r = (full.length ? full : cand).slice(-1)[0]
    return r ? Math.round(num(r.Interest_Amount) / (num(r.Deposit_Amount) / 100000)) : 0
  },
  otherFinanceInterest(finance?: string): any[] {
    return (db.Other_Finance_Interest ?? []).filter((i: any) => !finance || i.Finance_Name === finance)
  },
  otherFinanceInterestByCode(code: string): any[] {
    return (db.Other_Finance_Interest ?? []).filter((i: any) => i.Loan_No === code)
  },
  otherFinanceInterestPending(code: string): number {
    return (db.Other_Finance_Interest ?? []).filter((i: any) => i.Loan_No === code).reduce((s: number, i: any) => s + num(i.Interest_Pending), 0)
  },
  otherPostedMonths(code: string): Set<string> {
    return new Set((db.Other_Finance_Interest ?? []).filter((i: any) => i.Loan_No === code && i.Month).map((i: any) => i.Month as string))
  },
  // The interest-posting register — one row per posted month for a finance scope.
  postingLog(finance?: string): PostingLog[] {
    return (db.Interest_Posting_Log ?? [])
      .filter(r => !finance || r.Finance_Name === finance)
      .slice()
      .sort((a, b) => String(b.To_Date ?? '').localeCompare(String(a.To_Date ?? '')))
  },
  // Has this month already been posted for this scope? Used to block re-running a
  // completed month (belt-and-braces with each entity's posted-till date).
  isMonthPosted(finance: string, month: string): boolean {
    return (db.Interest_Posting_Log ?? []).some(r => r.Month === month && r.Finance_Name === finance)
  },
  ledgerByRef(code: string): LedgerRow[] {
    return (db.Transaction_Ledger ?? []).filter(t => String(t.Loan_No) === code)
  },
  // Every ledger movement tied to a customer — matched by their STL number or by
  // any of their loan numbers (repayments/interest are tagged with the loan).
  ledgerByCustomer(stl: string): LedgerRow[] {
    const loanNos = new Set((db.Loan_Processing ?? []).filter(l => l.Customer_STL_NO === stl).map(l => String(l.Loan_No)))
    return (db.Transaction_Ledger ?? []).filter(t =>
      String(t.STL_No ?? '') === stl || (t.Loan_No != null && loanNos.has(String(t.Loan_No))))
  },
  workers(finance?: string): Worker[] {
    return (db.Worker ?? []).filter(w => !finance || w.Finance_Name === finance)
  },
  workerByPhone(phone: string): Worker | undefined {
    return (db.Worker ?? []).find(w => String(w.Phone_Number) === phone)
  },
  partnerByPhone(phone: string): Partner | undefined {
    return (db.Partner ?? []).find(p => String(p.Phone_Number) === phone)
  },
  financeByMdPhone(phone: string): Finance | undefined {
    return (db.Finance_Details ?? []).find(f => f.Phone_Number != null && String(f.Phone_Number) === phone)
  },
  // Every finance whose MD phone matches — an MD may run more than one finance.
  financesByMdPhone(phone: string): Finance[] {
    return (db.Finance_Details ?? []).filter(f => f.Phone_Number != null && String(f.Phone_Number) === phone)
  },
  // ── Login by name (username) — matched case-insensitively against each role's
  // own table, so login no longer depends on the phone number (which can change).
  workerByName(name: string): Worker | undefined {
    return (db.Worker ?? []).find(w => eqName(w.Worker_Name, name))
  },
  partnerByName(name: string): Partner | undefined {
    return (db.Partner ?? []).find(p => eqName(p.Partner_Name, name))
  },
  // Every finance whose MD name matches — an MD may run more than one finance.
  financesByMdName(name: string): Finance[] {
    return (db.Finance_Details ?? []).filter(f => eqName(f.MD_Name ?? '', name))
  },
  notifications(phone?: string): AppNotification[] {
    return (db.Notification ?? [])
      .filter(n => !phone || n.To_Phone === phone)
      .slice()
      .sort((a, b) => new Date(b.Date).getTime() - new Date(a.Date).getTime())
  },
  unreadCount(phone: string): number {
    return (db.Notification ?? []).filter(n => n.To_Phone === phone && !n.Read).length
  },
  logs(): LogEntry[] {
    return (db.Log ?? []).slice().sort((a, b) => new Date(b.Date).getTime() - new Date(a.Date).getTime())
  },
  postedMonths(loanNo: string): Set<string> {
    return new Set((db.Interest_Details ?? []).filter(i => i.Loan_No === loanNo && i.Month).map(i => i.Month as string))
  },
  natureTypes() { return db.Nature_Transaction ?? [] },

  // ── Chit fund (chits your finance runs) ────────────────────────────────────
  chits(finance?: string): ChitCreation[] {
    return (db.Chit_Creation ?? []).filter(c => !finance || c.Finance_Name === finance)
  },
  chit(chitId: string): ChitCreation | undefined {
    return (db.Chit_Creation ?? []).find(c => c.Chit_ID === chitId)
  },
  chitMembers(chitId: string): ChitMember[] {
    return (db.Chit_Member ?? []).filter(m => m.Chit_ID === chitId)
  },
  chitMember(memberId: string): ChitMember | undefined {
    return (db.Chit_Member ?? []).find(m => m.Member_ID === memberId)
  },
  chitAuctions(chitId: string): ChitAuction[] {
    return (db.Chit_Auction ?? []).filter(a => a.Chit_ID === chitId)
      .sort((a, b) => num(a.Month_Count) - num(b.Month_Count))
  },
  chitAuction(auctionId: string): ChitAuction | undefined {
    return (db.Chit_Auction ?? []).find(a => a.Chit_Auction_ID === auctionId)
  },
  chitTakers(chitId: string): ChitTakenMember[] {
    // Company top-up rows are pool bookkeeping, not real payouts — hide them here.
    return (db.Chit_Taken_Member ?? []).filter(t => t.Chit_ID === chitId && t.Member_Type !== 'Company_Topup')
      .sort((a, b) => num(a.Month_Count) - num(b.Month_Count))
  },
  chitTakersByAuction(auctionId: string): ChitTakenMember[] {
    return (db.Chit_Taken_Member ?? []).filter(t => t.Chit_Auction_ID === auctionId && t.Member_Type !== 'Company_Topup')
  },
  // The company chit pool: money the company holds from months it took, plus
  // manual top-ups, minus what later members have drawn from it.
  chitCompanyPool(chitId: string): number {
    let pool = 0
    for (const t of db.Chit_Taken_Member ?? []) {
      if (t.Chit_ID !== chitId) continue
      if (t.Member_Type === 'Company_Chit' || t.Member_Type === 'Company_Topup') pool += num(t.Total_Amount_to_Member)
      pool -= num(t.Amount_Taken_From_Company_Chit)
    }
    return pool
  },
  // Movements in the company pool, newest first, for the history view.
  chitCompanyLedger(chitId: string): { id: string; date?: string; reason: string; direction: 'in' | 'out'; amount: number; who?: string; month?: number }[] {
    const out: { id: string; date?: string; reason: string; direction: 'in' | 'out'; amount: number; who?: string; month?: number }[] = []
    for (const t of db.Chit_Taken_Member ?? []) {
      if (t.Chit_ID !== chitId) continue
      if (t.Member_Type === 'Company_Chit') out.push({ id: t.Chit_Taken_ID + '-in', date: t.Date_Auction, reason: 'Company took the chit', direction: 'in', amount: num(t.Total_Amount_to_Member), month: num(t.Month_Count) })
      if (t.Member_Type === 'Company_Topup') out.push({ id: t.Chit_Taken_ID, date: t.Date_Auction, reason: t.Member_Name || 'Top-up', direction: 'in', amount: num(t.Total_Amount_to_Member) })
      if (num(t.Amount_Taken_From_Company_Chit) > 0) out.push({ id: t.Chit_Taken_ID + '-draw', date: t.Date_Auction, reason: 'Drawn by taker', direction: 'out', amount: num(t.Amount_Taken_From_Company_Chit), who: t.Member_Name, month: num(t.Month_Count) })
    }
    return out.sort((a, b) => new Date(b.date ?? 0).getTime() - new Date(a.date ?? 0).getTime())
  },
  chitLedger(chitId: string): ChitLedgerRow[] {
    return (db.Chit_Ledger ?? []).filter(r => r.Chit_ID === chitId)
  },
  chitLedgerByAuction(auctionId: string): ChitLedgerRow[] {
    return (db.Chit_Ledger ?? []).filter(r => r.Chit_Auction_ID === auctionId)
  },
  chitLedgerByMember(memberId: string): ChitLedgerRow[] {
    return (db.Chit_Ledger ?? []).filter(r => r.Member_ID === memberId)
      .sort((a, b) => num(a.Month_Count) - num(b.Month_Count))
  },
  // Rolled-up figures for one chit fund, computed from its ledger + takers.
  chitSummary(chitId: string) {
    const led = (db.Chit_Ledger ?? []).filter(r => r.Chit_ID === chitId)
    const takers = (db.Chit_Taken_Member ?? []).filter(t => t.Chit_ID === chitId)
    return {
      collected: led.reduce((s, r) => s + num(r.Received_Amount), 0),
      duePending: led.reduce((s, r) => s + num(r.Pending_Amount), 0),
      payoutGiven: takers.reduce((s, t) => s + num(t.Amount_Given_to_Member), 0),
      payoutPending: takers.reduce((s, t) => s + num(t.Pending_Amount), 0),
    }
  },

  // ── Invested chits (chits you join at another company) ─────────────────────
  investedChits(): InvestedChit[] {
    return db.Invested_Chit ?? []
  },
  investedChit(chitId: string): InvestedChit | undefined {
    return (db.Invested_Chit ?? []).find(c => c.Chit_ID === chitId)
  },
  investedChitTrans(chitId: string): InvestedChitTrans[] {
    return (db.Invested_Chit_Trans ?? []).filter(t => t.Chit_ID === chitId)
      .sort((a, b) => num(a.Month_Count) - num(b.Month_Count))
  },
  investedChitSummary(chitId: string) {
    const trans = (db.Invested_Chit_Trans ?? []).filter(t => t.Chit_ID === chitId)
    const payments = trans.filter(t => t.Kind !== 'Receipt')
    return {
      invested: payments.reduce((s, t) => s + num(t.Chit_This_Month_Amount), 0),
      received: trans.filter(t => t.Kind === 'Receipt').reduce((s, t) => s + num(t.Chit_This_Month_Amount), 0),
      months: payments.length,
    }
  },

  // ── Hand exchange (personal give & take — its own book PER FINANCE FIRM,
  // kept outside every finance ledger). Pass a finance name to scope to that
  // firm's book; omit (undefined) to see all firms combined.
  handEntries(finance?: string): HandExchange[] {
    return (db.Hand_Exchange ?? []).filter(e => !finance || e.Finance_Name === finance)
      .slice().sort((a, b) => new Date(b.Date ?? 0).getTime() - new Date(a.Date ?? 0).getTime())
  },
  handHistory(person: string, finance?: string): HandExchange[] {
    const key = person.trim().toLowerCase()
    return (db.Hand_Exchange ?? []).filter(e => (e.Person ?? '').trim().toLowerCase() === key && (!finance || e.Finance_Name === finance))
      .sort((a, b) => new Date(b.Date ?? 0).getTime() - new Date(a.Date ?? 0).getTime())
  },
  // One row per person, with the net balance (net > 0 → they owe you).
  // `category` (Customer / Supplier) is taken from the person's most recent
  // entry that carries one — a cosmetic grouping, defaults to 'Customer'.
  handPeople(finance?: string): { name: string; phone?: number | string; category: string; net: number; count: number; last?: string }[] {
    type Row = { name: string; phone?: number | string; category: string; net: number; count: number; last?: string; _catAt?: string }
    const map = new Map<string, Row>()
    for (const e of db.Hand_Exchange ?? []) {
      if (finance && e.Finance_Name !== finance) continue
      const key = (e.Person ?? '').trim().toLowerCase()
      if (!key) continue
      const cur = map.get(key) ?? { name: e.Person, phone: e.Person_Phone ?? undefined, category: 'Customer', net: 0, count: 0, last: e.Date }
      cur.net += e.Direction === 'out' ? num(e.Amount) : -num(e.Amount)
      cur.count++
      if (e.Person_Phone && !cur.phone) cur.phone = e.Person_Phone
      if (e.Date && (!cur.last || e.Date > cur.last)) cur.last = e.Date
      // Latest entry with an explicit Category wins.
      if (e.Category && (!cur._catAt || (e.Date ?? '') >= cur._catAt)) { cur.category = e.Category; cur._catAt = e.Date ?? '' }
      map.set(key, cur)
    }
    return [...map.values()]
      .map(({ _catAt, ...r }) => r)
      .sort((a, b) => Math.abs(b.net) - Math.abs(a.net))
  },
  handSummary(finance?: string): { theyOwe: number; youOwe: number } {
    let theyOwe = 0, youOwe = 0
    for (const p of this.handPeople(finance)) { if (p.net > 0) theyOwe += p.net; else youOwe += -p.net }
    return { theyOwe, youOwe }
  },

  raw<K extends keyof Dataset>(key: K): Dataset[K] { return db[key] },
}

// ── Credentials ──────────────────────────────────────────────────────────────
// The login PIN lives on each person's own row (visible in Supabase): an MD's PIN
// on their Finance_Details row(s), a partner's on their Partner row, a worker's on
// their Worker row. You pick your role on the login screen, so the PIN is read
// from the respective table. Defaults to '1234' until changed.
export type LoginRole = 'md' | 'partner' | 'worker'

// The stored PIN (password) for a username in a given role's table
// (undefined → use default). Login is by name, not phone, so a changed phone
// number never locks anyone out.
export function pinForName(role: LoginRole, name: string): string | undefined {
  if (role === 'md') return (db.Finance_Details ?? []).find(f => eqName(f.MD_Name ?? '', name))?.PIN
  if (role === 'partner') return (db.Partner ?? []).find(p => eqName(p.Partner_Name, name))?.PIN
  return (db.Worker ?? []).find(w => eqName(w.Worker_Name, name))?.PIN
}
export function verifyPinByName(role: LoginRole, name: string, pin: string): boolean {
  return String(pinForName(role, name) || '1234') === pin // blank/missing → default 1234
}
// Change the password for the current user's role, keyed by their (stable) name.
// An MD who runs several finances has one row per finance — update them all so the
// password stays in sync across their finances.
export async function setPinByName(role: LoginRole, name: string, pin: string): Promise<void> {
  if (role === 'md') {
    for (const f of (db.Finance_Details ?? []).filter(f => eqName(f.MD_Name ?? '', name))) {
      f.PIN = pin; await sUpdate('Finance_Details', f.Finance_Name, { PIN: pin })
    }
  } else if (role === 'partner') {
    const p = (db.Partner ?? []).find(p => eqName(p.Partner_Name, name))
    if (p) { p.PIN = pin; await sUpdate('Partner', p.Partner_ID, { PIN: pin }) }
  } else {
    const w = (db.Worker ?? []).find(w => eqName(w.Worker_Name, name))
    if (w) { w.PIN = pin; await sUpdate('Worker', w.Worker_ID, { PIN: pin }) }
  }
  persist()
}

// ── Refresh ──────────────────────────────────────────────────────────────────
// Simple, reliable "pull latest" for every role: re-hydrate from Supabase when
// configured, then reload so all screens show fresh data.
export async function refresh(): Promise<void> {
  if (isSupabaseConfigured) { try { await hydrate() } catch { /* ignore */ } }
  window.location.reload()
}

// ── Ledger helpers ───────────────────────────────────────────────────────────
// Every money movement in the firm lands here. Ref_ID is a running number; the
// balance is (receipts − payments) carried forward across the whole ledger.
function nextRef(): string {
  const rows = db.Transaction_Ledger ?? []
  const max = rows.reduce((m, r) => {
    const n = Number(String(r.Ref_ID).replace(/\D/g, ''))
    return isNaN(n) ? m : Math.max(m, n)
  }, 0)
  return String(max + 1)
}

const num = (v: unknown) => { const n = Number(v); return isNaN(n) ? 0 : n }
// Case-insensitive, trimmed name match — used for username login.
const eqName = (a: unknown, b: unknown) => String(a ?? '').trim().toLowerCase() === String(b ?? '').trim().toLowerCase()
const refNum = (r: unknown) => { const n = Number(String(r).replace(/\D/g, '')); return isNaN(n) ? 0 : n }

// Recompute the running Balance per finance, ordered by transaction date then
// insertion order — so a back-dated entry correctly shifts later balances.
// Pass a finance to recompute just that one; omit to recompute every finance.
export function recomputeBalances(finance?: string): void {
  const all = db.Transaction_Ledger ?? []
  const finances = finance !== undefined
    ? [finance]
    : [...new Set(all.map(r => String(r.Finance_Name ?? '')))]
  for (const f of finances) {
    const rows = all.filter(r => String(r.Finance_Name ?? '') === f)
    rows.sort((a, b) => {
      const da = new Date(a.Date_Transaction ?? 0).getTime()
      const dbt = new Date(b.Date_Transaction ?? 0).getTime()
      return da !== dbt ? da - dbt : refNum(a.Ref_ID) - refNum(b.Ref_ID)
    })
    let bal = 0
    for (const r of rows) { bal += num(r.Receipt_Amount) - num(r.Payment_Amount); r.Balance = bal }
  }
}

// Balance of a finance as of a date (inclusive).
export function balanceForFinance(finance: string, upto?: string): number {
  return (db.Transaction_Ledger ?? [])
    .filter(r => String(r.Finance_Name ?? '') === finance && (!upto || new Date(r.Date_Transaction ?? 0) <= new Date(upto)))
    .reduce((b, r) => b + num(r.Receipt_Amount) - num(r.Payment_Amount), 0)
}

// ── Supabase write-through ───────────────────────────────────────────────────
// When Supabase is configured, each mutation below also pushes the change to the
// database, so data persists and syncs across devices. In local mode these are
// no-ops and localStorage persist() provides durability.
const PK: Partial<Record<keyof Dataset, string>> = {
  Finance_Details: 'Finance_Name', Partner: 'Partner_ID', STL_CRM: 'Customer_STL_NO',
  Loan_Processing: 'Loan_No', Interest_Details: 'ID', Transaction_Ledger: 'Ref_ID',
  Deposit_Amount: 'Deposit_No', Other_Finance_Loan: 'Loan_No', Worker: 'Worker_ID',
  Depositer_Interest: 'ID', Other_Finance_Interest: 'ID',
  Notification: 'id', Message: 'id', Log: 'id',
  Chit_Creation: 'Chit_ID', Chit_Member: 'Member_ID', Chit_Auction: 'Chit_Auction_ID',
  Chit_Taken_Member: 'Chit_Taken_ID', Chit_Ledger: 'ID',
  Invested_Chit: 'Chit_ID', Invested_Chit_Trans: 'ID',
  Hand_Exchange: 'ID', Interest_Posting_Log: 'ID',
}
export let lastWriteError = ''
// Clear the last write error before a batch of writes, then read it after to tell
// whether every write in the batch actually reached Supabase (see Interest.tsx).
export function resetWriteError(): void { lastWriteError = '' }
export function getWriteError(): string { return lastWriteError }
function noteErr(where: string, msg?: string) {
  if (!msg) return
  lastWriteError = `${where}: ${msg}`
  console.warn('[sync]', lastWriteError)
  if (typeof window !== 'undefined') window.dispatchEvent(new CustomEvent('arul-sync-error', { detail: lastWriteError }))
}
function clean<T extends Record<string, any>>(row: T): Record<string, any> {
  const out: Record<string, any> = {}
  for (const k in row) if (row[k] !== undefined) out[k] = row[k]
  return out
}
async function sInsert(table: keyof Dataset, rows: any): Promise<void> {
  if (!supabase) return
  const arr = (Array.isArray(rows) ? rows : [rows]).map(clean)
  if (!arr.length) return
  const { error } = await supabase.from(table as string).insert(arr)
  noteErr(`insert ${table}`, error?.message)
}
async function sUpdate(table: keyof Dataset, keyVal: string, patch: any): Promise<void> {
  if (!supabase) return
  const k = PK[table]; if (!k) return
  const { error } = await supabase.from(table as string).update(clean(patch)).eq(k, keyVal)
  noteErr(`update ${table}`, error?.message)
}
async function sDelete(table: keyof Dataset, keyVal: string): Promise<void> {
  if (!supabase) return
  const k = PK[table]; if (!k) return
  const { error } = await supabase.from(table as string).delete().eq(k, keyVal)
  noteErr(`delete ${table}`, error?.message)
}
async function sReplace(table: keyof Dataset, keyVal: string, rows: any[]): Promise<void> {
  await sDelete(table, keyVal); await sInsert(table, rows)
}

// ── Write helpers (in-memory + localStorage + Supabase write-through) ─────────
export async function addLoan(loan: Loan): Promise<void> {
  db.Loan_Processing = [loan, ...(db.Loan_Processing ?? [])]
  await sInsert('Loan_Processing', loan)
  recomputeCustomer(loan.Customer_STL_NO)
  await recordLedger({
    Nature_Transaction: 'Loan_To_Customer',
    STL_No: loan.Customer_STL_NO,
    Loan_No: loan.Loan_No,
    Customer_Name: loan.Customer_Name,
    Description: `Loan disbursed — ${loan.Loan_No}`,
    Payment_Amount: num(loan.Loan_Amount),
    Payment_Type: loan.Payment_Type,
    Finance_Name: loan.Finance_Name,
    Date_Transaction: loan.Loan_Given_Date,
  })
  writeLog({ Action: 'create', Entity: 'Loan_Processing', Entity_Label: `${loan.Loan_No} · ${loan.Customer_Name}`, After: loan })
  // Bell the referred partner about the new loan.
  if (loan.Referred_Partner) {
    const p = (db.Partner ?? []).find(pt =>
      pt.Partner_ID === loan.Referred_Partner && pt.Finance_Name === loan.Finance_Name)
    if (p?.Phone_Number) {
      await addNotification({
        Finance_Name: loan.Finance_Name,
        To_Phone: String(p.Phone_Number),
        To_Party: p.Partner_Name,
        Title: `New loan ${loan.Loan_No}`,
        Body: `${loan.Customer_Name} — ₹${num(loan.Loan_Amount).toLocaleString('en-IN')} (${loan.Finance_Name})`,
      })
    }
  }
  persist()
}

// ── Deletes (all logged & restorable) ────────────────────────────────────────
export async function deleteLoan(loanNo: string): Promise<void> {
  const row = (db.Loan_Processing ?? []).find(l => l.Loan_No === loanNo)
  if (!row) return
  db.Loan_Processing = (db.Loan_Processing ?? []).filter(l => l.Loan_No !== loanNo)
  await sDelete('Loan_Processing', loanNo)
  recomputeCustomer(row.Customer_STL_NO)
  writeLog({ Action: 'delete', Entity: 'Loan_Processing', Entity_Label: `${loanNo} · ${row.Customer_Name}`, Before: row })
  persist()
}

// Undo the business effect of a ledger entry when it is deleted, so the linked
// loan / deposit / borrowing / interest record is cancelled too — not just the
// cash row. Returns a short label of what was reversed (for the Activity Log),
// or '' when the entry was cash-only (expense, income, correction, chit, …).
const inrTxt = (n: number) => '₹' + Math.round(n).toLocaleString('en-IN')

async function reverseLinkedRecord(row: LedgerRow): Promise<string> {
  const nature = String(row.Nature_Transaction ?? '')
  const amt = num(row.Receipt_Amount) || num(row.Payment_Amount)
  const stl = row.STL_No != null ? String(row.STL_No) : ''
  const code = row.Loan_No != null ? String(row.Loan_No) : '' // also holds deposit / other-finance codes
  const finance = String(row.Finance_Name ?? '')
  if (amt <= 0) return ''

  // Push `amount` back onto pending interest, newest settled rows first.
  const giveBackInterest = async (table: keyof Dataset, rows: any[]): Promise<number> => {
    let left = amt
    const changed: any[] = []
    for (const r of rows.filter(r => num(r.Amount_Received) > 0)
      .sort((a, b) => String(b.To_Date ?? b.Month ?? '').localeCompare(String(a.To_Date ?? a.Month ?? '')))) {
      if (left <= 0) break
      const give = Math.min(num(r.Amount_Received), left); left -= give
      r.Amount_Received = num(r.Amount_Received) - give
      r.Interest_Pending = num(r.Interest_Pending) + give
      r.Status = num(r.Amount_Received) > 0 ? 'Partial' : 'Pending'
      changed.push(r)
    }
    for (const r of changed) await sUpdate(table, r.ID, { Amount_Received: r.Amount_Received, Interest_Pending: r.Interest_Pending, Status: r.Status })
    return amt - left
  }

  switch (nature) {
    case 'Customer_Loan_Prin_Repayment': {
      // Put the principal back onto the loan(s) it was repaid from (oldest first).
      const loans = (db.Loan_Processing ?? [])
        .filter(l => (code ? l.Loan_No === code : l.Customer_STL_NO === stl) && num(l.Repaid_Amount) > 0)
        .sort((a, b) => new Date(a.Loan_Given_Date ?? 0).getTime() - new Date(b.Loan_Given_Date ?? 0).getTime())
      let left = amt, sc = stl
      for (const l of loans) {
        if (left <= 0) break
        const give = Math.min(num(l.Repaid_Amount), left); left -= give
        await updateLoan(l.Loan_No, { Repaid_Amount: num(l.Repaid_Amount) - give, Outstand_Amount: num(l.Outstand_Amount) + give, Loan_Status: 'Active' })
        sc = l.Customer_STL_NO
      }
      if (sc) recomputeCustomer(sc)
      return `restored ${inrTxt(amt - left)} principal to loan${code ? ' ' + code : 's'}`
    }
    case 'Customer_Interest': {
      const loanRows = code ? (db.Interest_Details ?? []).filter(i => String(i.Loan_No) === code) : []
      const rows = loanRows.length ? loanRows : (db.Interest_Details ?? []).filter(i => i.Customer_STL_NO === stl)
      const back = await giveBackInterest('Interest_Details', rows)
      recomputeCustomer(stl || rows[0]?.Customer_STL_NO || '')
      return `made ${inrTxt(back)} interest pending again`
    }
    // Loan_To_Customer / Deposit_From_Customer / Other_Receipt (the disbursal /
    // deposit-taken / borrowing-taken CREATION entries) are intentionally left
    // cash-only — deleting the ledger row does NOT remove the loan/deposit/
    // borrowing. Cancel those from their own page instead. They fall to default.
    case 'Deposit_Prin_Refund': {
      let left = amt
      db.Deposit_Amount = (db.Deposit_Amount ?? []).map(d => {
        if (left <= 0 || d.Deposit_No !== code || num(d.Repaid_Amount) <= 0) return d
        const give = Math.min(num(d.Repaid_Amount), left); left -= give
        const newOut = num(d.Outstand_Amount) + give
        return { ...d, Repaid_Amount: num(d.Repaid_Amount) - give, Outstand_Amount: newOut, Deposit_Status: newOut > 0 ? 'Active' : d.Deposit_Status }
      })
      await sReplaceFinance('Deposit_Amount', finance, (db.Deposit_Amount ?? []).filter(d => d.Finance_Name === finance))
      return `restored ${inrTxt(amt - left)} to deposit ${code}`
    }
    case 'Other_Finance_Loan_Refund': {
      let left = amt
      db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).map(o => {
        if (left <= 0 || o.Loan_No !== code || num(o.Repaid_Amount) <= 0) return o
        const give = Math.min(num(o.Repaid_Amount), left); left -= give
        const newOut = num(o.Outstand_Amount) + give
        return { ...o, Repaid_Amount: num(o.Repaid_Amount) - give, Outstand_Amount: newOut, Loan_Status: newOut > 0 ? 'Active' : o.Loan_Status }
      })
      await sReplaceFinance('Other_Finance_Loan', finance, (db.Other_Finance_Loan ?? []).filter(o => o.Finance_Name === finance))
      return `restored ${inrTxt(amt - left)} to borrowing ${code}`
    }
    case 'Depositer_Interest': {
      const back = await giveBackInterest('Depositer_Interest', (db.Depositer_Interest ?? []).filter((i: any) => i.Deposit_No === code))
      return `made ${inrTxt(back)} deposit interest pending again`
    }
    case 'Other_Finance_Interest': {
      const back = await giveBackInterest('Other_Finance_Interest', (db.Other_Finance_Interest ?? []).filter((i: any) => i.Loan_No === code))
      return `made ${inrTxt(back)} other-finance interest pending again`
    }
    default:
      return '' // Expense / Other income / Balance correction / chit / opening balance — cash only
  }
}

export async function deleteLedgerEntry(refId: string): Promise<void> {
  const row = (db.Transaction_Ledger ?? []).find(t => String(t.Ref_ID) === String(refId))
  if (!row) return
  // Cancel the linked business record first (loan/deposit/interest), then the cash row.
  const reversed = await reverseLinkedRecord(row)
  db.Transaction_Ledger = (db.Transaction_Ledger ?? []).filter(t => String(t.Ref_ID) !== String(refId))
  await sDelete('Transaction_Ledger', String(refId))
  recomputeBalances(String(row.Finance_Name ?? ''))
  writeLog({
    Action: 'delete', Entity: 'Transaction_Ledger',
    Entity_Label: `Ref ${refId} · ${row.Description ?? row.Nature_Transaction}${reversed ? ` — ${reversed}` : ''}`,
    Before: row,
  })
  persist()
}

// Edit a ledger entry in place (date / description / amounts / mode) and
// recompute the finance's running balance. Logged with before + after.
export async function updateLedgerEntry(refId: string, patch: Partial<LedgerRow>): Promise<void> {
  const before = (db.Transaction_Ledger ?? []).find(t => String(t.Ref_ID) === String(refId))
  if (!before) return
  const after = { ...before, ...patch }
  db.Transaction_Ledger = (db.Transaction_Ledger ?? []).map(t => String(t.Ref_ID) === String(refId) ? after : t)
  await sUpdate('Transaction_Ledger', String(refId), patch)
  recomputeBalances(String(after.Finance_Name ?? ''))
  writeLog({ Action: 'update', Entity: 'Transaction_Ledger', Entity_Label: `Ref ${refId} · ${after.Description ?? after.Nature_Transaction}`, Before: before, After: after })
  persist()
}

// Deposit/other-finance rows have no unique key, so we match the exact row and
// replace that finance's rows in Supabase.
export async function deleteDeposit(row: Deposit): Promise<void> {
  const before = (db.Deposit_Amount ?? []).find(d => sameDeposit(d, row))
  if (!before) return
  db.Deposit_Amount = (db.Deposit_Amount ?? []).filter(d => d !== before)
  await sReplaceFinance('Deposit_Amount', before.Finance_Name, (db.Deposit_Amount ?? []).filter(d => d.Finance_Name === before.Finance_Name))
  writeLog({ Action: 'delete', Entity: 'Deposit_Amount', Entity_Label: `${before.Deposit_No} · ${before.Depositer_Name}`, Before: before })
  persist()
}
function sameDeposit(a: Deposit, b: Deposit): boolean {
  return a.Deposit_No === b.Deposit_No && a.Deposit_Bought_Date === b.Deposit_Bought_Date &&
    num(a.Deposit_Amount) === num(b.Deposit_Amount) && a.Depositer_Name === b.Depositer_Name
}

// Edit one deposit row's financials (amount / outstanding / rate / status).
export async function editDeposit(row: Deposit, patch: Partial<Deposit>): Promise<void> {
  const before = (db.Deposit_Amount ?? []).find(d => sameDeposit(d, row))
  if (!before) return
  const after = { ...before, ...patch }
  db.Deposit_Amount = (db.Deposit_Amount ?? []).map(d => d === before ? after : d)
  await sReplaceFinance('Deposit_Amount', before.Finance_Name, (db.Deposit_Amount ?? []).filter(d => d.Finance_Name === before.Finance_Name))
  writeLog({ Action: 'update', Entity: 'Deposit_Amount', Entity_Label: `Edit ${before.Deposit_No} · ${before.Depositer_Name}`, Before: before, After: after })
  persist()
}

// Update depositor profile fields (name / phone / email / address) on every
// deposit under a code, so the change applies to the whole depositor.
export async function updateDepositorProfile(code: string, patch: Partial<Deposit>): Promise<void> {
  const rows = (db.Deposit_Amount ?? []).filter(d => d.Deposit_No === code)
  if (!rows.length) return
  const finance = rows[0].Finance_Name
  db.Deposit_Amount = (db.Deposit_Amount ?? []).map(d => d.Deposit_No === code ? { ...d, ...patch } : d)
  await sReplaceFinance('Deposit_Amount', finance, (db.Deposit_Amount ?? []).filter(d => d.Finance_Name === finance))
  writeLog({ Action: 'update', Entity: 'Deposit_Amount', Entity_Label: `Edit depositor ${code} · ${rows[0].Depositer_Name}`, After: patch })
  persist()
}

export async function deleteOtherFinance(row: OtherFinanceLoan): Promise<void> {
  const before = (db.Other_Finance_Loan ?? []).find(o => sameOther(o, row))
  if (!before) return
  db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).filter(o => o !== before)
  await sReplaceFinance('Other_Finance_Loan', before.Finance_Name, (db.Other_Finance_Loan ?? []).filter(o => o.Finance_Name === before.Finance_Name))
  writeLog({ Action: 'delete', Entity: 'Other_Finance_Loan', Entity_Label: `${before.Loan_No} · ${before.Loan_bought_Finance_Name}`, Before: before })
  persist()
}
// Edit one other-finance borrowing's financials (amount / outstanding / rate / type / status).
export async function editOtherFinance(row: OtherFinanceLoan, patch: Partial<OtherFinanceLoan>): Promise<void> {
  const before = (db.Other_Finance_Loan ?? []).find(o => sameOther(o, row))
  if (!before) return
  const after = { ...before, ...patch }
  db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).map(o => o === before ? after : o)
  await sReplaceFinance('Other_Finance_Loan', before.Finance_Name, (db.Other_Finance_Loan ?? []).filter(o => o.Finance_Name === before.Finance_Name))
  writeLog({ Action: 'update', Entity: 'Other_Finance_Loan', Entity_Label: `Edit ${before.Loan_No} · ${before.Loan_bought_Finance_Name}`, Before: before, After: after })
  persist()
}

// Update lender profile fields (name / phone / email / address) on every
// borrowing under a code.
export async function updateOtherFinanceProfile(code: string, patch: Partial<OtherFinanceLoan>): Promise<void> {
  const rows = (db.Other_Finance_Loan ?? []).filter(o => o.Loan_No === code)
  if (!rows.length) return
  const finance = rows[0].Finance_Name
  db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).map(o => o.Loan_No === code ? { ...o, ...patch } : o)
  await sReplaceFinance('Other_Finance_Loan', finance, (db.Other_Finance_Loan ?? []).filter(o => o.Finance_Name === finance))
  writeLog({ Action: 'update', Entity: 'Other_Finance_Loan', Entity_Label: `Edit lender ${code} · ${rows[0].Loan_bought_Finance_Name}`, After: patch })
  persist()
}

function sameOther(a: OtherFinanceLoan, b: OtherFinanceLoan): boolean {
  return a.Loan_No === b.Loan_No && a.Loan_Bought_Date === b.Loan_Bought_Date &&
    num(a.Loan_Amount) === num(b.Loan_Amount) && a.Loan_bought_Finance_Name === b.Loan_bought_Finance_Name
}

export async function updateLoan(loanNo: string, patch: Partial<Loan>): Promise<void> {
  db.Loan_Processing = (db.Loan_Processing ?? []).map(l =>
    l.Loan_No === loanNo ? { ...l, ...patch } : l)
  await sUpdate('Loan_Processing', loanNo, patch)
  persist()
}

// An admin edit/correction of a loan (amount / outstanding / rate / status).
// Unlike updateLoan (used internally by repayments), this one refreshes the
// customer roll-up and records a before/after entry in the Activity Log, so it's
// restorable. Use it to fix a mis-recorded repayment, etc.
export async function editLoan(loanNo: string, patch: Partial<Loan>): Promise<void> {
  const before = (db.Loan_Processing ?? []).find(l => l.Loan_No === loanNo)
  if (!before) return
  const after = { ...before, ...patch }
  db.Loan_Processing = (db.Loan_Processing ?? []).map(l => l.Loan_No === loanNo ? after : l)
  await sUpdate('Loan_Processing', loanNo, patch)
  recomputeCustomer(before.Customer_STL_NO)
  writeLog({ Action: 'update', Entity: 'Loan_Processing', Entity_Label: `Edit ${loanNo} · ${before.Customer_Name}`, Before: before, After: after })
  persist()
}

// The "interest posted up to" date lives in the Interest_Posted_Upto column on
// the CUSTOMER master (STL_CRM) — shared by all that customer's loans — and on
// each deposit / other-finance record (which are their own masters). A monthly
// posting stamps it (below); a repayment never touches it. repo.customerPostedUpto
// etc. read it (falling back to the Settings cut-over when blank). These stamps
// use a targeted column update (sUpdate by primary key), NOT the delete-then-insert
// replace, so they're safe to write on the deposit/other tables too.
export async function markCustomerPostedUpto(stl: string, date: string): Promise<void> {
  db.STL_CRM = (db.STL_CRM ?? []).map(c => c.Customer_STL_NO === stl ? { ...c, Interest_Posted_Upto: date } : c)
  await sUpdate('STL_CRM', stl, { Interest_Posted_Upto: date })
  persist()
}
export async function markDepositPostedUpto(code: string, date: string): Promise<void> {
  db.Deposit_Amount = (db.Deposit_Amount ?? []).map(d => d.Deposit_No === code ? { ...d, Interest_Posted_Upto: date } : d)
  await sUpdate('Deposit_Amount', code, { Interest_Posted_Upto: date })
  persist()
}
export async function markOtherFinancePostedUpto(code: string, date: string): Promise<void> {
  db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).map(o => o.Loan_No === code ? { ...o, Interest_Posted_Upto: date } : o)
  await sUpdate('Other_Finance_Loan', code, { Interest_Posted_Upto: date })
  persist()
}

export async function addCustomer(c: Customer): Promise<void> {
  db.STL_CRM = [c, ...(db.STL_CRM ?? [])]
  await sInsert('STL_CRM', c)
  persist()
}

export async function updateCustomer(stl: string, patch: Partial<Customer>): Promise<void> {
  db.STL_CRM = (db.STL_CRM ?? []).map(c =>
    c.Customer_STL_NO === stl ? { ...c, ...patch } : c)
  await sUpdate('STL_CRM', stl, patch)
  persist()
}

// Next STL number for a finance, based on the max numeric suffix already used.
export function nextStlNo(finance: string): string {
  const prefix = finance.slice(0, 3) || 'Fin'
  const max = (db.STL_CRM ?? [])
    .filter(c => c.Finance_Name === finance)
    .reduce((m, c) => {
      const n = Number(String(c.Customer_STL_NO).replace(/\D/g, ''))
      return isNaN(n) ? m : Math.max(m, n)
    }, 0)
  return `${prefix}-STL${max + 1}`
}

// Interest rows carry a deterministic ID (e.g. `${stl}-${month}`). Skip any whose
// ID already exists so a double-click / re-post can never duplicate a row —
// posting is idempotent, and a genuine re-post only lands after a revoke removed
// the old rows first.
function dropExisting<T extends { ID?: string }>(table: T[], rows: T[]): T[] {
  const have = new Set((table ?? []).map(r => r.ID))
  return rows.filter(r => !have.has(r.ID))
}

export async function appendInterestRows(rows: InterestRow[]): Promise<void> {
  const fresh = dropExisting(db.Interest_Details ?? [], rows)
  if (!fresh.length) return
  db.Interest_Details = [...(db.Interest_Details ?? []), ...fresh]
  await sInsert('Interest_Details', fresh)
  persist()
}

export async function appendDepositInterest(rows: any[]): Promise<void> {
  const fresh = dropExisting(db.Depositer_Interest ?? [], rows)
  if (!fresh.length) return
  db.Depositer_Interest = [...(db.Depositer_Interest ?? []), ...fresh]
  await sInsert('Depositer_Interest', fresh)
  persist()
}

export async function appendOtherFinanceInterest(rows: any[]): Promise<void> {
  const fresh = dropExisting(db.Other_Finance_Interest ?? [], rows)
  if (!fresh.length) return
  db.Other_Finance_Interest = [...(db.Other_Finance_Interest ?? []), ...fresh]
  await sInsert('Other_Finance_Interest', fresh)
  persist()
}

// Record a posting run in the register. Overwrites any existing row for the same
// finance+month (so a re-run after a correction keeps one authoritative row).
export async function appendPostingLog(row: PostingLog): Promise<void> {
  db.Interest_Posting_Log = [row, ...(db.Interest_Posting_Log ?? []).filter(r => r.ID !== row.ID)]
  await sReplace('Interest_Posting_Log', row.ID, [row])
  persist()
}

// Pay a single interest line — a specific amount (defaults to the full pending),
// capped at what's pending. Records the ledger entry.
export async function payCustomerInterest(id: string, amount?: number, date?: string, payType?: string): Promise<void> {
  const row = (db.Interest_Details ?? []).find(i => i.ID === id)
  if (!row) return
  const pending = num(row.Interest_Pending); if (pending <= 0) return
  const pay = Math.min(num(amount) > 0 ? num(amount) : pending, pending)
  const left = pending - pay
  await updateInterestRow(id, { Amount_Received: num(row.Amount_Received) + pay, Interest_Pending: left, Status: left <= 0 ? 'Paid' : 'Partial' })
  await recordLedger({
    Nature_Transaction: 'Customer_Interest', STL_No: row.Customer_STL_NO, Loan_No: row.Loan_No,
    Customer_Name: row.Customer_Name, Description: `Interest received — ${row.Loan_No}`,
    Receipt_Amount: pay, Interest_Amount: pay, Payment_Type: payType,
    Finance_Name: row.Finance_Name, Date_Transaction: date,
  })
  persist()
}

export async function payDepositInterest(id: string, amount?: number, date?: string, payType?: string, note?: string): Promise<void> {
  const row: any = (db.Depositer_Interest ?? []).find((i: any) => i.ID === id)
  if (!row) return
  const pending = num(row.Interest_Pending); if (pending <= 0) return
  const pay = Math.min(num(amount) > 0 ? num(amount) : pending, pending)
  const left = pending - pay
  const patch = { Amount_Received: num(row.Amount_Received) + pay, Interest_Pending: left, Status: left <= 0 ? 'Paid' : 'Partial' }
  db.Depositer_Interest = (db.Depositer_Interest ?? []).map((i: any) => i.ID === id ? { ...i, ...patch } : i)
  await sUpdate('Depositer_Interest', id, patch)
  await recordLedger({
    Nature_Transaction: 'Depositer_Interest', Loan_No: row.Deposit_No, Customer_Name: row.Depositer_Name,
    Description: `Deposit interest — ${row.Deposit_No}${note ? ` · ${note}` : ''}`, Payment_Amount: pay, Interest_Amount: pay,
    Payment_Type: payType, Finance_Name: row.Finance_Name, Date_Transaction: date,
  })
  writeLog({ Action: 'update', Entity: 'Depositer_Interest', Entity_Label: `Pay deposit interest ${row.Deposit_No} · ${row.Month}`, Before: row })
  persist()
}

export async function payOtherFinanceInterest(id: string, amount?: number, date?: string, payType?: string, note?: string): Promise<void> {
  const row: any = (db.Other_Finance_Interest ?? []).find((i: any) => i.ID === id)
  if (!row) return
  const pending = num(row.Interest_Pending); if (pending <= 0) return
  const pay = Math.min(num(amount) > 0 ? num(amount) : pending, pending)
  const left = pending - pay
  const patch = { Amount_Received: num(row.Amount_Received) + pay, Interest_Pending: left, Status: left <= 0 ? 'Paid' : 'Partial' }
  db.Other_Finance_Interest = (db.Other_Finance_Interest ?? []).map((i: any) => i.ID === id ? { ...i, ...patch } : i)
  await sUpdate('Other_Finance_Interest', id, patch)
  await recordLedger({
    Nature_Transaction: 'Other_Finance_Interest', Loan_No: row.Loan_No, Customer_Name: row.Loan_bought_Finance_Name,
    Description: `Other-finance interest — ${row.Loan_No}${note ? ` · ${note}` : ''}`, Payment_Amount: pay, Interest_Amount: pay,
    Payment_Type: payType, Finance_Name: row.Finance_Name, Date_Transaction: date,
  })
  writeLog({ Action: 'update', Entity: 'Other_Finance_Interest', Entity_Label: `Pay other-finance interest ${row.Loan_No} · ${row.Month}`, Before: row })
  persist()
}

// Post a ledger row. Ref_ID and Balance are filled automatically when omitted,
// so callers only supply the meaningful fields (nature, amounts, who/what).
export async function recordLedger(row: Partial<LedgerRow>): Promise<LedgerRow> {
  const full: LedgerRow = {
    ...row,
    Ref_ID: row.Ref_ID ?? nextRef(),
    Date_Transaction: row.Date_Transaction ?? new Date().toISOString().slice(0, 10),
    // Audit stamp of when the entry was entered into the app (distinct from the
    // transaction/value date, which may be back-dated). Kept in memory for
    // instant display; NOT sent to Supabase so a missing column can never break
    // the insert — the DB column's `default now()` stamps it on the server side.
    Created_Date: row.Created_Date ?? new Date().toISOString(),
    Balance: 0,
  } as LedgerRow
  db.Transaction_Ledger = [...(db.Transaction_Ledger ?? []), full]
  // Interest_Amount is a text column in the DB — send it as a string.
  // Created_Date is omitted so the DB's default fills it (see note above).
  await sInsert('Transaction_Ledger', { ...full, Interest_Amount: full.Interest_Amount != null ? String(full.Interest_Amount) : undefined, Created_Date: undefined })
  // Re-run the per-finance, date-ordered balance so a back-dated entry is correct.
  recomputeBalances(String(full.Finance_Name ?? ''))
  persist()
  return full
}

// A manual "balance correction" row that makes a finance's balance equal a target
// as of a date — it's a normal ledger entry, so it shows in the ledger and log.
export async function addBalanceCorrection(finance: string, date: string, targetBalance: number, remarks?: string): Promise<void> {
  const current = balanceForFinance(finance, date)
  const diff = targetBalance - current
  if (diff === 0) return
  await recordLedger({
    Nature_Transaction: 'Balance_Correction',
    Description: remarks || 'Balance correction',
    Receipt_Amount: diff > 0 ? diff : undefined,
    Payment_Amount: diff < 0 ? -diff : undefined,
    Finance_Name: finance,
    Date_Transaction: date,
  })
  writeLog({ Action: 'create', Entity: 'Transaction_Ledger', Entity_Label: `Balance correction · ${finance} → ₹${targetBalance.toLocaleString('en-IN')} on ${date}` })
  persist()
}

// Firm repays a depositor (principal refund and/or interest) — both are payments
// out. Reduces outstanding across that depositor's linked deposit rows.
// targetKey (optional) restricts the principal refund to a single deposit /
// borrowing row — "<bought-date>|<amount>". Omit to refund oldest-first.
// `interest`        = amount paid now against the PREVIOUS pending interest.
// `accrualInterest` = amount paid now against THIS repayment's accrued interest
//                     (the freshly-posted accrual rows). Kept separate so the two
//                     are shown and settled independently in the repay screen.
export interface LiabilityRepay { code: string; principal: number; interest: number; accrualInterest?: number; date: string; payType?: string; note?: string; accruals?: any[]; targetKey?: string }
const depKey = (d: any) => `${d.Deposit_Bought_Date ?? ''}|${num(d.Deposit_Amount)}`
const ofKey = (l: any) => `${l.Loan_Bought_Date ?? ''}|${num(l.Loan_Amount)}`

// Settle a set of pending interest rows against a paid amount, oldest first.
// Returns which rows to credit (id -> amount paid) and the total actually applied.
function settleInterest(rows: any[], amount: number): { paidById: Map<string, number>; paid: number } {
  const paidById = new Map<string, number>()
  const total = Math.max(0, num(amount))
  let left = total
  const sorted = rows.slice().sort((a, b) => new Date(a.From_Date ?? a.Month ?? 0).getTime() - new Date(b.From_Date ?? b.Month ?? 0).getTime())
  for (const r of sorted) {
    if (left <= 0) break
    const pay = Math.min(num(r.Interest_Pending), left)
    if (pay > 0) { paidById.set(r.ID, pay); left -= pay }
  }
  return { paidById, paid: total - left }
}

export async function repayDeposit(o: LiabilityRepay): Promise<void> {
  const rows = (db.Deposit_Amount ?? []).filter(d => d.Deposit_No === o.code)
  if (!rows.length) return
  const name = rows[0].Depositer_Name, finance = rows[0].Finance_Name

  // Post any freshly-accrued interest (on the refunded amount) as pending rows,
  // so it joins the schedule the interest settlement below draws from.
  if (o.accruals && o.accruals.length) {
    db.Depositer_Interest = [...(db.Depositer_Interest ?? []), ...o.accruals]
    await sInsert('Depositer_Interest', o.accruals)
  }

  // Principal refund → oldest deposit first.
  const payByRef = new Map<Deposit, number>()
  let leftP = o.principal
  for (const d of rows.filter(d => num(d.Outstand_Amount) > 0 && (!o.targetKey || depKey(d) === o.targetKey)).sort((a, b) => new Date(a.Deposit_Bought_Date ?? 0).getTime() - new Date(b.Deposit_Bought_Date ?? 0).getTime())) {
    if (leftP <= 0) break
    const pay = Math.min(num(d.Outstand_Amount), leftP); leftP -= pay
    payByRef.set(d, pay)
  }
  db.Deposit_Amount = (db.Deposit_Amount ?? []).map(d => {
    const pay = payByRef.get(d); if (!pay) return d
    const newOut = num(d.Outstand_Amount) - pay
    return { ...d, Repaid_Amount: num(d.Repaid_Amount) + pay, Outstand_Amount: newOut, Deposit_Status: newOut === 0 ? 'Closed' : d.Deposit_Status }
  })
  await sReplace('Deposit_Amount', o.code, (db.Deposit_Amount ?? []).filter(d => d.Deposit_No === o.code))
  const paidP = o.principal - leftP

  // Interest → two independent buckets, each settled oldest-first:
  //   • `interest`        pays the PREVIOUS pending schedule (excludes accruals)
  //   • `accrualInterest` pays THIS repayment's accrued interest (the accrual rows)
  const accrualIds = new Set<string>((o.accruals ?? []).map((a: any) => a.ID))
  const pending = (db.Depositer_Interest ?? []).filter((i: any) => i.Deposit_No === o.code && num(i.Interest_Pending) > 0)
  const sPrev = settleInterest(pending.filter((i: any) => !accrualIds.has(i.ID)), o.interest)
  const sAcc = settleInterest(pending.filter((i: any) => accrualIds.has(i.ID)), o.accrualInterest ?? 0)
  const paidById = new Map<string, number>([...sPrev.paidById, ...sAcc.paidById])
  const changed: any[] = []
  db.Depositer_Interest = (db.Depositer_Interest ?? []).map((i: any) => {
    const pay = paidById.get(i.ID); if (!pay) return i
    const p = num(i.Interest_Pending)
    const upd = { ...i, Amount_Received: num(i.Amount_Received) + pay, Interest_Pending: p - pay, Status: p - pay <= 0 ? 'Paid' : 'Partial' }
    changed.push(upd); return upd
  })
  const paidI = sPrev.paid + sAcc.paid

  if (paidP > 0) await recordLedger({ Nature_Transaction: 'Deposit_Prin_Refund', Loan_No: o.code, Customer_Name: name, Description: `Deposit refund — ${o.code}${o.note ? ` · ${o.note}` : ''}`, Payment_Amount: paidP, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  if (paidI > 0) await recordLedger({ Nature_Transaction: 'Depositer_Interest', Loan_No: o.code, Customer_Name: name, Description: `Deposit interest — ${o.code}${o.note ? ` · ${o.note}` : ''}`, Payment_Amount: paidI, Interest_Amount: paidI, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  for (const r of changed) await sUpdate('Depositer_Interest', r.ID, { Amount_Received: r.Amount_Received, Interest_Pending: r.Interest_Pending, Status: r.Status })
  writeLog({ Action: 'update', Entity: 'Deposit_Amount', Entity_Label: `Repay deposit ${o.code} · prin ₹${paidP.toLocaleString('en-IN')} + int ₹${paidI.toLocaleString('en-IN')}`, Before: rows })
  persist()
}

// Firm repays money it borrowed from another finance (principal and/or interest).
export async function repayOtherFinance(o: LiabilityRepay): Promise<void> {
  const rows = (db.Other_Finance_Loan ?? []).filter(l => l.Loan_No === o.code)
  if (!rows.length) return
  const name = rows[0].Loan_bought_Finance_Name, finance = rows[0].Finance_Name

  // Post any freshly-accrued interest (on the refunded amount) as pending rows.
  if (o.accruals && o.accruals.length) {
    db.Other_Finance_Interest = [...(db.Other_Finance_Interest ?? []), ...o.accruals]
    await sInsert('Other_Finance_Interest', o.accruals)
  }

  // Principal refund → oldest borrowing first.
  const payByRef = new Map<OtherFinanceLoan, number>()
  let leftP = o.principal
  for (const l of rows.filter(l => num(l.Outstand_Amount) > 0 && (!o.targetKey || ofKey(l) === o.targetKey)).sort((a, b) => new Date(a.Loan_Bought_Date ?? 0).getTime() - new Date(b.Loan_Bought_Date ?? 0).getTime())) {
    if (leftP <= 0) break
    const pay = Math.min(num(l.Outstand_Amount), leftP); leftP -= pay
    payByRef.set(l, pay)
  }
  db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).map(l => {
    const pay = payByRef.get(l); if (!pay) return l
    const newOut = num(l.Outstand_Amount) - pay
    return { ...l, Repaid_Amount: num(l.Repaid_Amount) + pay, Outstand_Amount: newOut, Loan_Status: newOut === 0 ? 'Closed' : l.Loan_Status }
  })
  await sReplace('Other_Finance_Loan', o.code, (db.Other_Finance_Loan ?? []).filter(l => l.Loan_No === o.code))
  const paidP = o.principal - leftP

  // Interest → two independent buckets, each settled oldest-first:
  //   • `interest`        pays the PREVIOUS pending schedule (excludes accruals)
  //   • `accrualInterest` pays THIS repayment's accrued interest (the accrual rows)
  const accrualIds = new Set<string>((o.accruals ?? []).map((a: any) => a.ID))
  const pending = (db.Other_Finance_Interest ?? []).filter((i: any) => i.Loan_No === o.code && num(i.Interest_Pending) > 0)
  const sPrev = settleInterest(pending.filter((i: any) => !accrualIds.has(i.ID)), o.interest)
  const sAcc = settleInterest(pending.filter((i: any) => accrualIds.has(i.ID)), o.accrualInterest ?? 0)
  const paidById = new Map<string, number>([...sPrev.paidById, ...sAcc.paidById])
  const changed: any[] = []
  db.Other_Finance_Interest = (db.Other_Finance_Interest ?? []).map((i: any) => {
    const pay = paidById.get(i.ID); if (!pay) return i
    const p = num(i.Interest_Pending)
    const upd = { ...i, Amount_Received: num(i.Amount_Received) + pay, Interest_Pending: p - pay, Status: p - pay <= 0 ? 'Paid' : 'Partial' }
    changed.push(upd); return upd
  })
  const paidI = sPrev.paid + sAcc.paid

  if (paidP > 0) await recordLedger({ Nature_Transaction: 'Other_Finance_Loan_Refund', Loan_No: o.code, Customer_Name: name, Description: `Other-finance refund — ${o.code}${o.note ? ` · ${o.note}` : ''}`, Payment_Amount: paidP, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  if (paidI > 0) await recordLedger({ Nature_Transaction: 'Other_Finance_Interest', Loan_No: o.code, Customer_Name: name, Description: `Other-finance interest — ${o.code}${o.note ? ` · ${o.note}` : ''}`, Payment_Amount: paidI, Interest_Amount: paidI, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  for (const r of changed) await sUpdate('Other_Finance_Interest', r.ID, { Amount_Received: r.Amount_Received, Interest_Pending: r.Interest_Pending, Status: r.Status })
  writeLog({ Action: 'update', Entity: 'Other_Finance_Loan', Entity_Label: `Repay other-finance ${o.code} · prin ₹${paidP.toLocaleString('en-IN')} + int ₹${paidI.toLocaleString('en-IN')}`, Before: rows })
  persist()
}

export async function addDeposit(d: Deposit): Promise<void> {
  db.Deposit_Amount = [d, ...(db.Deposit_Amount ?? [])]
  await sInsert('Deposit_Amount', d)
  await recordLedger({
    Nature_Transaction: 'Deposit_From_Customer',
    Loan_No: d.Deposit_No,
    Customer_Name: d.Depositer_Name,
    Description: `Deposit received — ${d.Deposit_No}`,
    Receipt_Amount: num(d.Deposit_Amount),
    Payment_Type: d.Payment_Type,
    Finance_Name: d.Finance_Name,
    Date_Transaction: d.Deposit_Bought_Date,
  })
  persist()
}

export async function addOtherFinanceLoan(o: OtherFinanceLoan): Promise<void> {
  db.Other_Finance_Loan = [o, ...(db.Other_Finance_Loan ?? [])]
  await sInsert('Other_Finance_Loan', o)
  await recordLedger({
    Nature_Transaction: 'Other_Receipt',
    Loan_No: o.Loan_No,
    Customer_Name: o.Loan_bought_Finance_Name,
    Description: `Loan borrowed from ${o.Loan_bought_Finance_Name}`,
    Receipt_Amount: num(o.Loan_Amount),
    Payment_Type: o.Payment_Type,
    Finance_Name: o.Finance_Name,
    Date_Transaction: o.Loan_Bought_Date,
  })
  persist()
}

export async function addPartner(p: Partner): Promise<void> {
  db.Partner = [p, ...(db.Partner ?? [])]
  await sInsert('Partner', p)
  writeLog({ Action: 'create', Entity: 'Partner', Entity_Label: `${p.Partner_Name} (${p.Partner_ID})`, After: p })
  persist()
}

export async function addFinance(fin: Finance): Promise<void> {
  db.Finance_Details = [...(db.Finance_Details ?? []), fin]
  await sInsert('Finance_Details', fin)
  writeLog({ Action: 'create', Entity: 'Finance_Details', Entity_Label: `${fin.Finance_Name} (MD ${fin.MD_Name ?? '—'})`, After: fin })
  persist()
}

export async function updateFinance(name: string, patch: Partial<Finance>): Promise<void> {
  const before = (db.Finance_Details ?? []).find(f => f.Finance_Name === name)
  db.Finance_Details = (db.Finance_Details ?? []).map(f => f.Finance_Name === name ? { ...f, ...patch } : f)
  await sUpdate('Finance_Details', name, patch)
  writeLog({ Action: 'update', Entity: 'Finance_Details', Entity_Label: `Edit ${name}`, Before: before, After: { ...before, ...patch } })
  persist()
}

export async function addWorker(w: Worker): Promise<void> {
  db.Worker = [w, ...(db.Worker ?? [])]
  await sInsert('Worker', w)
  writeLog({ Action: 'create', Entity: 'Worker', Entity_Label: `${w.Worker_Name} (${w.Phone_Number})`, After: w })
  persist()
}

export async function updateWorker(id: string, patch: Partial<Worker>): Promise<void> {
  db.Worker = (db.Worker ?? []).map(w => w.Worker_ID === id ? { ...w, ...patch } : w)
  await sUpdate('Worker', id, patch)
  persist()
}

export async function addNotification(n: Omit<AppNotification, 'id' | 'Date' | 'Read'> & { Date?: string }): Promise<void> {
  const row: AppNotification = {
    id: `N-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`,
    Date: n.Date ?? new Date().toISOString(),
    Read: false,
    ...n,
  }
  db.Notification = [row, ...(db.Notification ?? [])]
  await sInsert('Notification', row)
  persist()
}

export async function markNotificationsRead(phone: string): Promise<void> {
  db.Notification = (db.Notification ?? []).map(n => n.To_Phone === phone ? { ...n, Read: true } : n)
  if (supabase) { const { error } = await supabase.from('Notification').update({ Read: true }).eq('To_Phone', phone); noteErr('update Notification', error?.message) }
  persist()
}

// ── App settings (local) ─────────────────────────────────────────────────────
export interface AppSettings {
  postingAnyDate: boolean
  dataLoadedDate: string       // date the data was imported into the app
  lastPostedDate: string       // interest already posted up to this date (migration)
  chitMultipleTakersPerMonth: boolean  // allow more than one member to take a chit in the same month
  chitPerMemberCommission: boolean     // use each member's own commission % when they take (instead of the chit-wide %)
}
const SETTINGS_DEFAULTS: AppSettings = {
  postingAnyDate: false, dataLoadedDate: '', lastPostedDate: '',
  chitMultipleTakersPerMonth: false, chitPerMemberCommission: false,
}
const SETTINGS_KEY = 'arul-finance:settings:v1'
export function getSettings(): AppSettings {
  try { return { ...SETTINGS_DEFAULTS, ...JSON.parse(localStorage.getItem(SETTINGS_KEY) || '{}') } }
  catch { return { ...SETTINGS_DEFAULTS } }
}
export function setSettings(patch: Partial<AppSettings>): void {
  localStorage.setItem(SETTINGS_KEY, JSON.stringify({ ...getSettings(), ...patch }))
}

// ── One-time renumber: convert legacy deposit / other-finance codes to the
// DEP / FIN scheme, one code per depositor / lender, updating all references.
async function sReplaceFinance(table: keyof Dataset, finance: string, rows: any[]): Promise<void> {
  if (!supabase) return
  const { error } = await supabase.from(table as string).delete().eq('Finance_Name', finance)
  noteErr(`delete ${table}`, error?.message)
  await sInsert(table, rows)
}

export async function renumberCodes(): Promise<{ deposits: number; other: number }> {
  const depOldToNew = new Map<string, string>()
  const finOldToNew = new Map<string, string>()

  // Deposits: <prefix>-DEP<n>, one code per depositor within a finance.
  {
    const nameCode = new Map<string, string>()
    const seq = new Map<string, number>()
    for (const d of db.Deposit_Amount ?? []) {
      const prefix = (d.Finance_Name || 'Fin').slice(0, 3)
      const nameKey = `${d.Finance_Name}::${(d.Depositer_Name || '').toLowerCase()}`
      let code = nameCode.get(nameKey)
      if (!code) {
        const n = (seq.get(d.Finance_Name) ?? 0) + 1
        seq.set(d.Finance_Name, n)
        code = `${prefix}-DEP${n}`
        nameCode.set(nameKey, code)
      }
      if (d.Deposit_No !== code) depOldToNew.set(d.Deposit_No, code)
    }
    db.Deposit_Amount = (db.Deposit_Amount ?? []).map(d => depOldToNew.has(d.Deposit_No) ? { ...d, Deposit_No: depOldToNew.get(d.Deposit_No)! } : d)
    db.Depositer_Interest = (db.Depositer_Interest ?? []).map((i: any) => depOldToNew.has(i.Deposit_No) ? { ...i, Deposit_No: depOldToNew.get(i.Deposit_No)! } : i)
  }

  // Other-finance: <prefix>-FIN<n>, one code per lender within a finance.
  {
    const nameCode = new Map<string, string>()
    const seq = new Map<string, number>()
    for (const o of db.Other_Finance_Loan ?? []) {
      const prefix = (o.Finance_Name || 'Fin').slice(0, 3)
      const nameKey = `${o.Finance_Name}::${(o.Loan_bought_Finance_Name || '').toLowerCase()}`
      let code = nameCode.get(nameKey)
      if (!code) {
        const n = (seq.get(o.Finance_Name) ?? 0) + 1
        seq.set(o.Finance_Name, n)
        code = `${prefix}-FIN${n}`
        nameCode.set(nameKey, code)
      }
      if (o.Loan_No !== code) finOldToNew.set(o.Loan_No, code)
    }
    db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).map(o => finOldToNew.has(o.Loan_No) ? { ...o, Loan_No: finOldToNew.get(o.Loan_No)! } : o)
  }

  // Update ledger references (keyed by the stable Ref_ID).
  const changedLedger: LedgerRow[] = []
  db.Transaction_Ledger = (db.Transaction_Ledger ?? []).map(t => {
    const key = String(t.Loan_No)
    const nn = depOldToNew.get(key) ?? finOldToNew.get(key)
    if (!nn) return t
    const upd = { ...t, Loan_No: nn }
    changedLedger.push(upd)
    return upd
  })

  // Sync to Supabase: replace the two entity tables + interest per finance,
  // and update the changed ledger rows individually.
  const finances = [...new Set((db.Finance_Details ?? []).map(f => f.Finance_Name))]
  for (const f of finances) {
    await sReplaceFinance('Deposit_Amount', f, (db.Deposit_Amount ?? []).filter(d => d.Finance_Name === f))
    await sReplaceFinance('Other_Finance_Loan', f, (db.Other_Finance_Loan ?? []).filter(o => o.Finance_Name === f))
    await sReplaceFinance('Depositer_Interest', f, (db.Depositer_Interest ?? []).filter((i: any) => i.Finance_Name === f))
  }
  for (const t of changedLedger) await sUpdate('Transaction_Ledger', String(t.Ref_ID), { Loan_No: t.Loan_No })

  writeLog({ Action: 'update', Entity: 'Deposit_Amount', Entity_Label: `Renumbered ${depOldToNew.size} deposit + ${finOldToNew.size} other-finance codes` })
  persist()
  return { deposits: depOldToNew.size, other: finOldToNew.size }
}

// ── Mandatory-field configuration (which columns each form requires) ──────────
export type FormKind = 'loan' | 'deposit' | 'other'
export interface FieldDef { key: string; label: string }
export const FORM_FIELDS: Record<FormKind, FieldDef[]> = {
  loan: [
    { key: 'date', label: 'Date' }, { key: 'customer', label: 'Customer' }, { key: 'amount', label: 'Amount' },
    { key: 'interestType', label: 'Interest type' }, { key: 'rate', label: 'Interest rate' },
    { key: 'bonds', label: 'Bonds received' }, { key: 'chqs', label: 'Cheques received' },
    { key: 'partner', label: 'Referred partner' }, { key: 'payType', label: 'Payment type' },
  ],
  deposit: [
    { key: 'name', label: 'Depositor' }, { key: 'amount', label: 'Amount' }, { key: 'date', label: 'Date' },
    { key: 'rate', label: 'Rate' }, { key: 'phone', label: 'Phone' }, { key: 'payType', label: 'Payment type' },
  ],
  other: [
    { key: 'lender', label: 'Finance name' }, { key: 'amount', label: 'Amount' }, { key: 'date', label: 'Date' },
    { key: 'rate', label: 'Rate' }, { key: 'phone', label: 'Phone' }, { key: 'payType', label: 'Payment type' },
  ],
}
export type MandatoryConfig = Record<FormKind, string[]>
const MAND_DEFAULT: MandatoryConfig = {
  loan: ['date', 'customer', 'amount', 'interestType', 'rate'],
  deposit: ['name', 'amount', 'date', 'rate'],
  other: ['lender', 'amount', 'rate', 'date'],
}
const MAND_KEY = 'arul-finance:mandatory:v1'
export function getMandatory(): MandatoryConfig {
  try { return { ...MAND_DEFAULT, ...JSON.parse(localStorage.getItem(MAND_KEY) || '{}') } }
  catch { return { ...MAND_DEFAULT } }
}
export function setMandatory(c: MandatoryConfig): void { localStorage.setItem(MAND_KEY, JSON.stringify(c)) }

// ── Expense / Other-income categories (configurable in Settings) ─────────────
export interface LedgerCategories { expense: string[]; income: string[] }
const CAT_DEFAULT: LedgerCategories = {
  expense: ['Salary', 'Rent', 'Office', 'Travel', 'Interest paid', 'Commission', 'Printing', 'Miscellaneous'],
  income: ['Commission', 'Document charge', 'Penalty', 'Processing fee', 'Interest income', 'Miscellaneous'],
}
const CAT_KEY = 'arul-finance:ledger-cats:v1'
export function getLedgerCategories(): LedgerCategories {
  try {
    const saved = JSON.parse(localStorage.getItem(CAT_KEY) || '{}')
    return { expense: saved.expense ?? CAT_DEFAULT.expense, income: saved.income ?? CAT_DEFAULT.income }
  } catch { return { ...CAT_DEFAULT } }
}
export function setLedgerCategories(c: LedgerCategories): void { localStorage.setItem(CAT_KEY, JSON.stringify(c)) }

// Nature strings for the two manual ledger entries; the profit summary keys off these.
export const EXPENSE_NATURE = 'Expense'
export const OTHER_INCOME_NATURE = 'Other_Income'

export interface ManualEntryInput { finance: string; amount: number; category: string; note?: string; date: string; payType?: string }

export async function addExpense(e: ManualEntryInput): Promise<void> {
  const desc = e.note ? `${e.category} — ${e.note}` : e.category
  await recordLedger({
    Nature_Transaction: EXPENSE_NATURE, Description: desc, Customer_Name: e.category,
    Payment_Amount: num(e.amount), Payment_Type: e.payType, Finance_Name: e.finance, Date_Transaction: e.date,
  })
  writeLog({ Action: 'create', Entity: 'Transaction_Ledger', Entity_Label: `Expense · ${e.category} · ${inrFmt(num(e.amount))}` })
  persist()
}

export async function addOtherIncome(e: ManualEntryInput): Promise<void> {
  const desc = e.note ? `${e.category} — ${e.note}` : e.category
  await recordLedger({
    Nature_Transaction: OTHER_INCOME_NATURE, Description: desc, Customer_Name: e.category,
    Receipt_Amount: num(e.amount), Payment_Type: e.payType, Finance_Name: e.finance, Date_Transaction: e.date,
  })
  writeLog({ Action: 'create', Entity: 'Transaction_Ledger', Entity_Label: `Other income · ${e.category} · ${inrFmt(num(e.amount))}` })
  persist()
}

// Given a form's values, return the list of required fields that are still empty.
export function missingRequired(kind: FormKind, values: Record<string, unknown>): string[] {
  const req = getMandatory()[kind] ?? []
  return req.filter(k => {
    const v = values[k]
    return v === undefined || v === null || String(v).trim() === '' || v === false
  })
}

// ── Messaging ────────────────────────────────────────────────────────────────
export interface Contact { phone: string; name: string; role: 'md' | 'partner' | 'worker'; finance?: string }

// Everyone who can log in — used for the group broadcast and the contact picker.
export function allContacts(): Contact[] {
  const out: Contact[] = []
  for (const f of db.Finance_Details ?? []) {
    if (f.Phone_Number != null) out.push({ phone: String(f.Phone_Number), name: f.MD_Name || 'MD', role: 'md', finance: f.Finance_Name })
  }
  for (const p of db.Partner ?? []) {
    if (p.Phone_Number != null) out.push({ phone: String(p.Phone_Number), name: p.Partner_Name, role: 'partner', finance: p.Finance_Name })
  }
  for (const w of db.Worker ?? []) {
    if (w.Phone_Number != null) out.push({ phone: String(w.Phone_Number), name: w.Worker_Name, role: 'worker', finance: w.Finance_Name })
  }
  // De-dup by phone (MD takes precedence, added first).
  const seen = new Set<string>()
  return out.filter(c => (seen.has(c.phone) ? false : (seen.add(c.phone), true)))
}

// Messages visible to a phone: all group messages + directs to/from them.
export function messagesFor(phone: string): Message[] {
  return (db.Message ?? [])
    .filter(m => m.Scope === 'group' || m.From_Phone === phone || m.To_Phone === phone)
    .slice()
    .sort((a, b) => new Date(a.Date).getTime() - new Date(b.Date).getTime())
}

export async function sendMessage(msg: Omit<Message, 'id' | 'Date'>): Promise<void> {
  const row: Message = { id: `M-${Date.now()}-${Math.random().toString(36).slice(2, 6)}`, Date: new Date().toISOString(), ...msg }
  db.Message = [...(db.Message ?? []), row]
  await sInsert('Message', row)
  // Bell the recipient(s).
  const recipients = row.Scope === 'group'
    ? allContacts().filter(c => c.phone !== row.From_Phone)
    : allContacts().filter(c => c.phone === row.To_Phone)
  for (const r of recipients) {
    await addNotification({
      Finance_Name: row.Finance_Name ?? r.finance ?? '',
      To_Phone: r.phone,
      To_Party: r.name,
      Title: row.Scope === 'group' ? `Group message · ${row.From_Name}` : `Message · ${row.From_Name}`,
      Body: row.Body.slice(0, 80),
    })
  }
  persist()
}

// ── Partner modify / delete (MD) ─────────────────────────────────────────────
export async function updatePartner(id: string, patch: Partial<Partner>): Promise<void> {
  const before = (db.Partner ?? []).find(p => p.Partner_ID === id)
  db.Partner = (db.Partner ?? []).map(p => p.Partner_ID === id ? { ...p, ...patch } : p)
  const after = (db.Partner ?? []).find(p => p.Partner_ID === id)
  await sUpdate('Partner', id, patch)
  writeLog({ Action: 'update', Entity: 'Partner', Entity_Label: `${after?.Partner_Name} (${id})`, Before: before, After: after })
  persist()
}

export async function deletePartner(id: string): Promise<void> {
  const row = (db.Partner ?? []).find(p => p.Partner_ID === id)
  if (!row) return
  db.Partner = (db.Partner ?? []).filter(p => p.Partner_ID !== id)
  await sDelete('Partner', id)
  writeLog({ Action: 'delete', Entity: 'Partner', Entity_Label: `${row.Partner_Name} (${id})`, Before: row })
  persist()
}

// ── Interest details: admin edit + revoke a posted period ────────────────────
export async function updateInterestRow(id: string, patch: Partial<InterestRow>): Promise<void> {
  const before = (db.Interest_Details ?? []).find(i => i.ID === id)
  db.Interest_Details = (db.Interest_Details ?? []).map(i => i.ID === id ? { ...i, ...patch } : i)
  const after = (db.Interest_Details ?? []).find(i => i.ID === id)
  await sUpdate('Interest_Details', id, patch)
  if (after?.Customer_STL_NO) recomputeCustomer(after.Customer_STL_NO)
  writeLog({ Action: 'update', Entity: 'Interest_Details', Entity_Label: `${after?.Loan_No} · ${after?.Month}`, Before: before, After: after })
  persist()
}

const rup_ = (n: number) => `₹${Math.round(num(n)).toLocaleString('en-IN')}`

// Add a customer interest row by hand (admin correction). Logged; recomputes
// the customer's roll-up totals.
export async function addInterestRow(input: Omit<InterestRow, 'ID'> & { ID?: string }): Promise<InterestRow> {
  const loan = (db.Loan_Processing ?? []).find(l => l.Loan_No === input.Loan_No)
  const received = num(input.Amount_Received)
  const amount = num(input.Interest_Amount)
  const row: InterestRow = {
    Amount_Received: received, Status: input.Status ?? (received >= amount && amount > 0 ? 'Paid' : received > 0 ? 'Partial' : 'Pending'),
    Referred_Partner: input.Referred_Partner ?? loan?.Referred_Partner,
    Interest_Type: input.Interest_Type ?? loan?.Interest_Type,
    ...input,
    Interest_Pending: input.Interest_Pending ?? Math.max(0, amount - received),
    ID: input.ID || `${input.Customer_STL_NO}-${input.Loan_No}-${input.Month}-manual-${Date.now()}`,
  }
  db.Interest_Details = [...(db.Interest_Details ?? []), row]
  await sInsert('Interest_Details', row)
  if (row.Customer_STL_NO) recomputeCustomer(row.Customer_STL_NO)
  writeLog({ Action: 'create', Entity: 'Interest_Details', Entity_Label: `${row.Loan_No} · ${row.Month} · ${rup_(amount)}`, After: row })
  persist()
  return row
}

// Delete a customer interest row (reversible from the log); recomputes customer.
export async function deleteInterestRow(id: string): Promise<void> {
  const row = (db.Interest_Details ?? []).find(i => i.ID === id)
  if (!row) return
  db.Interest_Details = (db.Interest_Details ?? []).filter(i => i.ID !== id)
  await sDelete('Interest_Details', id)
  if (row.Customer_STL_NO) recomputeCustomer(row.Customer_STL_NO)
  writeLog({ Action: 'delete', Entity: 'Interest_Details', Entity_Label: `${row.Loan_No} · ${row.Month} · ${rup_(num(row.Interest_Amount))}`, Before: row })
  persist()
}

// ── Depositor & other-finance interest: admin add / edit / delete (logged) ───
// These two schedules are plain rows keyed by ID; deletes are restorable.
async function addSideInterest(table: 'Depositer_Interest' | 'Other_Finance_Interest', input: any, label: string): Promise<void> {
  const amount = num(input.Interest_Amount), received = num(input.Amount_Received)
  const row = {
    Amount_Received: received, Status: received >= amount && amount > 0 ? 'Paid' : received > 0 ? 'Partial' : 'Pending',
    ...input,
    Interest_Pending: input.Interest_Pending ?? Math.max(0, amount - received),
    ID: input.ID || `${label}-${input.Month}-manual-${Date.now()}`,
  }
  ;(db as any)[table] = [...((db as any)[table] ?? []), row]
  await sInsert(table, row)
  writeLog({ Action: 'create', Entity: table, Entity_Label: `${label} · ${input.Month} · ${rup_(amount)}`, After: row })
  persist()
}
async function updateSideInterest(table: 'Depositer_Interest' | 'Other_Finance_Interest', id: string, patch: any, label: string): Promise<void> {
  const before = ((db as any)[table] ?? []).find((i: any) => i.ID === id)
  ;(db as any)[table] = ((db as any)[table] ?? []).map((i: any) => i.ID === id ? { ...i, ...patch } : i)
  await sUpdate(table, id, patch)
  writeLog({ Action: 'update', Entity: table, Entity_Label: `${label} · ${patch.Month ?? before?.Month}`, Before: before, After: ((db as any)[table] ?? []).find((i: any) => i.ID === id) })
  persist()
}
async function deleteSideInterest(table: 'Depositer_Interest' | 'Other_Finance_Interest', id: string, label: string): Promise<void> {
  const row = ((db as any)[table] ?? []).find((i: any) => i.ID === id)
  if (!row) return
  ;(db as any)[table] = ((db as any)[table] ?? []).filter((i: any) => i.ID !== id)
  await sDelete(table, id)
  writeLog({ Action: 'delete', Entity: table, Entity_Label: `${label} · ${row.Month} · ${rup_(num(row.Interest_Amount))}`, Before: row })
  persist()
}

export const addDepositInterestRow = (input: any) => addSideInterest('Depositer_Interest', input, input.Deposit_No)
export const updateDepositInterestRow = (id: string, patch: any) => updateSideInterest('Depositer_Interest', id, patch, patch.Deposit_No ?? '')
export const deleteDepositInterestRow = (id: string) => deleteSideInterest('Depositer_Interest', id, '')
export const addOtherFinanceInterestRow = (input: any) => addSideInterest('Other_Finance_Interest', input, input.Loan_No)
export const updateOtherFinanceInterestRow = (id: string, patch: any) => updateSideInterest('Other_Finance_Interest', id, patch, patch.Loan_No ?? '')
export const deleteOtherFinanceInterestRow = (id: string) => deleteSideInterest('Other_Finance_Interest', id, '')

// Rows created by a repayment/partial-closure carry "-repay-" in their ID (see
// repayLoan and the repay modals). A monthly-posting row never does. Revoke must
// touch ONLY the monthly postings and leave partial-repayment interest alone.
export const isRepayInterest = (id?: string) => String(id ?? '').includes('-repay-')

// Revoke the MONTHLY interest posting for a finance + month — the full, symmetric
// reversal of a "Post all interest" run, so the month can be posted again:
//   • delete the monthly rows in all three interest tables (repayment/partial-
//     closure rows, which carry "-repay-" in their ID, are deliberately KEPT);
//   • roll each entity's Interest_Posted_Upto BACK to its latest remaining monthly
//     posting (or the prior month end), so the preview bills the month again;
//   • drop the posting-register row, so the month no longer reads as "posted".
// Reversible from the Activity Log. `month` is "MM-YYYY" (how interest rows store
// it); the register uses "YYYY-MM".
export async function revokeInterestForMonth(finance: string, month: string): Promise<number> {
  const [mm, yy] = month.split('-')
  const ym = `${yy}-${mm}`
  // Last day of the month BEFORE the revoked one — the posted-till fallback when an
  // entity has no earlier monthly posting left.
  const pd = new Date(Number(yy), Number(mm) - 1, 0)
  const priorEnd = `${pd.getFullYear()}-${String(pd.getMonth() + 1).padStart(2, '0')}-${String(pd.getDate()).padStart(2, '0')}`
  const isMonthly = (r: any) => !isRepayInterest(r.ID)
  // An entity's true posted-till after this revoke = its latest remaining monthly
  // To_Date, else the prior month end.
  const rollbackTill = (rows: any[], keyField: string, key: string) =>
    rows.filter(r => r[keyField] === key && isMonthly(r) && r.To_Date).map(r => String(r.To_Date)).sort().slice(-1)[0] ?? priorEnd

  let total = 0

  // 1) Customer loan interest.
  const custRemoved = (db.Interest_Details ?? []).filter(i => i.Finance_Name === finance && i.Month === month && isMonthly(i))
  if (custRemoved.length) {
    const ids = new Set(custRemoved.map(r => r.ID))
    db.Interest_Details = (db.Interest_Details ?? []).filter(i => !ids.has(i.ID))
    if (supabase) { const { error } = await supabase.from('Interest_Details').delete().in('ID', [...ids]); noteErr('delete Interest_Details', error?.message) }
    for (const stl of new Set(custRemoved.map(r => r.Customer_STL_NO))) {
      if (!stl) continue
      recomputeCustomer(stl)
      await markCustomerPostedUpto(stl, rollbackTill(db.Interest_Details ?? [], 'Customer_STL_NO', stl))
    }
    writeLog({ Action: 'revoke', Entity: 'Interest_Details', Entity_Label: `${finance} · ${month} · ${custRemoved.length} monthly rows`, Before: custRemoved })
    total += custRemoved.length
  }

  // 2) Deposit interest (owed to depositors).
  const depRemoved = (db.Depositer_Interest ?? []).filter((i: any) => i.Finance_Name === finance && i.Month === month && isMonthly(i))
  if (depRemoved.length) {
    const ids = new Set(depRemoved.map((r: any) => r.ID))
    db.Depositer_Interest = (db.Depositer_Interest ?? []).filter((i: any) => !ids.has(i.ID))
    if (supabase) { const { error } = await supabase.from('Depositer_Interest').delete().in('ID', [...ids]); noteErr('delete Depositer_Interest', error?.message) }
    for (const code of new Set(depRemoved.map((r: any) => r.Deposit_No))) {
      if (!code) continue
      await markDepositPostedUpto(code, rollbackTill(db.Depositer_Interest ?? [], 'Deposit_No', code))
    }
    writeLog({ Action: 'revoke', Entity: 'Depositer_Interest', Entity_Label: `${finance} · ${month} · ${depRemoved.length} monthly rows`, Before: depRemoved })
    total += depRemoved.length
  }

  // 3) Other-finance interest (owed to lenders).
  const othRemoved = (db.Other_Finance_Interest ?? []).filter((i: any) => i.Finance_Name === finance && i.Month === month && isMonthly(i))
  if (othRemoved.length) {
    const ids = new Set(othRemoved.map((r: any) => r.ID))
    db.Other_Finance_Interest = (db.Other_Finance_Interest ?? []).filter((i: any) => !ids.has(i.ID))
    if (supabase) { const { error } = await supabase.from('Other_Finance_Interest').delete().in('ID', [...ids]); noteErr('delete Other_Finance_Interest', error?.message) }
    for (const code of new Set(othRemoved.map((r: any) => r.Loan_No))) {
      if (!code) continue
      await markOtherFinancePostedUpto(code, rollbackTill(db.Other_Finance_Interest ?? [], 'Loan_No', code))
    }
    writeLog({ Action: 'revoke', Entity: 'Other_Finance_Interest', Entity_Label: `${finance} · ${month} · ${othRemoved.length} monthly rows`, Before: othRemoved })
    total += othRemoved.length
  }

  // 4) Clear the posting-register entry so the month is postable again.
  const logRemoved = (db.Interest_Posting_Log ?? []).filter(r => r.Finance_Name === finance && r.Month === ym)
  if (logRemoved.length) {
    const ids = new Set(logRemoved.map(r => r.ID))
    db.Interest_Posting_Log = (db.Interest_Posting_Log ?? []).filter(r => !ids.has(r.ID))
    if (supabase) { const { error } = await supabase.from('Interest_Posting_Log').delete().in('ID', [...ids]); noteErr('delete Interest_Posting_Log', error?.message) }
  }

  persist()
  return total
}

// Revoke (cancel) a chit auction and everything it created — its per-member due
// rows and any takers — reversing the chit + member roll-ups. Fully reversible
// from the Activity Log.
export async function revokeChitAuction(auctionId: string): Promise<void> {
  const auction = (db.Chit_Auction ?? []).find(a => a.Chit_Auction_ID === auctionId)
  if (!auction) return
  const chitId = auction.Chit_ID
  const ledger = (db.Chit_Ledger ?? []).filter(r => r.Chit_Auction_ID === auctionId)
  const takers = (db.Chit_Taken_Member ?? []).filter(t => t.Chit_Auction_ID === auctionId)

  // Snapshot the member + chit rows we'll change, so restore can put them back.
  const affected = [...new Set(takers.map(t => t.Member_ID))]
  const memberBefore = (db.Chit_Member ?? []).filter(m => affected.includes(m.Member_ID)).map(m => ({ ...m }))
  const chitRow = (db.Chit_Creation ?? []).find(c => c.Chit_ID === chitId)
  const chitBefore = chitRow ? { ...chitRow } : undefined

  // Reverse each taker's effect on its member row.
  for (const t of takers) {
    const member = (db.Chit_Member ?? []).find(m => m.Member_ID === t.Member_ID)
    if (!member) continue
    const takenElsewhere = (db.Chit_Taken_Member ?? []).some(x =>
      x.Member_ID === t.Member_ID && x.Chit_ID === chitId &&
      x.Chit_Auction_ID !== auctionId && x.Member_Type !== 'Company_Topup')
    const patch: Partial<ChitMember> = {
      Chit_Taken_Amount: Math.max(0, num(member.Chit_Taken_Amount) - num(t.Total_Amount_to_Member)),
      Total_Auction_Amount: Math.max(0, num(member.Total_Auction_Amount) - num(t.Total_Amount_to_Member)),
      Amount_Given: Math.max(0, num(member.Amount_Given) - num(t.Amount_Given_to_Member)),
      Remaining_Amount: Math.max(0, num(member.Remaining_Amount) - num(t.Pending_Amount)),
    }
    if (!takenElsewhere) patch.Chit_Taken = 'Not_Taken'
    db.Chit_Member = (db.Chit_Member ?? []).map(m => m.Member_ID === t.Member_ID ? { ...m, ...patch } : m)
    await sUpdate('Chit_Member', t.Member_ID, patch)
  }

  // Delete the auction, its dues and its takers.
  db.Chit_Auction = (db.Chit_Auction ?? []).filter(a => a.Chit_Auction_ID !== auctionId)
  db.Chit_Ledger = (db.Chit_Ledger ?? []).filter(r => r.Chit_Auction_ID !== auctionId)
  db.Chit_Taken_Member = (db.Chit_Taken_Member ?? []).filter(t => t.Chit_Auction_ID !== auctionId)
  await sDelete('Chit_Auction', auctionId)
  for (const r of ledger) await sDelete('Chit_Ledger', r.ID)
  for (const t of takers) await sDelete('Chit_Taken_Member', t.Chit_Taken_ID)

  // Undo this auction's contribution to the chit roll-ups: month count drops to
  // the latest remaining auction, shares-taken loses exactly this auction's takers.
  if (chitRow) {
    const remaining = (db.Chit_Auction ?? []).filter(a => a.Chit_ID === chitId)
    const maxMonth = remaining.reduce((m, a) => Math.max(m, num(a.Month_Count)), 0)
    const revokedPct = takers.reduce((s, t) => s + num(t.Percentage_Need_to_Take), 0)
    const newTaken = Math.max(0, num(chitRow.Total_Member_Taken) - revokedPct)
    await updateChit(chitId, { No_Month_Completed: maxMonth, Total_Member_Taken: newTaken })
  }

  writeLog({
    Action: 'revoke', Entity: 'Chit_Auction',
    Entity_Label: `${auction.Chit_Name ?? chitId} · month ${num(auction.Month_Count)} · ${ledger.length} dues, ${takers.length} taker(s)`,
    Before: { auction, ledger, takers, members: memberBefore, chit: chitBefore },
  })
  persist()
}

// ── Restore a deleted / revoked entry from the log ───────────────────────────
export async function restoreFromLog(logId: string): Promise<void> {
  const entry = (db.Log ?? []).find(l => l.id === logId)
  if (!entry || entry.Restored || (entry.Action !== 'delete' && entry.Action !== 'revoke')) return

  // Composite restore for a revoked chit auction (spans several tables).
  if (entry.Entity === 'Chit_Auction' && entry.Before && !Array.isArray(entry.Before)) {
    const b = entry.Before as {
      auction: ChitAuction; ledger: ChitLedgerRow[]; takers: ChitTakenMember[]
      members?: ChitMember[]; chit?: ChitCreation
    }
    if (b.auction) { db.Chit_Auction = [b.auction, ...(db.Chit_Auction ?? [])]; await sInsert('Chit_Auction', b.auction) }
    if (b.ledger?.length) { db.Chit_Ledger = [...b.ledger, ...(db.Chit_Ledger ?? [])]; await sInsert('Chit_Ledger', b.ledger) }
    if (b.takers?.length) { db.Chit_Taken_Member = [...b.takers, ...(db.Chit_Taken_Member ?? [])]; await sInsert('Chit_Taken_Member', b.takers) }
    if (b.members?.length) for (const m of b.members) {
      db.Chit_Member = (db.Chit_Member ?? []).map(x => x.Member_ID === m.Member_ID ? m : x); await sUpdate('Chit_Member', m.Member_ID, m)
    }
    if (b.chit) { db.Chit_Creation = (db.Chit_Creation ?? []).map(c => c.Chit_ID === b.chit!.Chit_ID ? b.chit! : c); await sUpdate('Chit_Creation', b.chit.Chit_ID, b.chit) }
    db.Log = (db.Log ?? []).map(l => l.id === logId ? { ...l, Restored: true } : l)
    await sUpdate('Log', logId, { Restored: true })
    writeLog({ Action: 'restore', Entity: 'Chit_Auction', Entity_Label: entry.Entity_Label })
    persist()
    return
  }

  const table = entry.Entity as keyof Dataset
  const rows = Array.isArray(entry.Before) ? entry.Before : [entry.Before]
  ;(db as any)[table] = [...rows, ...((db as any)[table] ?? [])]
  await sInsert(table, rows)
  if (entry.Entity === 'Interest_Details' || entry.Entity === 'Loan_Processing') {
    new Set(rows.map((r: any) => r.Customer_STL_NO)).forEach((stl: any) => stl && recomputeCustomer(stl))
  }
  db.Log = (db.Log ?? []).map(l => l.id === logId ? { ...l, Restored: true } : l)
  await sUpdate('Log', logId, { Restored: true })
  writeLog({ Action: 'restore', Entity: entry.Entity, Entity_Label: entry.Entity_Label, After: rows })
  persist()
}

// Recompute a customer's roll-up figures from the underlying loan & interest rows
// so the numbers stay correct no matter which flow changed them.
export function recomputeCustomer(stl: string): void {
  const cust = (db.STL_CRM ?? []).find(c => c.Customer_STL_NO === stl)
  if (!cust) return
  const loans = (db.Loan_Processing ?? []).filter(l => l.Customer_STL_NO === stl)
  const interest = (db.Interest_Details ?? []).filter(i => i.Customer_STL_NO === stl)
  const rollup = {
    Total_Loan_Given: loans.reduce((s, l) => s + num(l.Loan_Amount), 0),
    Outstand_Loan: loans.reduce((s, l) => s + num(l.Outstand_Amount), 0),
    Total_Interest_Paid: interest.reduce((s, i) => s + num(i.Amount_Received), 0),
    Outstanding_Interest: interest.reduce((s, i) => s + num(i.Interest_Pending), 0),
  }
  db.STL_CRM = (db.STL_CRM ?? []).map(c => c.Customer_STL_NO === stl ? { ...c, ...rollup } : c)
  void sUpdate('STL_CRM', stl, rollup)
}

// Customer risk from unpaid interest: count distinct months still pending.
export function customerRisk(stl: string): { level: 'low' | 'medium' | 'high'; months: number } {
  const months = new Set(
    (db.Interest_Details ?? [])
      .filter(i => i.Customer_STL_NO === stl && num(i.Interest_Pending) > 0 && i.Month)
      .map(i => i.Month as string),
  ).size
  const level = months >= 6 ? 'high' : months >= 3 ? 'medium' : 'low'
  return { level, months }
}

// One-shot customer repayment — no loan picker. Principal is applied to the
// customer's outstanding loans oldest-first; interest settles pending interest
// oldest-first. The ledger gets TWO separate entries (principal + interest).
export async function repayCustomer(opts: { stl: string; principal: number; interest: number; accrualInterest?: number; date: string; payType?: string; note?: string; accruals?: InterestRow[]; targetLoanNo?: string }): Promise<void> {
  const { stl, principal, interest, accrualInterest, date, payType, note, accruals, targetLoanNo } = opts
  const noteSuffix = note ? ` · ${note}` : ''
  const cust = (db.STL_CRM ?? []).find(c => c.Customer_STL_NO === stl)
  if (!cust) return
  const finance = cust.Finance_Name

  // 0) Post any freshly-accrued interest (up to the repay date) as new pending
  //    rows, so it joins the pool that the interest settlement below draws from.
  if (accruals && accruals.length) {
    db.Interest_Details = [...(db.Interest_Details ?? []), ...accruals]
    await sInsert('Interest_Details', accruals)
  }

  // 1) Principal → the chosen loan only, or oldest loan first when none chosen.
  let leftP = principal
  const loans = (db.Loan_Processing ?? [])
    .filter(l => l.Customer_STL_NO === stl && num(l.Outstand_Amount) > 0 && (!targetLoanNo || l.Loan_No === targetLoanNo))
    .sort((a, b) => new Date(a.Loan_Given_Date ?? 0).getTime() - new Date(b.Loan_Given_Date ?? 0).getTime())
  for (const l of loans) {
    if (leftP <= 0) break
    const out = num(l.Outstand_Amount)
    const pay = Math.min(out, leftP); leftP -= pay
    const newOut = out - pay
    await updateLoan(l.Loan_No, { Repaid_Amount: num(l.Repaid_Amount) + pay, Outstand_Amount: newOut, Loan_Status: newOut === 0 ? 'Closed' : l.Loan_Status })
  }
  const paidPrincipal = principal - leftP

  // 2) Interest → two independent buckets, each settled oldest-first:
  //    • `interest`        pays the PREVIOUS pending interest (excludes accruals)
  //    • `accrualInterest` pays THIS repayment's accrued interest (the accrual rows)
  const accrualIds = new Set<string>((accruals ?? []).map(a => a.ID))
  const pendingRows = (db.Interest_Details ?? [])
    .filter(i => i.Customer_STL_NO === stl && num(i.Interest_Pending) > 0)
  const sPrev = settleInterest(pendingRows.filter(i => !accrualIds.has(i.ID)), interest)
  const sAcc = settleInterest(pendingRows.filter(i => accrualIds.has(i.ID)), accrualInterest ?? 0)
  const payById = new Map<string, number>([...sPrev.paidById, ...sAcc.paidById])
  const changed: InterestRow[] = []
  db.Interest_Details = (db.Interest_Details ?? []).map(i => {
    const pay = payById.get(i.ID)
    if (!pay) return i
    const pend = num(i.Interest_Pending)
    const upd = { ...i, Amount_Received: num(i.Amount_Received) + pay, Interest_Pending: pend - pay, Status: pend - pay <= 0 ? 'Paid' : 'Partial' }
    changed.push(upd)
    return upd
  })
  const paidInterest = sPrev.paid + sAcc.paid

  // 3) Two separate ledger entries.
  if (paidPrincipal > 0) await recordLedger({
    Nature_Transaction: 'Customer_Loan_Prin_Repayment', STL_No: stl, Customer_Name: cust.Customer_Name,
    Description: `Principal repayment — ${cust.Customer_Name}${noteSuffix}`, Receipt_Amount: paidPrincipal,
    Payment_Type: payType, Finance_Name: finance, Date_Transaction: date,
  })
  if (paidInterest > 0) await recordLedger({
    Nature_Transaction: 'Customer_Interest', STL_No: stl, Customer_Name: cust.Customer_Name,
    Description: `Interest received — ${cust.Customer_Name}${noteSuffix}`, Receipt_Amount: paidInterest, Interest_Amount: paidInterest,
    Payment_Type: payType, Finance_Name: finance, Date_Transaction: date,
  })
  for (const r of changed) await sUpdate('Interest_Details', r.ID, { Amount_Received: r.Amount_Received, Interest_Pending: r.Interest_Pending, Status: r.Status })
  recomputeCustomer(stl)
  writeLog({ Action: 'update', Entity: 'Loan_Processing', Entity_Label: `Repay ${cust.Customer_Name} · principal ₹${paidPrincipal.toLocaleString('en-IN')} + interest ₹${paidInterest.toLocaleString('en-IN')}` })
  persist()
}

export interface RepayOptions {
  loanNo: string
  principal: number
  date: string
  paymentType?: string
  // Interest that accrued on the closed amount up to `date`, not yet posted.
  accrue?: { from: string; to: string; amount: number; month: string }
  // true = customer pays all pending interest (incl. the accrual) now;
  // false = it is left as pending interest.
  payInterest: boolean
  // Optional exact interest amount the customer is paying now. When given it
  // overrides `payInterest`: pending interest is settled oldest-first up to this
  // amount, and anything left over stays as pending interest.
  interestPaid?: number
  // Optional free-text note/remark stored on the ledger entries.
  note?: string
}

export async function repayLoan(opts: RepayOptions): Promise<void> {
  const { loanNo, principal, date, paymentType, accrue, payInterest } = opts
  const noteSuffix = opts.note ? ` · ${opts.note}` : ''
  const loan = (db.Loan_Processing ?? []).find(l => l.Loan_No === loanNo)
  if (!loan) return

  const newOut = Math.max(0, num(loan.Outstand_Amount) - principal)
  await updateLoan(loanNo, {
    Repaid_Amount: num(loan.Repaid_Amount) + principal,
    Outstand_Amount: newOut,
    Loan_Status: newOut === 0 ? 'Closed' : loan.Loan_Status,
  })

  // 1) Charge interest on the closed amount up to the repay date, as a new row.
  if (accrue && accrue.amount > 0) {
    const row: InterestRow = {
      ID: `${loan.Customer_Name}-${loan.Customer_STL_NO}-${loanNo}-${accrue.month}-repay-${Date.now()}`,
      Finance_Name: loan.Finance_Name, Loan_No: loanNo,
      Customer_STL_NO: loan.Customer_STL_NO, Customer_Name: loan.Customer_Name,
      From_Date: accrue.from, To_Date: accrue.to, Interest_Amount: accrue.amount,
      Loan_Amount: principal, Month: accrue.month,
      Description: `Interest on ₹${num(principal).toLocaleString('en-IN')} repaid — ${loanNo}`,
      Amount_Received: 0, Status: 'Pending', Interest_Pending: accrue.amount,
      Referred_Partner: loan.Referred_Partner, Interest_Type: loan.Interest_Type,
    }
    db.Interest_Details = [...(db.Interest_Details ?? []), row]
    await sInsert('Interest_Details', row)
  }

  // 2) Principal receipt.
  if (principal > 0) {
    await recordLedger({
      Nature_Transaction: 'Customer_Loan_Prin_Repayment',
      STL_No: loan.Customer_STL_NO, Loan_No: loanNo, Customer_Name: loan.Customer_Name,
      Description: `Principal repayment — ${loanNo}${noteSuffix}`, Receipt_Amount: principal,
      Payment_Type: paymentType, Finance_Name: loan.Finance_Name, Date_Transaction: date,
    })
  }

  // 3) Settle pending interest, oldest first, up to the amount being paid.
  //    interestPaid (if given) wins; otherwise payInterest means "pay all".
  let target = opts.interestPaid !== undefined
    ? Math.max(0, opts.interestPaid)
    : (payInterest ? Infinity : 0)
  if (target > 0) {
    let settled = 0
    const changed: InterestRow[] = []
    const pendingRows = (db.Interest_Details ?? [])
      .filter(r => r.Loan_No === loanNo && num(r.Interest_Pending) > 0)
      .sort((a, b) => String(a.To_Date ?? '').localeCompare(String(b.To_Date ?? '')))
    for (const r of pendingRows) {
      if (target <= 0) break
      const pending = num(r.Interest_Pending)
      const pay = Math.min(pending, target)
      target -= pay; settled += pay
      r.Amount_Received = num(r.Amount_Received) + pay
      r.Interest_Pending = pending - pay
      r.Status = r.Interest_Pending <= 0 ? 'Paid' : 'Pending'
      changed.push(r)
    }
    for (const r of changed) await sUpdate('Interest_Details', r.ID, { Amount_Received: r.Amount_Received, Interest_Pending: r.Interest_Pending, Status: r.Status })
    if (settled > 0) {
      await recordLedger({
        Nature_Transaction: 'Customer_Interest',
        STL_No: loan.Customer_STL_NO, Loan_No: loanNo, Customer_Name: loan.Customer_Name,
        Description: `Interest received — ${loanNo}${noteSuffix}`, Receipt_Amount: settled, Interest_Amount: settled,
        Payment_Type: paymentType, Finance_Name: loan.Finance_Name, Date_Transaction: date,
      })
    }
  }

  recomputeCustomer(loan.Customer_STL_NO)
  writeLog({
    Action: 'update', Entity: 'Loan_Processing',
    Entity_Label: `Repay ${loanNo} · ₹${num(principal).toLocaleString('en-IN')}${payInterest ? ' + interest' : ''}`,
    Before: loan,
  })
  persist()
}

// ── Chit fund writes ─────────────────────────────────────────────────────────
// A chit is a pot the firm runs: each month every member contributes, one member
// "takes" that month's pot at auction, and the firm keeps a commission. Chit
// money lives in its own ledger (Chit_Ledger) — separate from Transaction_Ledger.
const round = (n: number) => Math.round(n)
const inrFmt = (n: number) => `₹${round(n).toLocaleString('en-IN')}`

function ledgerStatus(due: number, recv: number): string {
  const pend = due - recv
  return pend <= 0 && recv > 0 ? 'Paid' : recv > 0 ? 'Partial' : 'Pending'
}

// Next "Chit_A<n>" id for a finance.
export function nextChitId(finance: string): string {
  const max = (db.Chit_Creation ?? []).reduce((m, c) => {
    const n = Number(String(c.Chit_ID).replace(/\D/g, ''))
    return isNaN(n) ? m : Math.max(m, n)
  }, 0)
  return `Chit_A${max + 1}`
}

export async function addChit(c: ChitCreation): Promise<void> {
  const commission = round(num(c.Chit_Percentage) / 100 * num(c.Total_Amount))
  const row: ChitCreation = {
    ...c,
    Chit_Amount: c.Chit_Amount ?? num(c.Total_Amount) - commission,
    No_Month_Completed: c.No_Month_Completed ?? 0,
    Total_Member_Taken: c.Total_Member_Taken ?? 0,
    Total_Chit_Count: c.Total_Chit_Count ?? 0,
    Chit_Status: c.Chit_Status ?? 'Open',
  }
  db.Chit_Creation = [row, ...(db.Chit_Creation ?? [])]
  await sInsert('Chit_Creation', row)
  writeLog({ Action: 'create', Entity: 'Chit_Creation', Entity_Label: `${row.Chit_ID} · ${row.Chit_Name}`, After: row })
  persist()
}

export async function updateChit(chitId: string, patch: Partial<ChitCreation>): Promise<void> {
  db.Chit_Creation = (db.Chit_Creation ?? []).map(c => c.Chit_ID === chitId ? { ...c, ...patch } : c)
  await sUpdate('Chit_Creation', chitId, patch)
  persist()
}

export async function deleteChit(chitId: string): Promise<void> {
  const row = (db.Chit_Creation ?? []).find(c => c.Chit_ID === chitId)
  if (!row) return
  const members = (db.Chit_Member ?? []).filter(m => m.Chit_ID === chitId)
  const auctions = (db.Chit_Auction ?? []).filter(a => a.Chit_ID === chitId)
  const takers = (db.Chit_Taken_Member ?? []).filter(t => t.Chit_ID === chitId)
  const ledger = (db.Chit_Ledger ?? []).filter(r => r.Chit_ID === chitId)
  db.Chit_Creation = (db.Chit_Creation ?? []).filter(c => c.Chit_ID !== chitId)
  db.Chit_Member = (db.Chit_Member ?? []).filter(m => m.Chit_ID !== chitId)
  db.Chit_Auction = (db.Chit_Auction ?? []).filter(a => a.Chit_ID !== chitId)
  db.Chit_Taken_Member = (db.Chit_Taken_Member ?? []).filter(t => t.Chit_ID !== chitId)
  db.Chit_Ledger = (db.Chit_Ledger ?? []).filter(r => r.Chit_ID !== chitId)
  await sDelete('Chit_Creation', chitId)
  for (const m of members) await sDelete('Chit_Member', m.Member_ID)
  for (const a of auctions) await sDelete('Chit_Auction', a.Chit_Auction_ID)
  for (const t of takers) await sDelete('Chit_Taken_Member', t.Chit_Taken_ID)
  for (const r of ledger) await sDelete('Chit_Ledger', r.ID)
  writeLog({ Action: 'delete', Entity: 'Chit_Creation', Entity_Label: `${chitId} · ${row.Chit_Name}`, Before: { chit: row, members, auctions, takers, ledger } })
  persist()
}

// Next member id, e.g. Chit_A1_M7_Palanisamy.
function nextChitMemberId(chitId: string, name: string): string {
  const max = (db.Chit_Member ?? []).filter(m => m.Chit_ID === chitId).reduce((mx, m) => {
    const mt = String(m.Member_ID).match(/_M(\d+)_/)
    return mt ? Math.max(mx, Number(mt[1])) : mx
  }, 0)
  return `${chitId}_M${max + 1}_${String(name).trim().replace(/\s+/g, ' ')}`
}

export async function addChitMember(input: Omit<ChitMember, 'Member_ID'> & { Member_ID?: string }): Promise<ChitMember> {
  const chit = (db.Chit_Creation ?? []).find(c => c.Chit_ID === input.Chit_ID)
  const m: ChitMember = {
    Chit_Taken: 'Not_Taken', Chit_Taken_Amount: 0, Total_Auction_Amount: 0,
    Amount_Given: 0, Remaining_Amount: 0, Member_Type: 'Member',
    Member_Percentage: 1, Chit_Name: chit?.Chit_Name,
    ...input,
    Member_ID: input.Member_ID || nextChitMemberId(input.Chit_ID, input.Member_Name),
  }
  db.Chit_Member = [...(db.Chit_Member ?? []), m]
  await sInsert('Chit_Member', m)
  // Keep the chit's share count in step with its members.
  if (chit) {
    const count = (db.Chit_Member ?? []).filter(x => x.Chit_ID === chit.Chit_ID)
      .reduce((s, x) => s + num(x.Member_Percentage), 0)
    await updateChit(chit.Chit_ID, { Total_Chit_Count: count })
  }
  writeLog({ Action: 'create', Entity: 'Chit_Member', Entity_Label: `${m.Member_ID} · ${m.Member_Name}`, After: m })
  persist()
  return m
}

export interface RunAuctionInput {
  chitId: string
  date: string
  totalAuctionAmount: number    // the winning bid — what members collectively pay this month
  interestPercentage?: number   // auction discount vs the full pot (informational)
  memberType?: string           // 'Finance' waives commission (typically month 1)
}

// Run the next month's auction: create the auction row and a per-member due row.
export async function runChitAuction(inp: RunAuctionInput): Promise<ChitAuction | null> {
  const chit = (db.Chit_Creation ?? []).find(c => c.Chit_ID === inp.chitId)
  if (!chit) return null
  const month = (db.Chit_Auction ?? []).filter(a => a.Chit_ID === inp.chitId)
    .reduce((m, a) => Math.max(m, num(a.Month_Count)), 0) + 1
  const totalMonth = num(chit.Total_Month) || num(chit.No_Members) || 1
  const indiv = round(num(inp.totalAuctionAmount) / totalMonth)
  const commission = inp.memberType === 'Finance' ? 0 : round(num(chit.Chit_Percentage) / 100 * num(chit.Total_Amount))
  const afterCommission = num(inp.totalAuctionAmount) - commission
  const auction: ChitAuction = {
    Chit_Auction_ID: `${inp.chitId}_Auction_${month}`,
    Chit_ID: inp.chitId, Chit_Name: chit.Chit_Name,
    Date_Auction: inp.date, Month_Count: month,
    Total_Auction_Amount: num(inp.totalAuctionAmount),
    Indivitual_Member_Amount: indiv,
    Interest_Percentage: num(inp.interestPercentage),
    Total_Auction_Amount_After_Commission: afterCommission,
    Finance_Name: chit.Finance_Name, Auction_Status: 'Open',
    Member_Type: inp.memberType ?? 'Member', Remaining: 0,
  }
  db.Chit_Auction = [...(db.Chit_Auction ?? []), auction]
  await sInsert('Chit_Auction', auction)

  // A due row for every member, scaled by their share.
  const rows: ChitLedgerRow[] = (db.Chit_Member ?? []).filter(m => m.Chit_ID === inp.chitId).map(m => {
    const due = round(indiv * num(m.Member_Percentage))
    return {
      ID: `${m.Member_ID}_${auction.Chit_Auction_ID}`,
      Finance_Name: chit.Finance_Name, Chit_ID: inp.chitId, Chit_Name: chit.Chit_Name,
      Chit_Auction_ID: auction.Chit_Auction_ID, Month_Count: month, Date_Auction: inp.date,
      Member_ID: m.Member_ID, Member_Name: m.Member_Name, Recommended_Partner: m.Recommended_Partner,
      Member_Percentage: m.Member_Percentage, One_Share_Amount: indiv,
      Due_Amount: due, Received_Amount: 0, Pending_Amount: due, Status: 'Pending',
    }
  })
  db.Chit_Ledger = [...(db.Chit_Ledger ?? []), ...rows]
  await sInsert('Chit_Ledger', rows)
  await updateChit(inp.chitId, { No_Month_Completed: month })
  writeLog({ Action: 'create', Entity: 'Chit_Auction', Entity_Label: `${auction.Chit_Auction_ID} · month ${month} · pot ${inrFmt(afterCommission)}`, After: auction })
  persist()
  return auction
}

export interface AssignTakerInput {
  auctionId: string
  memberId: string              // a Member_ID, or 'Company_Chit'
  percentageNeedToTake: number  // 1 (full pot) or 0.5 (half)
  takeFromCompany?: number      // amount funded from the company chit pool
}

// Record the member who took (won) an auction, and the payout owed to them.
export async function assignChitTaker(inp: AssignTakerInput): Promise<void> {
  const auction = (db.Chit_Auction ?? []).find(a => a.Chit_Auction_ID === inp.auctionId)
  if (!auction) return
  const chit = (db.Chit_Creation ?? []).find(c => c.Chit_ID === auction.Chit_ID)
  const member = (db.Chit_Member ?? []).find(m => m.Member_ID === inp.memberId)
  const pct = num(inp.percentageNeedToTake) || 1
  // Per-member commission (when enabled in Settings and this member has one set):
  // payout starts from the raw bid and deducts THIS member's own commission %,
  // replacing the chit-wide commission. A 0.5 share gets 0.5 of that amount.
  const settings = getSettings()
  const hasMemberComm = member && member.Member_Commission !== undefined && member.Member_Commission !== null
  const payout = (settings.chitPerMemberCommission && hasMemberComm)
    ? round((num(auction.Total_Auction_Amount) - round(num(member!.Member_Commission) / 100 * num(chit?.Total_Amount))) * pct)
    : round(num(auction.Total_Auction_Amount_After_Commission) * pct)
  const fromCompany = Math.max(0, Math.min(round(num(inp.takeFromCompany)), repo.chitCompanyPool(auction.Chit_ID)))
  const seq = (db.Chit_Taken_Member ?? []).filter(t => t.Chit_Auction_ID === inp.auctionId).length + 1
  const taken: ChitTakenMember = {
    Chit_Taken_ID: `${inp.auctionId}_M${seq}`,
    Chit_Auction_ID: inp.auctionId, Chit_ID: auction.Chit_ID, Chit_Name: auction.Chit_Name,
    Date_Auction: auction.Date_Auction, Month_Count: auction.Month_Count,
    Total_Auction_Amount: auction.Total_Auction_Amount,
    Member_ID: inp.memberId, Member_Name: member?.Member_Name ?? (inp.memberId === 'Company_Chit' ? 'Company Chit' : inp.memberId),
    Member_Type: member?.Member_Type ?? (inp.memberId === 'Company_Chit' ? 'Company_Chit' : 'Member'),
    Percentage_Need_to_Take: pct, Total_Amount_to_Member: payout,
    Amount_Given_to_Member: 0, Pending_Amount: payout,
    Finance_Name: auction.Finance_Name, Status: 'Pending',
    Need_to_Take_From_Previous_Company_Chit: fromCompany > 0 ? 'Yes' : 'No',
    Amount_Taken_From_Company_Chit: fromCompany,
    Remaining_Amount_in_Company_Chit: fromCompany > 0 ? repo.chitCompanyPool(auction.Chit_ID) - fromCompany : undefined,
  }
  db.Chit_Taken_Member = [...(db.Chit_Taken_Member ?? []), taken]
  await sInsert('Chit_Taken_Member', taken)

  // Mark the auction closed once the month is fully taken (shares total ≥ 1).
  // With multiple takers a month may be assigned in parts (e.g. ½ + ½).
  const takenSoFar = (db.Chit_Taken_Member ?? [])
    .filter(t => t.Chit_Auction_ID === inp.auctionId && t.Member_Type !== 'Company_Topup')
    .reduce((s, t) => s + num(t.Percentage_Need_to_Take), 0)
  if (takenSoFar >= 1) {
    db.Chit_Auction = (db.Chit_Auction ?? []).map(a => a.Chit_Auction_ID === inp.auctionId ? { ...a, Auction_Status: 'Closed' } : a)
    await sUpdate('Chit_Auction', inp.auctionId, { Auction_Status: 'Closed' })
  }
  if (member) {
    const patch: Partial<ChitMember> = {
      Chit_Taken: 'Taken',
      Chit_Taken_Amount: num(member.Chit_Taken_Amount) + payout,
      Total_Auction_Amount: num(member.Total_Auction_Amount) + payout,
      Remaining_Amount: num(member.Remaining_Amount) + payout,
      Month_Taken: auction.Date_Auction,
    }
    db.Chit_Member = (db.Chit_Member ?? []).map(m => m.Member_ID === inp.memberId ? { ...m, ...patch } : m)
    await sUpdate('Chit_Member', inp.memberId, patch)
  }
  if (chit) await updateChit(chit.Chit_ID, { Total_Member_Taken: num(chit.Total_Member_Taken) + pct })
  writeLog({ Action: 'create', Entity: 'Chit_Taken_Member', Entity_Label: `${taken.Member_Name} took ${auction.Chit_Auction_ID} · ${inrFmt(payout)}`, After: taken })
  persist()
}

// Add money to the company chit pool (when it's short for a member to draw).
export async function addChitCompanyTopup(chitId: string, amount: number, date: string, note?: string): Promise<void> {
  const chit = (db.Chit_Creation ?? []).find(c => c.Chit_ID === chitId)
  if (!chit || num(amount) <= 0) return
  const n = (db.Chit_Taken_Member ?? []).filter(t => t.Chit_ID === chitId && t.Member_Type === 'Company_Topup').length + 1
  const row: ChitTakenMember = {
    Chit_Taken_ID: `${chitId}_Topup_${n}`,
    Chit_Auction_ID: '', Chit_ID: chitId, Chit_Name: chit.Chit_Name,
    Date_Auction: date, Member_ID: 'Company_Chit',
    Member_Name: note ? `Top-up — ${note}` : 'Top-up',
    Member_Type: 'Company_Topup', Total_Amount_to_Member: num(amount),
    Amount_Given_to_Member: num(amount), Pending_Amount: 0,
    Finance_Name: chit.Finance_Name, Status: 'Given',
  }
  db.Chit_Taken_Member = [...(db.Chit_Taken_Member ?? []), row]
  await sInsert('Chit_Taken_Member', row)
  writeLog({ Action: 'create', Entity: 'Chit_Taken_Member', Entity_Label: `Company pool top-up · ${chit.Chit_Name} · ${inrFmt(num(amount))}` })
  persist()
}

// Member pays (part of) their monthly due — updates the chit ledger row only.
export async function collectChitDue(ledgerId: string, amount?: number, date?: string, payType?: string, remarks?: string): Promise<void> {
  const row = (db.Chit_Ledger ?? []).find(r => r.ID === ledgerId)
  if (!row) return
  const pending = num(row.Pending_Amount)
  if (pending <= 0) return
  const pay = Math.min(num(amount) > 0 ? num(amount) : pending, pending)
  const recv = num(row.Received_Amount) + pay
  const patch: Partial<ChitLedgerRow> = {
    Received_Amount: recv, Pending_Amount: num(row.Due_Amount) - recv,
    Status: ledgerStatus(num(row.Due_Amount), recv),
    Payment_Type: payType ?? row.Payment_Type, Paid_Date: date ?? new Date().toISOString().slice(0, 10),
    Remarks: remarks ?? row.Remarks,
  }
  db.Chit_Ledger = (db.Chit_Ledger ?? []).map(r => r.ID === ledgerId ? { ...r, ...patch } : r)
  await sUpdate('Chit_Ledger', ledgerId, patch)
  writeLog({ Action: 'update', Entity: 'Chit_Ledger', Entity_Label: `Due paid — ${row.Member_Name} · month ${row.Month_Count} · ${inrFmt(pay)}`, Before: row })
  persist()
}

// Firm pays out (part of) the amount owed to a member who took a chit.
export async function payChitTaker(takenId: string, amount?: number, date?: string, payType?: string, remarks?: string): Promise<void> {
  const row = (db.Chit_Taken_Member ?? []).find(t => t.Chit_Taken_ID === takenId)
  if (!row) return
  const pending = num(row.Pending_Amount)
  if (pending <= 0) return
  const pay = Math.min(num(amount) > 0 ? num(amount) : pending, pending)
  const given = num(row.Amount_Given_to_Member) + pay
  const left = num(row.Total_Amount_to_Member) - given
  const patch: Partial<ChitTakenMember> = { Amount_Given_to_Member: given, Pending_Amount: left, Status: left <= 0 ? 'Given' : 'Pending', Remarks: remarks ?? row.Remarks }
  db.Chit_Taken_Member = (db.Chit_Taken_Member ?? []).map(t => t.Chit_Taken_ID === takenId ? { ...t, ...patch } : t)
  await sUpdate('Chit_Taken_Member', takenId, patch)

  const member = (db.Chit_Member ?? []).find(m => m.Member_ID === row.Member_ID)
  if (member) {
    const mp: Partial<ChitMember> = {
      Amount_Given: num(member.Amount_Given) + pay,
      Remaining_Amount: Math.max(0, num(member.Remaining_Amount) - pay),
      Last_Receipt: `Payout ${inrFmt(pay)} — ${payType ?? ''} — ${date ?? new Date().toISOString().slice(0, 10)}`,
    }
    db.Chit_Member = (db.Chit_Member ?? []).map(m => m.Member_ID === row.Member_ID ? { ...m, ...mp } : m)
    await sUpdate('Chit_Member', row.Member_ID, mp)
  }
  writeLog({ Action: 'update', Entity: 'Chit_Taken_Member', Entity_Label: `Payout — ${row.Member_Name} · ${inrFmt(pay)}`, Before: row })
  persist()
}

// ── Invested chit writes (chits you join at another company) ─────────────────
export async function addInvestedChit(c: InvestedChit): Promise<void> {
  const row: InvestedChit = {
    No_Months_Completed: 0, Total_Amount_Invested_Till_Now: 0,
    Chit_Status: 'Active', Chit_Taken: 'No',
    ...c,
  }
  db.Invested_Chit = [row, ...(db.Invested_Chit ?? [])]
  await sInsert('Invested_Chit', row)
  writeLog({ Action: 'create', Entity: 'Invested_Chit', Entity_Label: `${row.Chit_Name} · ${row.Chit_Invested_Company}`, After: row })
  persist()
}

export async function updateInvestedChit(chitId: string, patch: Partial<InvestedChit>): Promise<void> {
  db.Invested_Chit = (db.Invested_Chit ?? []).map(c => c.Chit_ID === chitId ? { ...c, ...patch } : c)
  await sUpdate('Invested_Chit', chitId, patch)
  persist()
}

export async function deleteInvestedChit(chitId: string): Promise<void> {
  const row = (db.Invested_Chit ?? []).find(c => c.Chit_ID === chitId)
  if (!row) return
  const trans = (db.Invested_Chit_Trans ?? []).filter(t => t.Chit_ID === chitId)
  db.Invested_Chit = (db.Invested_Chit ?? []).filter(c => c.Chit_ID !== chitId)
  db.Invested_Chit_Trans = (db.Invested_Chit_Trans ?? []).filter(t => t.Chit_ID !== chitId)
  await sDelete('Invested_Chit', chitId)
  for (const t of trans) await sDelete('Invested_Chit_Trans', t.ID)
  writeLog({ Action: 'delete', Entity: 'Invested_Chit', Entity_Label: `${row.Chit_Name} · ${row.Chit_Invested_Company}`, Before: { chit: row, trans } })
  persist()
}

export interface InvestedContributionInput {
  chitId: string
  amount: number
  date: string
  remarks?: string
}

// Record one month's contribution to an invested chit, and roll the parent up.
export async function recordInvestedContribution(inp: InvestedContributionInput): Promise<void> {
  const chit = (db.Invested_Chit ?? []).find(c => c.Chit_ID === inp.chitId)
  if (!chit) return
  const month = (db.Invested_Chit_Trans ?? []).filter(t => t.Chit_ID === inp.chitId)
    .reduce((m, t) => Math.max(m, num(t.Month_Count)), 0) + 1
  const d = new Date(inp.date)
  const monthYear = isNaN(d.getTime())
    ? undefined
    : `${d.toLocaleString('en-US', { month: 'short' })}-${d.getFullYear()}`
  const row: InvestedChitTrans = {
    ID: `${inp.chitId}-${String(inp.date).replace(/-/g, '')}-${month}`,
    Chit_ID: inp.chitId, Chit_Invested_By: chit.Chit_Invested_By,
    Chit_Invested_Company: chit.Chit_Invested_Company,
    Chit_Invested_Company_Address: chit.Chit_Invested_Company_Address,
    Total_Amount_Chit: chit.Total_Amount_Chit, No_Months: chit.No_Months,
    Chit_Started_Date: chit.Chit_Started_Date, Month_Count: month,
    Chit_This_Month_Amount: num(inp.amount), Date: inp.date, Month_Year: monthYear,
    Chit_Taken: chit.Chit_Taken, Chit_Name: chit.Chit_Name, Paid_Date: inp.date,
    Remarks: inp.remarks, Chit_Status: month >= num(chit.No_Months) ? 'Completed' : 'Active',
    Kind: 'Payment',
  }
  db.Invested_Chit_Trans = [...(db.Invested_Chit_Trans ?? []), row]
  await sInsert('Invested_Chit_Trans', row)
  await updateInvestedChit(inp.chitId, {
    No_Months_Completed: month,
    Total_Amount_Invested_Till_Now: num(chit.Total_Amount_Invested_Till_Now) + num(inp.amount),
    Chit_Status: month >= num(chit.No_Months) ? 'Completed' : 'Active',
  })
  writeLog({ Action: 'create', Entity: 'Invested_Chit_Trans', Entity_Label: `${chit.Chit_Name} · month ${month} · ${inrFmt(num(inp.amount))}`, After: row })
  persist()
}

export interface InvestedTakeInput {
  chitId: string
  amount: number      // amount you received when you took/won the chit
  date: string
  remarks?: string
}

// Record the amount you RECEIVED when you took (won) an invested chit. Adds a
// receipt row to the chit's transactions and marks the parent chit as taken.
export async function recordInvestedTake(inp: InvestedTakeInput): Promise<void> {
  const chit = (db.Invested_Chit ?? []).find(c => c.Chit_ID === inp.chitId)
  if (!chit) return
  const d = new Date(inp.date)
  const monthYear = isNaN(d.getTime())
    ? undefined
    : `${d.toLocaleString('en-US', { month: 'short' })}-${d.getFullYear()}`
  const row: InvestedChitTrans = {
    ID: `${inp.chitId}-TAKE-${String(inp.date).replace(/-/g, '')}`,
    Chit_ID: inp.chitId, Chit_Invested_By: chit.Chit_Invested_By,
    Chit_Invested_Company: chit.Chit_Invested_Company,
    Chit_Invested_Company_Address: chit.Chit_Invested_Company_Address,
    Total_Amount_Chit: chit.Total_Amount_Chit, No_Months: chit.No_Months,
    Chit_Started_Date: chit.Chit_Started_Date,
    Chit_This_Month_Amount: num(inp.amount), Date: inp.date, Month_Year: monthYear,
    Chit_Taken: 'Yes', Chit_Name: chit.Chit_Name, Paid_Date: inp.date,
    Remarks: inp.remarks, Chit_Status: chit.Chit_Status,
    Kind: 'Receipt',
  }
  db.Invested_Chit_Trans = [...(db.Invested_Chit_Trans ?? []), row]
  await sInsert('Invested_Chit_Trans', row)
  await updateInvestedChit(inp.chitId, {
    Chit_Taken: 'Yes', Chit_Taken_Amount: num(inp.amount), Chit_Taken_Date: inp.date,
  })
  writeLog({ Action: 'create', Entity: 'Invested_Chit_Trans', Entity_Label: `${chit.Chit_Name} · taken · received ${inrFmt(num(inp.amount))}`, After: row })
  persist()
}

// ── Hand exchange writes (personal — never posted to any finance ledger) ─────
export async function addHandEntry(e: Omit<HandExchange, 'ID'> & { ID?: string }): Promise<void> {
  const row: HandExchange = { ...e, ID: e.ID || `H-${Date.now()}-${Math.random().toString(36).slice(2, 6)}` }
  db.Hand_Exchange = [row, ...(db.Hand_Exchange ?? [])]
  await sInsert('Hand_Exchange', row)
  persist()
}

export async function updateHandEntry(id: string, patch: Partial<Omit<HandExchange, 'ID'>>): Promise<void> {
  db.Hand_Exchange = (db.Hand_Exchange ?? []).map(e => e.ID === id ? { ...e, ...patch } : e)
  await sUpdate('Hand_Exchange', id, patch)
  persist()
}

export async function deleteHandEntry(id: string): Promise<void> {
  db.Hand_Exchange = (db.Hand_Exchange ?? []).filter(e => e.ID !== id)
  await sDelete('Hand_Exchange', id)
  persist()
}
