import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import { repo, setViewer, setPinByName } from '../data/repository'

export type Role = 'md' | 'partner' | 'worker'

// The one MD allowed to see EVERY finance ("all finances"), during build-out.
// Every other MD is scoped to only the finance(s) they run. Identified by name
// (and, for older data, phone) so a changed phone number never affects it.
export const SUPER_PHONE = '9626262427'
export const SUPER_MD_NAME = 'Malarvizhi'

export interface AppUser {
  name: string
  role: Role
  phone: string
  finance: string          // active finance scope; 'ALL' only for the super MD
  finances?: string[]      // finances an MD may switch between
  isSuper?: boolean        // super MD → may see all finances
  partnerId?: string
  workerId?: string
  allowedMenus?: string[]
}

interface AppState {
  user: AppUser | null
  finance: string
  // You pick your role on the login screen, then sign in with your username (name)
  // and password, both checked against that role's own table. Returns an error
  // string, or null on success.
  login: (role: Role, username: string, password: string) => string | null
  logout: () => void
  setFinance: (f: string) => void
  changePassword: (newPassword: string) => void
}

function applyViewer(u: AppUser | null) {
  if (!u) return setViewer(null)
  setViewer({ role: u.role, partnerId: u.partnerId, finance: u.finance, name: u.name })
}

export const useApp = create<AppState>()(
  persist(
    (set, get) => ({
      user: null,
      finance: 'ALL',
      login: (role, usernameRaw, password) => {
        const username = usernameRaw.trim()
        if (!role) return 'Choose whether you are an MD, partner or worker.'
        if (!username) return 'Enter your username or phone number.'

        // You may sign in with your NAME or your phone number — either is matched
        // against your role's table. The default password is 1234.
        const pinOk = (pin?: string) => String(pin || '1234') === password

        if (role === 'md') {
          // Match by MD name first, then fall back to phone number.
          let mdFinances = repo.financesByMdName(username)
          if (mdFinances.length === 0) mdFinances = repo.financesByMdPhone(username)
          if (mdFinances.length === 0) return 'No MD found with this username or phone.'
          if (!pinOk(mdFinances[0]?.PIN)) return 'Wrong password. (Default is 1234.)'
          // Super MD (sees all finances) — matched by name or by the super phone.
          const isSuper = username.toLowerCase() === SUPER_MD_NAME.toLowerCase()
            || username === SUPER_PHONE
            || mdFinances.some(f => f.Phone_Number != null && String(f.Phone_Number) === SUPER_PHONE)
          const names = isSuper ? repo.finances().map(f => f.Finance_Name) : mdFinances.map(f => f.Finance_Name)
          const scope = isSuper ? 'ALL' : (names[0] ?? 'ALL')
          const phone = mdFinances.find(f => f.Phone_Number != null)?.Phone_Number
          const u: AppUser = { name: mdFinances[0]?.MD_Name || 'MD', role: 'md', phone: phone != null ? String(phone) : '', finance: scope, finances: names, isSuper }
          applyViewer(u); set({ user: u, finance: scope }); return null
        }

        if (role === 'partner') {
          const partner = repo.partnerByName(username) ?? repo.partnerByPhone(username)
          if (!partner) return 'No partner found with this username or phone.'
          if (!pinOk(partner.PIN)) return 'Wrong password. (Default is 1234.)'
          const u: AppUser = { name: partner.Partner_Name, role: 'partner', phone: partner.Phone_Number != null ? String(partner.Phone_Number) : '', finance: partner.Finance_Name, partnerId: partner.Partner_ID }
          applyViewer(u); set({ user: u, finance: partner.Finance_Name }); return null
        }

        // worker
        const worker = repo.workerByName(username) ?? repo.workerByPhone(username)
        if (!worker) return 'No worker found with this username or phone.'
        if (!pinOk(worker.PIN)) return 'Wrong password. (Default is 1234.)'
        const u: AppUser = {
          name: worker.Worker_Name, role: 'worker', phone: worker.Phone_Number != null ? String(worker.Phone_Number) : '',
          finance: worker.Finance_Name, workerId: worker.Worker_ID, allowedMenus: worker.Allowed_Menus ?? [],
        }
        applyViewer(u); set({ user: u, finance: worker.Finance_Name }); return null
      },
      logout: () => { applyViewer(null); set({ user: null, finance: 'ALL' }) },
      setFinance: (f) => {
        const u = get().user
        if (!u || u.role !== 'md') return
        // Only the super MD may pick 'ALL'; others are limited to their finances.
        const allowed = u.isSuper ? [...(u.finances ?? []), 'ALL'] : (u.finances ?? [])
        if (allowed.includes(f)) set({ finance: f })
      },
      changePassword: (newPassword) => {
        const u = get().user
        if (u && newPassword) setPinByName(u.role, u.name, newPassword)
      },
    }),
    {
      name: 'arul-finance:session',
      version: 5, // bumped: login by username (name) + password instead of phone + PIN
      migrate: () => ({ user: null, finance: 'ALL' }) as Partial<AppState>,
      onRehydrateStorage: () => (state) => { applyViewer(state?.user ?? null) },
    },
  ),
)

// Convenience: current finance filter (undefined = all finances)
export const financeFilter = (f: string) => (f === 'ALL' ? undefined : f)

// MD and workers may create/modify; partners are view-only.
export const canEdit = (role?: Role) => role === 'md' || role === 'worker'

// Feature flag: the "chit fund you RUN" section (its own sidebar group with
// Funds, Members, Auctions, Transactions and Ledger pages). Invested chits are
// a separate, always-on feature. Flip to false to hide the run-your-own section.
export const SHOW_OWN_CHIT_FUND = true

export const PARTNER_ROUTES = ['/', '/messages', '/customers', '/loans', '/customer-interest', '/ledger']
export function canSeeRoute(user: AppUser | null, to: string): boolean {
  if (!user) return false
  if (user.role === 'md') return true
  if (user.role === 'partner') return PARTNER_ROUTES.includes(to)
  if (to === '/' || to === '/menu' || to === '/messages') return true
  return (user.allowedMenus ?? []).includes(to)
}

export function routeKey(pathname: string): string {
  if (pathname === '/') return '/'
  const seg = '/' + pathname.split('/').filter(Boolean)[0]
  return seg
}
