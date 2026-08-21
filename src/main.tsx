import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App'
import { hydrate } from './data/repository'
import { isSupabaseConfigured } from './data/supabase'
import { initTheme } from './lib/theme'
import './index.css'

initTheme() // apply the saved theme before first paint

const root = ReactDOM.createRoot(document.getElementById('root')!)

function Splash() {
  return (
    <div style={{ minHeight: '100vh', display: 'grid', placeItems: 'center', background: '#020617', color: '#e2e8f0', fontFamily: 'Inter, system-ui, sans-serif' }}>
      <div style={{ textAlign: 'center' }}>
        <div style={{ width: 52, height: 52, borderRadius: 16, margin: '0 auto', display: 'grid', placeItems: 'center', background: 'linear-gradient(135deg,#598cff,#1a37bd)', fontSize: 26, fontWeight: 800, color: '#fff' }}>₹</div>
        <p style={{ marginTop: 16, fontWeight: 600 }}>Malar Finance</p>
        <p style={{ marginTop: 4, fontSize: 13, color: '#64748b' }}>{isSupabaseConfigured ? 'Connecting to your database…' : 'Loading…'}</p>
      </div>
    </div>
  )
}

root.render(<Splash />)

// Pull live data (if Supabase is configured) before showing the app.
hydrate().finally(() => {
  root.render(
    <React.StrictMode>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </React.StrictMode>,
  )
})
