import type { CapacitorConfig } from '@capacitor/cli'

// Used later to produce the Android APK from this same web build:
//   npm i -D @capacitor/cli && npm i @capacitor/core @capacitor/android
//   npm run build && npx cap add android && npx cap sync && npx cap open android
const config: CapacitorConfig = {
  appId: 'com.arul.finance',
  appName: 'Arul Finance',
  webDir: 'dist',
  backgroundColor: '#020617',
  android: { allowMixedContent: true },
}

export default config
