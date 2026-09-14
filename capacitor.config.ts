import type { CapacitorConfig } from '@capacitor/cli'

// Used later to produce the Android APK from this same web build:
//   npm i -D @capacitor/cli && npm i @capacitor/core @capacitor/android
//   npm run build && npx cap add android && npx cap sync && npx cap open android
const config: CapacitorConfig = {
  appId: 'com.arul.finance',
  appName: 'Arul Finance',
  webDir: 'dist',
  backgroundColor: '#020617',
  // Serve the app from https://localhost inside the WebView (a secure context),
  // matching the browser. This keeps fetch/XHR to Supabase behaving the same on
  // the device as on the web, and enables realtime/secure-context features.
  android: { allowMixedContent: true },
  server: { androidScheme: 'https' },
}

export default config
