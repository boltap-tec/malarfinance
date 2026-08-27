-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 10 — interest posting register.
--
-- Records ONE row per interest-posting run (a finance scope + a month), so the
-- app can show exactly which months have been posted and BLOCK re-running a
-- month that's already been posted ("completed") — no more doubt about whether a
-- month was run, and no risk of charging interest twice.
--
-- The app upserts a row keyed by "ID" = `${Finance_Name}-${Month}` (Month is
-- YYYY-MM). Re-posting the same month after a correction overwrites that one row.
--
-- Run this once in Supabase → SQL Editor.
-- (You must also have run phase3_write_policies.sql so inserts/updates persist.)
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists "Interest_Posting_Log" (
  "ID" text primary key,
  "Finance_Name" text,
  "Month" text,                 -- YYYY-MM
  "From_Date" date,
  "To_Date" date,
  "Posted_On" timestamptz,
  "Customer_Lines" integer,
  "Deposit_Lines" integer,
  "Other_Lines" integer,
  "Customer_Amount" numeric,
  "Deposit_Amount" numeric,
  "Other_Amount" numeric,
  "Posted_By" text
);

-- Read + write policies for the anon key (same blanket pattern as phase 3).
alter table "Interest_Posting_Log" enable row level security;
drop policy if exists "app_read"  on "Interest_Posting_Log";
create policy "app_read"  on "Interest_Posting_Log" for select using (true);
drop policy if exists "app_write" on "Interest_Posting_Log";
create policy "app_write" on "Interest_Posting_Log" for all using (true) with check (true);
