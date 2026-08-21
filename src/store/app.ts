import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import { repo, setViewer, verifyCred, setCred } from '../data/repository'

export type Role = 'md' | 'partner' | 'worker'

// The one phone allowed to see EVERY finance ("all finances"), during build-out.
// Every other MD is scoped to only the finance(s) they run.
export const SUPER_PHONE = '9626262427'

// Special login result: the phone is registered as BOTH an MD and a partner, so
// the UI must ask which role to enter as.
export const CHOOSE_ROLE = 'CHOOSE_ROLE'

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
  login: (phone: string, password: string, prefer?: Role) => string | null // error | CHOOSE_ROLE | null(success)
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
      login: (phoneRaw, password, prefer) => {
        const phone = phoneRaw.trim()
        if (!phone) return 'Enter your phone number.'
        if (!verifyCred(phone, password)) return 'Wrong password. (Default is 1234.)'

        const isSuper = phone === SUPER_PHONE
        const mdFinances = repo.financesByMdPhone(phone)
        const isMd = isSuper || mdFinances.length > 0
        const partner = repo.partnerByPhone(phone)
        const worker = repo.workerByPhone(phone)

        // Same number is both an MD and a partner → ask which to enter as.
        if (isMd && partner && !prefer) return CHOOSE_ROLE

        function loginMd(): null {
          const names = isSuper
            ? repo.finances().map(f => f.Finance_Name)
            : mdFinances.map(f => f.Finance_Name)
          const scope = isSuper ? 'ALL' : (names[0] ?? 'ALL')
          const u: AppUser = {
            name: (mdFinances[0]?.MD_Name) || 'MD', role: 'md', phone,
            finance: scope, finances: names, isSuper,
          }
          applyViewer(u); set({ user: u, finance: scope }); return null
        }

        if (prefer === 'partner' && partner) {
          const u: AppUser = { name: partner.Partner_Name, role: 'partner', phone, finance: partner.Finance_Name, partnerId: partner.Partner_ID }
          applyViewer(u); set({ user: u, finance: partner.Finance_Name }); return null
        }
        if (prefer === 'md' && isMd) return loginMd()

        // Auto-resolve when unambiguous: MD → worker → partner.
        if (isMd) return loginMd()
        if (worker) {
          const u: AppUser = {
            name: worker.Worker_Name, role: 'worker', phone,
            finance: worker.Finance_Name, workerId: worker.Worker_ID,
            allowedMenus: worker.Allowed_Menus ?? [],
          }
          applyViewer(u); set({ user: u, finance: worker.Finance_Name }); return null
        }
        if (partner) {
          const u: AppUser = { name: partner.Partner_Name, role: 'partner', phone, finance: partner.Finance_Name, partnerId: partner.Partner_ID }
          applyViewer(u); set({ user: u, finance: partner.Finance_Name }); return null
        }
        return 'No MD, worker or partner found with this phone number.'
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
        if (u && newPassword) setCred(u.phone, newPassword)
      },
    }),
    {
      name: 'arul-finance:session',
      version: 3, // bumped: MD finance scoping + role choice
      migrate: () => ({ user: null, finance: 'ALL' }) as Partial<AppState>,
      onRehydrateStorage: () => (state) => { applyViewer(state?.user ?? null) },
    },
  ),
)

// Convenience: current finance filter (undefined = all finances)
export const financeFilter = (f: string) => (f === 'ALL' ? undefined : f)

// MD and workers may create/modify; partners are view-only.
export const canEdit = (role?: Role) => role === 'md' || role === 'worker'

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
