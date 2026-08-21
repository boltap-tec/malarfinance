// Theme choice, persisted to localStorage and applied to <html data-theme>.
// The palettes themselves live in src/index.css.

export type ThemeId = 'dark' | 'light-blue' | 'light-green' | 'light-rose'

export interface ThemeOption {
  id: ThemeId
  label: string
  swatch: string   // representative colour for the picker dot
  surface: string  // preview surface colour
}

export const THEMES: ThemeOption[] = [
  { id: 'dark',        label: 'Midnight',    swatch: '#3563f5', surface: '#0b1220' },
  { id: 'light-blue',  label: 'Light Blue',  swatch: '#2563eb', surface: '#eef3fa' },
  { id: 'light-green', label: 'Light Green', swatch: '#059669', surface: '#edf7f0' },
  { id: 'light-rose',  label: 'Light Rose',  swatch: '#e11d48', surface: '#faf0f3' },
]

const KEY = 'arul-finance:theme'
const DEFAULT: ThemeId = 'dark'

export function getTheme(): ThemeId {
  const t = localStorage.getItem(KEY) as ThemeId | null
  return THEMES.some(x => x.id === t) ? (t as ThemeId) : DEFAULT
}

export function applyTheme(id: ThemeId): void {
  document.documentElement.setAttribute('data-theme', id)
}

export function setTheme(id: ThemeId): void {
  localStorage.setItem(KEY, id)
  applyTheme(id)
}

// Call once at startup, before first paint.
export function initTheme(): void {
  applyTheme(getTheme())
}
