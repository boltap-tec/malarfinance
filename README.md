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

Open http://localhost:5173 and sign in with a **phone number + password** (default
`1234`, changeable from the key icon in the header).

### Roles
| Role | Signs in with | Sees |
|---|---|---|
| **MD** | the finance's phone (`Finance_Details.Phone_Number`) | everything, all finances, full edit |
| **Partner** | their partner phone | dashboard/loans/interest/ledger **scoped to loans they referred**, view-only |
| **Worker** | phone the MD registered | only the menus the MD granted (created under **Workers**) |

Sample MD login: `9626262427` (Malarvizhi · Malar_Finance). Sample partner: `8940864888`.

New loans notify the referred partner via the **bell**. The **refresh** icon re-pulls
data. Because this phase stores data locally per-browser, cross-device logins become
real once Supabase is connected.

Build for production:

```bash
npm run build      # outputs dist/
npm run preview    # serve the build locally
```

---

## What's built

| Module | Status |
|---|---|
| Dashboard (KPIs, billed-vs-collected chart, loan-status, recent txns) | ✅ |
| Customers (search) + customer 360° detail + **New customer** form | ✅ |
| Loans (search, status filter) + loan detail with interest calculator | ✅ |
| **New loan** + **Repay loan** (principal + interest, auto-closes) forms | ✅ |
| **Interest engine** — preview + post monthly interest for active loans | ✅ |
| Transaction ledger — every flow auto-posts (loan out, repay, deposit, borrow) | ✅ |
| Deposits (liabilities to depositors) + **New deposit** form | ✅ |
| **Other-Finance loans** (money the firm borrows) + **Borrow** form | ✅ |
| **Partners** directory | ✅ |
| Chit funds (invested chits overview) | ✅ |
| Owner / Partner roles, multi-finance switcher | ✅ |
| Jewel loans, chit auctions, reports | ⏭️ next phase |

### Money flows & the ledger
Every data-entry action posts a matching row to the **Transaction Ledger** with an
auto Ref_ID and a running balance:

| Action | Ledger nature | Direction |
|---|---|---|
| Disburse a loan | `Loan_To_Customer` | Payment (out) |
| Customer principal repayment | `Customer_Loan_Prin_Repayment` | Receipt (in) |
| Customer interest received | `Customer_Interest` | Receipt (in) |
| Take a deposit | `Deposit_From_Customer` | Receipt (in) |
| Borrow from another finance | `Other_Receipt` | Receipt (in) |

Repaying a loan settles pending interest rows oldest-first and marks the loan
**Closed** when the outstanding principal reaches zero. Interest *posting* only
bills (creates the schedule); cash is recognised when the customer actually pays.

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
