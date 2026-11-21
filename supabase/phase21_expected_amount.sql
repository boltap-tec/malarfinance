-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 21 — Expected Amount (money you expect to receive / adjust later).
--
-- One row per expected amount, kept per finance firm (like Hand_Exchange) and
-- never posted to any ledger. Status starts as 'Not Adjusted'; when it is marked
-- 'Adjusted' the app records the date it was adjusted in "Adjusted_Date".
--
-- Run this once in Supabase → SQL Editor. Safe to re-run.
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists "Expected_Amount" (
  "ID"            text primary key,
  "Finance_Name"  text,
  "Date"          text,
  "Description"   text,
  "Amount"        numeric,
  "Status"        text default 'Not Adjusted',   -- 'Not Adjusted' | 'Adjusted'
  "Adjusted_Date" text,
  "Remarks"       text,
  "created_at"    timestamptz default now()
);

alter table "Expected_Amount" enable row level security;
drop policy if exists "app_read" on "Expected_Amount";
create policy "app_read" on "Expected_Amount" for select using (true);
drop policy if exists "app_write" on "Expected_Amount";
create policy "app_write" on "Expected_Amount" for all using (true) with check (true);
