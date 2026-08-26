-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 6 — record WHEN each ledger row was entered into the app.
--
-- Adds a "Created_Date" audit stamp to Transaction_Ledger, separate from
-- "Date_Transaction" (the value/transaction date, which may be back-dated).
-- The column defaults to now(), so the database stamps it automatically on every
-- insert — the app does NOT send this column, which means a row can still be
-- inserted even before this script is run (it just won't have a created date).
--
-- Run this once in Supabase → SQL Editor.
-- (You must also have run phase3_write_policies.sql so inserts/updates persist.)
-- ─────────────────────────────────────────────────────────────────────────────

alter table "Transaction_Ledger"
  add column if not exists "Created_Date" timestamptz default now();
