# Arul Finance — Management Suite

A modern web app (React + Vite + TypeScript) that replaces the AppSheet + Google
Sheets finance system: **customers, loans, an automatic interest engine,
deposits, chit funds and a live ledger** — with a mobile-first UI that becomes an
Android **APK** later via Capacitor, no rewrite.

It is seeded with your **real data** exported from `Finance_Details.xlsx`, so
every screen shows true numbers on first run.

---

## Quick start

```bash
npm install
npm run dev
```

Open http://localhost:5173 and sign in (demo login — pick **Owner / MD**).

Build for production:

```bash
npm run build      # outputs dist/
npm run preview    # serve the build locally
```

---

## What's built (Phase 1)

| Module | Status |
|---|---|
| Dashboard (KPIs, billed-vs-collected chart, loan-status, recent txns) | ✅ |
| Customers (search) + customer 360° detail | ✅ |
| Loans (search, status filter) + loan detail with interest calculator | ✅ |
| **Interest engine** — preview + post monthly interest for active loans | ✅ |
| Transaction ledger (receipts / payments, net) | ✅ |
| Deposits (liabilities to depositors) | ✅ |
| Chit funds (invested chits overview) | ✅ |
| Owner / Partner roles, multi-finance switcher | ✅ |
| Jewel loans, chit auctions, reports | ⏭️ next phase |

The interest engine (`src/lib/interestEngine.ts`) is a faithful port of your
Google Apps Script: per-day / per-month formulas, actual-from-date, inclusive
day count, rounding to the nearest ₹10.

---

## Architecture

```
src/
  data/        types.ts · repository.ts (ONE place that knows the data source) · seed.json
  lib/         interestEngine.ts · format.ts
  store/       app.ts (auth + finance scope, zustand)
  components/  Layout.tsx · ui.tsx
  pages/       Dashboard, Customers, Loans, Interest, Ledger, Deposits, Chits, …
```

The **repository** is the seam. Today it reads `seed.json` and persists working
changes to `localStorage`. To go live, reimplement those same functions with
`supabase-js` — no screen changes.

---

## Deploy to Vercel (via GitHub)

1. Push this folder to a GitHub repo.
2. In Vercel → **New Project** → import the repo.
3. Framework preset **Vite**; build `npm run build`; output `dist`.
   (`vercel.json` already sets the SPA rewrite so deep links like `/interest` work.)
4. Deploy. Every `git push` to `main` auto-deploys.

---

## Connect Supabase (later)

1. Create a Supabase project; run `supabase/schema.sql` in the SQL editor.
2. Import your data (CSV export of each sheet, or a small migration script).
3. `npm i @supabase/supabase-js`, add `VITE_SUPABASE_URL` / `VITE_SUPABASE_ANON_KEY`
   (see `.env.example`) in Vercel env vars.
4. Rewrite `src/data/repository.ts` to query Supabase. Wire real auth in `src/store/app.ts`.

---

## Build the Android APK (later)

```bash
npm i -D @capacitor/cli
npm i @capacitor/core @capacitor/android
npm run build
npx cap add android
npx cap sync
npx cap open android      # opens Android Studio → Build APK
```

`capacitor.config.ts` is already configured (`webDir: dist`).
```
