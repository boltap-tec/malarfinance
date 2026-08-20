// Single source of truth for navigation — used by both the sidebar (Layout)
// and the grouped tile launcher (Menu). Grouping keeps the menu compact instead
// of one long flat list.
import {
  LayoutDashboard, Users, HandCoins, Percent, BookOpenText, PiggyBank,
  Boxes, Gem, Building2, Users2, UserCog, History, Settings, MessageSquare, type LucideIcon,
} from 'lucide-react'

export interface NavItem {
  to: string
  label: string
  icon: LucideIcon
  end?: boolean
  desc?: string
}

export interface NavGroup {
  title: string
  items: NavItem[]
}

export const navGroups: NavGroup[] = [
  {
    title: 'Overview',
    items: [
      { to: '/', label: 'Dashboard', icon: LayoutDashboard, end: true, desc: 'KPIs & recent activity' },
      { to: '/messages', label: 'Messages', icon: MessageSquare, desc: 'Group & direct chat' },
    ],
  },
  {
    title: 'Lending',
    items: [
      { to: '/customers', label: 'Customers', icon: Users, desc: 'Borrowers & STL 360°' },
      { to: '/loans', label: 'Loans', icon: HandCoins, desc: 'Give & repay loans' },
      { to: '/interest', label: 'Interest', icon: Percent, desc: 'Post monthly interest' },
    ],
  },
  {
    title: 'Money',
    items: [
      { to: '/ledger', label: 'Ledger', icon: BookOpenText, desc: 'All receipts & payments' },
      { to: '/deposits', label: 'Deposits', icon: PiggyBank, desc: 'Money from depositors' },
      { to: '/other-finance', label: 'Other Finance', icon: Building2, desc: 'Money you borrowed' },
    ],
  },
  {
    title: 'Organisation',
    items: [
      { to: '/partners', label: 'Partners', icon: Users2, desc: 'Owners & partners' },
      { to: '/workers', label: 'Workers', icon: UserCog, desc: 'Staff & their menus' },
    ],
  },
  {
    title: 'More',
    items: [
      { to: '/chits', label: 'Chits', icon: Boxes, desc: 'Invested chit funds' },
      { to: '/jewel', label: 'Jewel Loans', icon: Gem, desc: 'Gold / pawn (soon)' },
    ],
  },
  {
    title: 'Admin',
    items: [
      { to: '/logs', label: 'Activity Log', icon: History, desc: 'Changes & restore' },
      { to: '/settings', label: 'Settings', icon: Settings, desc: 'Interest & corrections' },
    ],
  },
]

// Flat list (handy where a single array is needed).
export const navItems: NavItem[] = navGroups.flatMap(g => g.items)

// The few tabs shown in the mobile bottom bar; the rest live under "Menu".
export const bottomNav: NavItem[] = [
  { to: '/', label: 'Home', icon: LayoutDashboard, end: true },
  { to: '/loans', label: 'Loans', icon: HandCoins },
  { to: '/interest', label: 'Interest', icon: Percent },
  { to: '/ledger', label: 'Ledger', icon: BookOpenText },
]
