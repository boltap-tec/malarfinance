-- ─────────────────────────────────────────────────────────────────────────────
-- Arul Finance — Phase 4: Other-finance interest schedule
-- Run in the Supabase SQL editor. Depositer_Interest already exists (migrate.sql);
-- this adds the matching table for interest the finance owes other finances.
-- RLS is left OFF (see phase3.sql) so the app's key can read & write.
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists "Other_Finance_Interest" (
  "ID"                        text primary key,
  "Finance_Name"              text,
  "Loan_No"                   text,
  "Loan_bought_Finance_Name"  text,
  "From_Date"                 text,
  "To_Date"                   text,
  "No_Days"                   numeric,
  "Interest_Amount"           numeric,
  "Loan_Amount"               numeric,
  "Month"                     text,
  "Description"               text,
  "Amount_Received"           numeric,
  "Status"                    text,
  "Interest_Pending"          numeric,
  "Interest_Type"             text
);
alter table if exists "Other_Finance_Interest" disable row level security;
