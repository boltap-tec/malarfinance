-- ─────────────────────────────────────────────────────────────────────────────
-- Arul Finance — Phase 3: allow the app to WRITE to the database
--
-- Symptom this fixes: adding a loan (or anything) does not appear in Supabase.
-- Cause: Row Level Security is ON for these tables and there is no INSERT/UPDATE/
-- DELETE policy for the anon key, so PostgREST rejects writes with error 42501
-- ("new row violates row-level security policy").
--
-- This app authenticates with its OWN phone + password gate and talks to Supabase
-- with the public anon key, so we turn RLS OFF on the data tables. That makes the
-- data readable AND writable by anyone holding the anon key — acceptable for a
-- single small business, but revisit with Supabase Auth + real per-user policies
-- before exposing this widely.
--
-- Run this once in the Supabase SQL editor.
-- ─────────────────────────────────────────────────────────────────────────────

alter table if exists "Finance_Details"     disable row level security;
alter table if exists "Partner"              disable row level security;
alter table if exists "STL_CRM"              disable row level security;
alter table if exists "Loan_Processing"      disable row level security;
alter table if exists "Interest_Details"     disable row level security;
alter table if exists "Transaction_Ledger"   disable row level security;
alter table if exists "Nature_Transaction"   disable row level security;
alter table if exists "Deposit_Amount"       disable row level security;
alter table if exists "Depositer_Interest"   disable row level security;
alter table if exists "Other_Finance_Loan"   disable row level security;
alter table if exists "Jewel_Loan"           disable row level security;
alter table if exists "Invested_Chit"        disable row level security;
alter table if exists "Invested_Chit_Trans"  disable row level security;
alter table if exists "Chit_Creation"        disable row level security;
alter table if exists "Chit_Member"          disable row level security;
alter table if exists "Chit_Auction"         disable row level security;
alter table if exists "Chit_Taken_Member"    disable row level security;
alter table if exists "Chit_Ledger"          disable row level security;
alter table if exists "Worker"               disable row level security;
alter table if exists "Notification"         disable row level security;
alter table if exists "Message"              disable row level security;
alter table if exists "Log"                  disable row level security;
