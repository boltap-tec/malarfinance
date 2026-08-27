-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 9 — per-item "interest posted up to" column.
--
-- Interest posting now tracks the date interest has been billed up to:
--   • per CUSTOMER  (STL_CRM)          — shared by all that customer's loans
--   • per deposit   (Deposit_Amount)   — each deposit is its own entity
--   • per borrowing (Other_Finance_Loan)
-- Each monthly posting stamps this column to the month end; the next posting
-- resumes from the day after it (but never before the loan/deposit's given date —
-- so a fresh loan bills from its own given date). A repayment deliberately does
-- NOT touch it, so a remaining balance still bills its pre-repay days next month.
--
-- Interest is charged on the OUTSTANDING principal. Seed these columns once with
-- your go-live cut-over date (the last date interest was already settled in the
-- old system); leave them blank for items added afterwards — those resume from
-- their own given date. When blank, the app falls back to the Settings cut-over.
--
-- Run this once in Supabase → SQL Editor.
-- (You must also have run phase3_write_policies.sql so inserts/updates persist.)
-- ─────────────────────────────────────────────────────────────────────────────

alter table "STL_CRM"
  add column if not exists "Interest_Posted_Upto" date;

alter table "Deposit_Amount"
  add column if not exists "Interest_Posted_Upto" date;

alter table "Other_Finance_Loan"
  add column if not exists "Interest_Posted_Upto" date;

-- Optional one-time seed of the go-live cut-over (uncomment & set your date):
-- update "STL_CRM"             set "Interest_Posted_Upto" = '2026-07-31' where "Interest_Posted_Upto" is null;
-- update "Deposit_Amount"      set "Interest_Posted_Upto" = '2026-07-31' where "Interest_Posted_Upto" is null;
-- update "Other_Finance_Loan"  set "Interest_Posted_Upto" = '2026-07-31' where "Interest_Posted_Upto" is null;
