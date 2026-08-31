-- ─────────────────────────────────────────────────────────────────────────────
-- Run-once: the two migrations interest posting needs (phase 9 + phase 10).
--
-- If posting a month shows "Not saved to the database" / a schema error and the
-- data disappears on reload, it's because these objects don't exist in Supabase
-- yet. Paste this whole file into Supabase → SQL Editor and Run. It is safe to
-- run more than once (every statement is idempotent).
--
-- After running it, go back to the app and post the month again — it will persist.
-- (You must also have run phase3_write_policies.sql at some point so writes stick.)
-- ─────────────────────────────────────────────────────────────────────────────

-- ── Phase 9 — per-item "interest posted up to" column ────────────────────────
-- The per-finance source of truth for how far each item has been billed. Each
-- monthly posting stamps it to the month end; the next run resumes the day after.
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

-- ── Per-finance interest cut-over ────────────────────────────────────────────
-- Each finance now keeps its OWN "interest posted up to" date on its master row,
-- replacing the single global setting so finances post independently. Set each
-- finance's date in the app (Settings → Interest posting → per finance).
alter table "Finance_Details"
  add column if not exists "Interest_Posted_Upto" date;

-- ── Phase 10 — interest posting register ─────────────────────────────────────
-- One row per posting run (a finance + a month), so the app knows which months
-- are posted and blocks re-running them. Keyed by ID = `${Finance_Name}-${Month}`.
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

-- ── Fix: Depositer_Interest.Interest_Type was created as numeric ─────────────
-- The app stores the interest kind ("Per_Month") there, so posting deposit
-- interest failed with: invalid input syntax for type numeric: "Per_Month".
-- Widen the column to text. (Interest_Details and Other_Finance_Interest are
-- already text.) Idempotent — a no-op if it's already text.
do $$
begin
  if exists (
    select 1 from information_schema.columns
    where table_name = 'Depositer_Interest' and column_name = 'Interest_Type' and data_type = 'numeric'
  ) then
    alter table "Depositer_Interest" alter column "Interest_Type" type text using "Interest_Type"::text;
  end if;
end $$;
