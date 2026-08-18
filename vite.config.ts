import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// Capacitor loads from ./ so relative base keeps the future APK build working.
export default defineConfig({
  plugins: [react()],
  base: './',
  server: { port: 5173, host: true },
})
