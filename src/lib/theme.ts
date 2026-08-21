// Per-user appearance: colour theme + font size, persisted to localStorage and
// applied to <html>. Palettes live in src/index.css.

export type ThemeId = 'dark' | 'light-blue' | 'light-green' | 'white'

export interface ThemeOption {
  id: ThemeId
  label: string
  swatch: string   // accent dot in the picker
  surface: string  // preview surface colour
}

export const THEMES: ThemeOption[] = [
  { id: 'dark',        label: 'Midnight',    swatch: '#3563f5', surface: '#0b1220' },
  { id: 'light-blue',  label: 'Light Blue',  swatch: '#2563eb', surface: '#eef3fa' },
  { id: 'light-green', label: 'Light Green', swatch: '#047857', surface: '#edf7f0' },
  { id: 'white',       label: 'White & Blue', swatch: '#1d4ed8', surface: '#ffffff' },
]

export type FontSize = 'sm' | 'md' | 'lg' | 'xl'
export const FONT_SIZES: { id: FontSize; label: string; px: number }[] = [
  { id: 'sm', label: 'Small',  px: 14 },
  { id: 'md', label: 'Medium', px: 16 },
  { id: 'lg', label: 'Large',  px: 18 },
  { id: 'xl', label: 'Extra',  px: 20 },
]

const THEME_KEY = 'arul-finance:theme'
const FONT_KEY = 'arul-finance:fontsize'
const DEFAULT_THEME: ThemeId = 'dark'
const DEFAULT_FONT: FontSize = 'md'

export function getTheme(): ThemeId {
  const t = localStorage.getItem(THEME_KEY) as ThemeId | null
  return THEMES.some(x => x.id === t) ? (t as ThemeId) : DEFAULT_THEME
}
export function applyTheme(id: ThemeId): void {
  document.documentElement.setAttribute('data-theme', id)
}
export function setTheme(id: ThemeId): void {
  localStorage.setItem(THEME_KEY, id)
  applyTheme(id)
}

export function getFontSize(): FontSize {
  const f = localStorage.getItem(FONT_KEY) as FontSize | null
  return FONT_SIZES.some(x => x.id === f) ? (f as FontSize) : DEFAULT_FONT
}
export function applyFontSize(id: FontSize): void {
  const px = FONT_SIZES.find(x => x.id === id)?.px ?? 16
  document.documentElement.style.fontSize = px + 'px'
}
export function setFontSize(id: FontSize): void {
  localStorage.setItem(FONT_KEY, id)
  applyFontSize(id)
}

// Apply saved appearance once at startup, before first paint.
export function initTheme(): void {
  applyTheme(getTheme())
  applyFontSize(getFontSize())
}
