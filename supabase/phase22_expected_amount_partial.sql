-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 22 — Expected Amount: "Partially Adjusted" status.
--
-- Adds "Adjusted_Amount": how much of the expected amount has been adjusted.
-- Set when an entry is marked 'Partially Adjusted' (the part adjusted) or
-- 'Adjusted' (the full amount); cleared when set back to 'Not Adjusted'.
--
-- Run this once in Supabase → SQL Editor (after phase21). Safe to re-run.
-- ─────────────────────────────────────────────────────────────────────────────

alter table "Expected_Amount" add column if not exists "Adjusted_Amount" numeric;

-- Rows already marked Adjusted count as fully adjusted.
update "Expected_Amount" set "Adjusted_Amount" = "Amount"
where "Status" = 'Adjusted' and "Adjusted_Amount" is null;
