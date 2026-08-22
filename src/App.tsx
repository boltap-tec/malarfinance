import { ReactNode } from 'react'
import { Navigate, Route, Routes, useLocation } from 'react-router-dom'
import { useApp, canSeeRoute, routeKey } from './store/app'
import Layout from './components/Layout'
import Login from './pages/Login'
import Dashboard from './pages/Dashboard'
import Customers from './pages/Customers'
import CustomerDetail from './pages/CustomerDetail'
import Loans from './pages/Loans'
import LoanDetail from './pages/LoanDetail'
import Interest from './pages/Interest'
import CustomerInterest from './pages/CustomerInterest'
import Ledger from './pages/Ledger'
import Deposits from './pages/Deposits'
import DepositDetail from './pages/DepositDetail'
import Depositors from './pages/Depositors'
import DepositInterest from './pages/DepositInterest'
import OtherFinance from './pages/OtherFinance'
import OtherFinanceDetail from './pages/OtherFinanceDetail'
import OtherFinances from './pages/OtherFinances'
import OtherFinanceInterest from './pages/OtherFinanceInterest'
import Partners from './pages/Partners'
import Finances from './pages/Finances'
import FinanceDetail from './pages/FinanceDetail'
import Workers from './pages/Workers'
import Logs from './pages/Logs'
import Settings from './pages/Settings'
import ProfitSummary from './pages/ProfitSummary'
import HandExchange from './pages/HandExchange'
import Messages from './pages/Messages'
import Chits from './pages/Chits'
import ChitDetail from './pages/ChitDetail'
import InvestedChitDetail from './pages/InvestedChitDetail'
import ChitFunds from './pages/ChitFunds'
import ChitMembers from './pages/ChitMembers'
import ChitMemberDetail from './pages/ChitMemberDetail'
import ChitAuctions from './pages/ChitAuctions'
import ChitTransactions from './pages/ChitTransactions'
import ChitLedger from './pages/ChitLedger'
import Menu from './pages/Menu'
import Placeholder from './pages/Placeholder'

// Blocks a route the current role isn't allowed to reach (direct-URL access).
function Guard({ children }: { children: ReactNode }) {
  const user = useApp(s => s.user)
  const { pathname } = useLocation()
  if (user && pathname !== '/menu' && !canSeeRoute(user, routeKey(pathname))) {
    return <Navigate to="/" replace />
  }
  return <>{children}</>
}

export default function App() {
  const user = useApp(s => s.user)

  if (!user) {
    return (
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="*" element={<Navigate to="/login" replace />} />
      </Routes>
    )
  }

  return (
    <Layout>
      <Guard>
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/customers" element={<Customers />} />
        <Route path="/customers/:stl" element={<CustomerDetail />} />
        <Route path="/loans" element={<Loans />} />
        <Route path="/loans/:loanNo" element={<LoanDetail />} />
        <Route path="/interest" element={<Interest />} />
        <Route path="/customer-interest" element={<CustomerInterest />} />
        <Route path="/ledger" element={<Ledger />} />
        <Route path="/depositors" element={<Depositors />} />
        <Route path="/deposits" element={<Deposits />} />
        <Route path="/deposits/:code" element={<DepositDetail />} />
        <Route path="/deposit-interest" element={<DepositInterest />} />
        <Route path="/other-finances" element={<OtherFinances />} />
        <Route path="/other-finance" element={<OtherFinance />} />
        <Route path="/other-finance/:code" element={<OtherFinanceDetail />} />
        <Route path="/other-finance-interest" element={<OtherFinanceInterest />} />
        <Route path="/finances" element={<Finances />} />
        <Route path="/finances/:name" element={<FinanceDetail />} />
        <Route path="/partners" element={<Partners />} />
        <Route path="/workers" element={<Workers />} />
        <Route path="/logs" element={<Logs />} />
        <Route path="/settings" element={<Settings />} />
        <Route path="/profit" element={<ProfitSummary />} />
        <Route path="/hand" element={<HandExchange />} />
        <Route path="/messages" element={<Messages />} />
        <Route path="/menu" element={<Menu />} />
        <Route path="/chits" element={<Chits />} />
        <Route path="/chits/invested/:chitId" element={<InvestedChitDetail />} />
        <Route path="/chit" element={<ChitFunds />} />
        <Route path="/chit/members" element={<ChitMembers />} />
        <Route path="/chit/auctions" element={<ChitAuctions />} />
        <Route path="/chit/transactions" element={<ChitTransactions />} />
        <Route path="/chit/ledger" element={<ChitLedger />} />
        <Route path="/chit/member/:memberId" element={<ChitMemberDetail />} />
        <Route path="/chit/:chitId" element={<ChitDetail />} />
        <Route path="/jewel" element={<Placeholder title="Jewel Loans" note="Gold/pawn loans with item particulars and photos — module coming next." />} />
        <Route path="/login" element={<Navigate to="/" replace />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
      </Guard>
    </Layout>
  )
}
