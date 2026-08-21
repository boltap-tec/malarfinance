import React, { useEffect, useState } from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App'
import { hydrate } from './data/repository'
import { isSupabaseConfigured } from './data/supabase'
import { initTheme } from './lib/theme'
import './index.css'

initTheme() // apply the saved theme + font size before first paint

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

// One consistent React tree: show the splash while data hydrates, then the app.
function Root() {
  const [ready, setReady] = useState(false)
  useEffect(() => { let live = true; hydrate().finally(() => { if (live) setReady(true) }); return () => { live = false } }, [])
  if (!ready) return <Splash />
  return (
    <BrowserRouter>
      <App />
    </BrowserRouter>
  )
}

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <Root />
  </React.StrictMode>,
)
