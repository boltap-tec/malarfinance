import { Navigate, Route, Routes } from 'react-router-dom'
import { useApp } from './store/app'
import Layout from './components/Layout'
import Login from './pages/Login'
import Dashboard from './pages/Dashboard'
import Customers from './pages/Customers'
import CustomerDetail from './pages/CustomerDetail'
import Loans from './pages/Loans'
import LoanDetail from './pages/LoanDetail'
import Interest from './pages/Interest'
import Ledger from './pages/Ledger'
import Deposits from './pages/Deposits'
import Chits from './pages/Chits'
import Placeholder from './pages/Placeholder'

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
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/customers" element={<Customers />} />
        <Route path="/customers/:stl" element={<CustomerDetail />} />
        <Route path="/loans" element={<Loans />} />
        <Route path="/loans/:loanNo" element={<LoanDetail />} />
        <Route path="/interest" element={<Interest />} />
        <Route path="/ledger" element={<Ledger />} />
        <Route path="/deposits" element={<Deposits />} />
        <Route path="/chits" element={<Chits />} />
        <Route path="/jewel" element={<Placeholder title="Jewel Loans" note="Gold/pawn loans with item particulars and photos — module coming next." />} />
        <Route path="/login" element={<Navigate to="/" replace />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Layout>
  )
}
