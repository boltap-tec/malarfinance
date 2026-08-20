// Single source of truth for navigation — used by both the sidebar (Layout)
// and the grouped tile launcher (Menu). Grouping keeps the menu compact instead
// of one long flat list.
import {
  LayoutDashboard, Users, HandCoins, Percent, BookOpenText, PiggyBank,
  Boxes, Gem, Building2, Users2, UserCog, History, Settings, MessageSquare,
  Landmark, Wallet, ReceiptText, Banknote, type LucideIcon,
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
      { to: '/ledger', label: 'Ledger', icon: BookOpenText, desc: 'All receipts & payments' },
      { to: '/interest', label: 'Interest Posting', icon: Percent, desc: 'Post all interest in one click' },
    ],
  },
  {
    title: 'Lending',
    items: [
      { to: '/customers', label: 'Customers', icon: Users, desc: 'Borrowers & STL 360°' },
      { to: '/loans', label: 'Loans', icon: HandCoins, desc: 'Give & repay loans' },
      { to: '/customer-interest', label: 'Customer Interest', icon: Percent, desc: 'Collect loan interest' },
    ],
  },
  {
    title: 'Deposit',
    items: [
      { to: '/depositors', label: 'Depositors', icon: Users2, desc: 'People who deposit with you' },
      { to: '/deposits', label: 'Deposits', icon: PiggyBank, desc: 'Deposits taken & repaid' },
      { to: '/deposit-interest', label: 'Deposit Interest', icon: Percent, desc: 'Interest you owe depositors' },
    ],
  },
  {
    title: 'Other Finance',
    items: [
      { to: '/other-finances', label: 'Other Finances', icon: Landmark, desc: 'Finances you borrow from' },
      { to: '/other-finance', label: 'Other Finance Loans', icon: Banknote, desc: 'Money you borrowed' },
      { to: '/other-finance-interest', label: 'Other Finance Interest', icon: ReceiptText, desc: 'Interest you owe them' },
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
