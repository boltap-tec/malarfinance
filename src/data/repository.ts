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
  ledgerByRef(code: string): LedgerRow[] {
    return (db.Transaction_Ledger ?? []).filter(t => String(t.Loan_No) === code)
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
  raw<K extends keyof Dataset>(key: K): Dataset[K] { return db[key] },
}

// ── Credentials (local demo) ─────────────────────────────────────────────────
// Passwords live in their own localStorage map, default '1234', changeable.
const CRED_KEY = 'arul-finance:cred:v1'
function loadCreds(): Record<string, string> {
  try { return JSON.parse(localStorage.getItem(CRED_KEY) || '{}') } catch { return {} }
}
export function verifyCred(phone: string, password: string): boolean {
  const creds = loadCreds()
  const stored = creds[phone] ?? '1234' // default password until changed
  return stored === password
}
export function setCred(phone: string, password: string): void {
  const creds = loadCreds()
  creds[phone] = password
  localStorage.setItem(CRED_KEY, JSON.stringify(creds))
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
  Notification: 'id', Message: 'id', Log: 'id',
}
export let lastWriteError = ''
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

export async function updateLoan(loanNo: string, patch: Partial<Loan>): Promise<void> {
  db.Loan_Processing = (db.Loan_Processing ?? []).map(l =>
    l.Loan_No === loanNo ? { ...l, ...patch } : l)
  await sUpdate('Loan_Processing', loanNo, patch)
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

export async function appendInterestRows(rows: InterestRow[]): Promise<void> {
  db.Interest_Details = [...(db.Interest_Details ?? []), ...rows]
  await sInsert('Interest_Details', rows)
  persist()
}

// Post a ledger row. Ref_ID and Balance are filled automatically when omitted,
// so callers only supply the meaningful fields (nature, amounts, who/what).
export async function recordLedger(row: Partial<LedgerRow>): Promise<LedgerRow> {
  const full: LedgerRow = {
    ...row,
    Ref_ID: row.Ref_ID ?? nextRef(),
    Date_Transaction: row.Date_Transaction ?? new Date().toISOString().slice(0, 10),
    Balance: 0,
  } as LedgerRow
  db.Transaction_Ledger = [...(db.Transaction_Ledger ?? []), full]
  // Interest_Amount is a text column in the DB — send it as a string.
  await sInsert('Transaction_Ledger', { ...full, Interest_Amount: full.Interest_Amount != null ? String(full.Interest_Amount) : undefined })
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
export interface LiabilityRepay { code: string; principal: number; interest: number; date: string; payType?: string }

export async function repayDeposit(o: LiabilityRepay): Promise<void> {
  const rows = (db.Deposit_Amount ?? []).filter(d => d.Deposit_No === o.code)
  if (!rows.length) return
  let left = o.principal
  db.Deposit_Amount = (db.Deposit_Amount ?? []).map(d => {
    if (d.Deposit_No !== o.code || left <= 0) return d
    const out = num(d.Outstand_Amount)
    const pay = Math.min(out, left); left -= pay
    const newOut = out - pay
    return { ...d, Repaid_Amount: num(d.Repaid_Amount) + pay, Outstand_Amount: newOut, Deposit_Status: newOut === 0 ? 'Closed' : d.Deposit_Status }
  })
  await sReplace('Deposit_Amount', o.code, (db.Deposit_Amount ?? []).filter(d => d.Deposit_No === o.code))
  const name = rows[0].Depositer_Name, finance = rows[0].Finance_Name
  if (o.principal > 0) await recordLedger({ Nature_Transaction: 'Deposit_Prin_Refund', Loan_No: o.code, Customer_Name: name, Description: `Deposit refund — ${o.code}`, Payment_Amount: o.principal, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  if (o.interest > 0) await recordLedger({ Nature_Transaction: 'Depositer_Interest', Loan_No: o.code, Customer_Name: name, Description: `Deposit interest — ${o.code}`, Payment_Amount: o.interest, Interest_Amount: o.interest, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  writeLog({ Action: 'update', Entity: 'Deposit_Amount', Entity_Label: `Repay deposit ${o.code}`, Before: rows })
  persist()
}

// Firm repays money it borrowed from another finance (principal and/or interest).
export async function repayOtherFinance(o: LiabilityRepay): Promise<void> {
  const rows = (db.Other_Finance_Loan ?? []).filter(l => l.Loan_No === o.code)
  if (!rows.length) return
  let left = o.principal
  db.Other_Finance_Loan = (db.Other_Finance_Loan ?? []).map(l => {
    if (l.Loan_No !== o.code || left <= 0) return l
    const out = num(l.Outstand_Amount)
    const pay = Math.min(out, left); left -= pay
    const newOut = out - pay
    return { ...l, Repaid_Amount: num(l.Repaid_Amount) + pay, Outstand_Amount: newOut, Loan_Status: newOut === 0 ? 'Closed' : l.Loan_Status }
  })
  await sReplace('Other_Finance_Loan', o.code, (db.Other_Finance_Loan ?? []).filter(l => l.Loan_No === o.code))
  const name = rows[0].Loan_bought_Finance_Name, finance = rows[0].Finance_Name
  if (o.principal > 0) await recordLedger({ Nature_Transaction: 'Other_Finance_Loan_Refund', Loan_No: o.code, Customer_Name: name, Description: `Other-finance refund — ${o.code}`, Payment_Amount: o.principal, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  if (o.interest > 0) await recordLedger({ Nature_Transaction: 'Other_Finance_Interest', Loan_No: o.code, Customer_Name: name, Description: `Other-finance interest — ${o.code}`, Payment_Amount: o.interest, Interest_Amount: o.interest, Payment_Type: o.payType, Finance_Name: finance, Date_Transaction: o.date })
  writeLog({ Action: 'update', Entity: 'Other_Finance_Loan', Entity_Label: `Repay other-finance ${o.code}`, Before: rows })
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
}
const SETTINGS_DEFAULTS: AppSettings = { postingAnyDate: false, dataLoadedDate: '', lastPostedDate: '' }
const SETTINGS_KEY = 'arul-finance:settings:v1'
export function getSettings(): AppSettings {
  try { return { ...SETTINGS_DEFAULTS, ...JSON.parse(localStorage.getItem(SETTINGS_KEY) || '{}') } }
  catch { return { ...SETTINGS_DEFAULTS } }
}
export function setSettings(patch: Partial<AppSettings>): void {
  localStorage.setItem(SETTINGS_KEY, JSON.stringify({ ...getSettings(), ...patch }))
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

// Remove every interest row for a finance + month (reversible from the log).
export async function revokeInterestForMonth(finance: string, month: string): Promise<number> {
  const removed = (db.Interest_Details ?? []).filter(i => i.Finance_Name === finance && i.Month === month)
  if (removed.length === 0) return 0
  db.Interest_Details = (db.Interest_Details ?? []).filter(i => !(i.Finance_Name === finance && i.Month === month))
  if (supabase) { const { error } = await supabase.from('Interest_Details').delete().eq('Finance_Name', finance).eq('Month', month); noteErr('delete Interest_Details', error?.message) }
  new Set(removed.map(r => r.Customer_STL_NO)).forEach(stl => stl && recomputeCustomer(stl))
  writeLog({ Action: 'revoke', Entity: 'Interest_Details', Entity_Label: `${finance} · ${month} · ${removed.length} rows`, Before: removed })
  persist()
  return removed.length
}

// ── Restore a deleted / revoked entry from the log ───────────────────────────
export async function restoreFromLog(logId: string): Promise<void> {
  const entry = (db.Log ?? []).find(l => l.id === logId)
  if (!entry || entry.Restored || (entry.Action !== 'delete' && entry.Action !== 'revoke')) return
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
}

export async function repayLoan(opts: RepayOptions): Promise<void> {
  const { loanNo, principal, date, paymentType, accrue, payInterest } = opts
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
      Loan_Amount: num(loan.Loan_Amount), Month: accrue.month,
      Description: `Interest on repayment — ${loanNo}`,
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
      Description: `Principal repayment — ${loanNo}`, Receipt_Amount: principal,
      Payment_Type: paymentType, Finance_Name: loan.Finance_Name, Date_Transaction: date,
    })
  }

  // 3) If paying interest now, settle every pending interest row for this loan.
  if (payInterest) {
    let settled = 0
    const changed: InterestRow[] = []
    db.Interest_Details = (db.Interest_Details ?? []).map(r => {
      if (r.Loan_No !== loanNo) return r
      const pending = num(r.Interest_Pending)
      if (pending <= 0) return r
      settled += pending
      const upd = { ...r, Amount_Received: num(r.Amount_Received) + pending, Interest_Pending: 0, Status: 'Paid' }
      changed.push(upd)
      return upd
    })
    for (const r of changed) await sUpdate('Interest_Details', r.ID, { Amount_Received: r.Amount_Received, Interest_Pending: 0, Status: 'Paid' })
    if (settled > 0) {
      await recordLedger({
        Nature_Transaction: 'Customer_Interest',
        STL_No: loan.Customer_STL_NO, Loan_No: loanNo, Customer_Name: loan.Customer_Name,
        Description: `Interest received — ${loanNo}`, Receipt_Amount: settled, Interest_Amount: settled,
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
