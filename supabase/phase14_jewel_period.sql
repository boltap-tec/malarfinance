-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 14 — Jewel loan settle-by period + Active/Closed status.
--
-- Adds the "Due_Date" column to Jewel_Loan (the period to settle by — defaults
-- in the app to one week before the loan completes a year). A bell reminder
-- shows from 15 days before this date. Existing "Open" statuses are relabelled
-- to "Active" to match the new status control.
--
-- Safe to run once, after phase13. (If you have a fresh database, phase13 now
-- already includes the Due_Date column and this script is a harmless no-op.)
-- Run in Supabase → SQL Editor.
-- ─────────────────────────────────────────────────────────────────────────────

alter table "Jewel_Loan" add column if not exists "Due_Date" text;

-- Relabel any legacy "Open" jewel loans to "Active".
update "Jewel_Loan" set "Loan_Status" = 'Active' where "Loan_Status" = 'Open';
