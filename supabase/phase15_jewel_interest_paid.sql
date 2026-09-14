-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 15 — Jewel loan: total interest paid (captured at close).
--
-- Adds "Total_Interest_Paid" to Jewel_Loan — the actual interest the user paid
-- over the loan's life, entered when the loan is closed. The list shows this for
-- closed loans, and an "interest so far" estimate (computed live) for active
-- ones, so nothing extra is stored for active loans.
--
-- Safe to run once, after phase13. (A fresh phase13 already includes the column,
-- so this is then a harmless no-op.) Run in Supabase → SQL Editor.
-- ─────────────────────────────────────────────────────────────────────────────

alter table "Jewel_Loan" add column if not exists "Total_Interest_Paid" numeric;
