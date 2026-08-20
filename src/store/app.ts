import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import { repo, setViewer, verifyCred, setCred } from '../data/repository'

export type Role = 'md' | 'partner' | 'worker'

export interface AppUser {
  name: string
  role: Role
  phone: string
  finance: string          // active finance scope; 'ALL' = every finance (MD only)
  partnerId?: string       // set for partners
  workerId?: string        // set for workers
  allowedMenus?: string[]  // route paths a worker may use
}

interface AppState {
  user: AppUser | null
  finance: string
  login: (phone: string, password: string) => string | null // returns error message or null on success
  logout: () => void
  setFinance: (f: string) => void
  changePassword: (newPassword: string) => void
}

// Re-apply row-level scoping after a login or a page refresh (persist rehydrate).
function applyViewer(u: AppUser | null) {
  if (!u) return setViewer(null)
  setViewer({ role: u.role, partnerId: u.partnerId, finance: u.finance, name: u.name })
}

export const useApp = create<AppState>()(
  persist(
    (set, get) => ({
      user: null,
      finance: 'ALL',
      login: (phoneRaw, password) => {
        const phone = phoneRaw.trim()
        if (!phone) return 'Enter your phone number.'
        if (!verifyCred(phone, password)) return 'Wrong password. (Default is 1234.)'

        // Resolve identity: MD first, then worker, then partner.
        const fin = repo.financeByMdPhone(phone)
        if (fin) {
          const u: AppUser = { name: fin.MD_Name || 'MD', role: 'md', phone, finance: 'ALL' }
          applyViewer(u); set({ user: u, finance: 'ALL' }); return null
        }
        const worker = repo.workerByPhone(phone)
        if (worker) {
          const u: AppUser = {
            name: worker.Worker_Name, role: 'worker', phone,
            finance: worker.Finance_Name, workerId: worker.Worker_ID,
            allowedMenus: worker.Allowed_Menus ?? [],
          }
          applyViewer(u); set({ user: u, finance: worker.Finance_Name }); return null
        }
        const partner = repo.partnerByPhone(phone)
        if (partner) {
          const u: AppUser = {
            name: partner.Partner_Name, role: 'partner', phone,
            finance: partner.Finance_Name, partnerId: partner.Partner_ID,
          }
          applyViewer(u); set({ user: u, finance: partner.Finance_Name }); return null
        }
        return 'No MD, worker or partner found with this phone number.'
      },
      logout: () => { applyViewer(null); set({ user: null, finance: 'ALL' }) },
      setFinance: (f) => { if (get().user?.role === 'md') set({ finance: f }) },
      changePassword: (newPassword) => {
        const u = get().user
        if (u && newPassword) setCred(u.phone, newPassword)
      },
    }),
    {
      name: 'arul-finance:session',
      version: 2, // bumped when auth moved to phone/password roles (md/partner/worker)
      migrate: () => ({ user: null, finance: 'ALL' }) as Partial<AppState>,
      onRehydrateStorage: () => (state) => { applyViewer(state?.user ?? null) },
    },
  ),
)

// Convenience: current finance filter (undefined = all finances)
export const financeFilter = (f: string) => (f === 'ALL' ? undefined : f)

// MD and workers may create/modify; partners are view-only.
export const canEdit = (role?: Role) => role === 'md' || role === 'worker'

// Which routes a user may reach. MD: all. Partner: a fixed read-only set.
// Worker: exactly the menus the MD granted (plus the dashboard).
export const PARTNER_ROUTES = ['/', '/messages', '/customers', '/loans', '/interest', '/ledger']
export function canSeeRoute(user: AppUser | null, to: string): boolean {
  if (!user) return false
  if (user.role === 'md') return true
  if (user.role === 'partner') return PARTNER_ROUTES.includes(to)
  // worker: dashboard, menu and messages are always available; the rest is granted
  if (to === '/' || to === '/menu' || to === '/messages') return true
  return (user.allowedMenus ?? []).includes(to)
}

// Map a concrete pathname (incl. detail routes) to the menu route that governs it.
export function routeKey(pathname: string): string {
  if (pathname === '/') return '/'
  const seg = '/' + pathname.split('/').filter(Boolean)[0]
  return seg
}
