/** @type {import('tailwindcss').Config} */

// Every themeable colour resolves to a CSS variable (space-separated RGB), so
// switching the `data-theme` on <html> re-skins the whole app with no per-file
// changes. See src/index.css for the palettes and src/lib/theme.ts for switching.
const v = (name) => `rgb(var(--${name}) / <alpha-value>)`
const ramp = (prefix) => Object.fromEntries(
  [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950].map((n) => [n, v(`${prefix}-${n}`)]),
)

export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        brand: ramp('brand'),
        slate: ramp('slate'),
        // Status / accent colours are themed too, so badges and amounts stay
        // readable and attractive on the light themes (see src/index.css).
        emerald: ramp('emerald'),
        amber: ramp('amber'),
        rose: ramp('rose'),
        hd: v('hd'), // primary heading/foreground text (white on dark, ink on light)
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
