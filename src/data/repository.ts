// ── Data access layer ────────────────────────────────────────────────────────
// Today it reads the seeded snapshot of your real sheets from seed.json and keeps
// working changes in memory (persisted to localStorage). This is the ONLY file
// that knows *where* data comes from — when you move to Supabase, you reimplement
// these same functions with supabase-js and nothing else in the app changes.

import seed from './seed.json'
import { supabase, isSupabaseConfigured } from './supabase'
import type {
  Dataset, Loan, Customer, InterestRow, LedgerRow, Partner, Finance, Deposit,
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
    return (db.STL_CRM ?? []).filter(c => !finance || c.Finance_Name === finance)
  },
  customer(stl: string): Customer | undefined {
    return (db.STL_CRM ?? []).find(c => c.Customer_STL_NO === stl)
  },
  loans(finance?: string): Loan[] {
    return (db.Loan_Processing ?? []).filter(l => !finance || l.Finance_Name === finance)
  },
  loan(loanNo: string): Loan | undefined {
    return (db.Loan_Processing ?? []).find(l => l.Loan_No === loanNo)
  },
  loansByCustomer(stl: string): Loan[] {
    return (db.Loan_Processing ?? []).filter(l => l.Customer_STL_NO === stl)
  },
  interest(finance?: string): InterestRow[] {
    return (db.Interest_Details ?? []).filter(i => !finance || i.Finance_Name === finance)
  },
  interestByLoan(loanNo: string): InterestRow[] {
    return (db.Interest_Details ?? []).filter(i => String(i.Loan_No).split('-').includes(loanNo) || i.Loan_No === loanNo)
  },
  interestByCustomer(stl: string): InterestRow[] {
    return (db.Interest_Details ?? []).filter(i => i.Customer_STL_NO === stl)
  },
  ledger(finance?: string): LedgerRow[] {
    return (db.Transaction_Ledger ?? []).filter(t => !finance || t.Finance_Name === finance)
  },
  deposits(finance?: string): Deposit[] {
    return (db.Deposit_Amount ?? []).filter(d => !finance || d.Finance_Name === finance)
  },
  natureTypes() { return db.Nature_Transaction ?? [] },
  raw<K extends keyof Dataset>(key: K): Dataset[K] { return db[key] },
}

// ── Write helpers (in-memory + localStorage; async signature ready for Supabase)
export async function addLoan(loan: Loan): Promise<void> {
  db.Loan_Processing = [loan, ...(db.Loan_Processing ?? [])]
  persist()
}

export async function updateLoan(loanNo: string, patch: Partial<Loan>): Promise<void> {
  db.Loan_Processing = (db.Loan_Processing ?? []).map(l =>
    l.Loan_No === loanNo ? { ...l, ...patch } : l)
  persist()
}

export async function addCustomer(c: Customer): Promise<void> {
  db.STL_CRM = [c, ...(db.STL_CRM ?? [])]
  persist()
}

export async function appendInterestRows(rows: InterestRow[]): Promise<void> {
  db.Interest_Details = [...(db.Interest_Details ?? []), ...rows]
  persist()
}

export async function recordLedger(row: LedgerRow): Promise<void> {
  db.Transaction_Ledger = [...(db.Transaction_Ledger ?? []), row]
  persist()
}
