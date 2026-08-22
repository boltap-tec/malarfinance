-- ─────────────────────────────────────────────────────────────────────────────
-- Arul Finance — Phase 5
-- Run this ONCE in the Supabase SQL editor (Dashboard → SQL Editor → New query).
--
-- It fixes: "Could not find the table 'public.Hand_Exchange'..." and adds the new
-- columns the app now writes, plus a "created_at" audit column (the date each row
-- was first written to the database). Safe to re-run — every step is guarded.
-- ─────────────────────────────────────────────────────────────────────────────

-- 1) Hand Exchange (personal give & take) — the missing table.
create table if not exists "Hand_Exchange" (
  "ID"           text primary key,
  "Date"         text,
  "Person"       text,
  "Person_Phone" text,
  "Amount"       numeric,
  "Direction"    text,   -- 'out' | 'in'
  "Type"         text,   -- Give | Get | Borrow | Return
  "Mode"         text,
  "Note"         text,
  "Remarks"      text
);
alter table if exists "Hand_Exchange" disable row level security;

-- 2) New columns used by the latest chit / invested-chit features.
alter table if exists "Chit_Member"        add column if not exists "Member_Commission"  numeric;
alter table if exists "Invested_Chit"      add column if not exists "Chit_Taken_Amount"  numeric;
alter table if exists "Invested_Chit"      add column if not exists "Chit_Taken_Date"    text;
alter table if exists "Invested_Chit_Trans" add column if not exists "Kind"              text;   -- 'Payment' | 'Receipt'
alter table if exists "Chit_Ledger"        add column if not exists "Remarks"            text;
alter table if exists "Chit_Taken_Member"  add column if not exists "Remarks"            text;

-- 3) "Date of entry in the database" — a created_at timestamp on every table.
--    Postgres fills it automatically on insert; existing rows get the run time.
do $$
declare t text;
begin
  foreach t in array array[
    'Finance_Details','Partner','STL_CRM','Loan_Processing','Interest_Details',
    'Transaction_Ledger','Nature_Transaction','Deposit_Amount','Depositer_Interest',
    'Other_Finance_Loan','Other_Finance_Interest','Invested_Chit','Invested_Chit_Trans',
    'Chit_Creation','Chit_Member','Chit_Auction','Chit_Taken_Member','Chit_Ledger',
    'Worker','Notification','Message','Log','Hand_Exchange'
  ]
  loop
    if exists (select 1 from information_schema.tables where table_schema='public' and table_name=t) then
      execute format('alter table %I add column if not exists "created_at" timestamptz default now()', t);
    end if;
  end loop;
end $$;
