import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import { repo } from '../data/repository'

export type Role = 'owner' | 'partner'

export interface AppUser {
  name: string
  role: Role
  finance: string // active finance scope; 'ALL' = every finance
}

interface AppState {
  user: AppUser | null
  finance: string
  login: (name: string, role: Role) => void
  logout: () => void
  setFinance: (f: string) => void
}

// Demo auth. Swap `login` for Supabase Auth (email/OTP) later — the rest of the
// app only reads `user` and `finance`, so nothing else changes.
export const useApp = create<AppState>()(
  persist(
    (set) => ({
      user: null,
      finance: 'ALL',
      login: (name, role) => {
        const finances = repo.finances()
        const first = finances[0]?.Finance_Name ?? 'ALL'
        set({ user: { name, role, finance: 'ALL' }, finance: role === 'owner' ? 'ALL' : first })
      },
      logout: () => set({ user: null, finance: 'ALL' }),
      setFinance: (f) => set({ finance: f }),
    }),
    { name: 'arul-finance:session' },
  ),
)

// Convenience: current finance filter (undefined = all finances)
export const financeFilter = (f: string) => (f === 'ALL' ? undefined : f)
