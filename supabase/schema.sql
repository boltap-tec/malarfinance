-- ─────────────────────────────────────────────────────────────────────────────
-- Arul Finance — Supabase (Postgres) schema draft
-- Run this in the Supabase SQL editor when you're ready to move off the local
-- seed. Then reimplement src/data/repository.ts with supabase-js; no screen
-- changes needed. Column names mirror the app's TypeScript types.
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists finance (
  finance_name text primary key,
  date_opened date,
  no_partners int,
  initial_capital_partner numeric,
  phone_number text,
  md_name text
);

create table if not exists partner (
  partner_id text primary key,
  finance_name text references finance(finance_name),
  partner_name text not null,
  phone_number text,
  email_address text,
  role text default 'partner'          -- 'owner' | 'partner'
);

create table if not exists customer (
  customer_stl_no text primary key,
  finance_name text references finance(finance_name),
  customer_name text not null,
  customer_phone_no text,
  customer_email text,
  customer_adhar_no text,
  total_loan_given numeric default 0,
  outstand_loan numeric default 0,
  total_interest_paid numeric default 0,
  outstanding_interest numeric default 0,
  status text default 'Active'
);

create table if not exists loan (
  loan_no text primary key,
  finance_name text references finance(finance_name),
  customer_stl_no text references customer(customer_stl_no),
  customer_name text,
  customer_phone_no text,
  loan_given_date date,
  loan_amount numeric not null,
  interest_per_day_per_lakh numeric,
  interest_per_month_per_lakh numeric,
  interest_type text default 'Per_Day',   -- 'Per_Day' | 'Per_Month'
  repaid_amount numeric default 0,
  outstand_amount numeric default 0,
  loan_status text default 'Active',
  referred_partner text,
  payment_type text,
  remarks text
);

create table if not exists interest_row (
  id text primary key,
  finance_name text,
  loan_no text,
  customer_stl_no text,
  customer_name text,
  from_date date,
  to_date date,
  no_days int,
  interest_amount numeric,
  loan_amount numeric,
  month text,
  description text,
  amount_received numeric default 0,
  status text default 'Pending',
  interest_pending numeric,
  referred_partner text,
  interest_type text,
  created_at timestamptz default now()
);

create table if not exists ledger (
  ref_id text primary key,
  date_transaction date,
  nature_transaction text,
  linked_id text,
  stl_no text,
  loan_no text,
  customer_name text,
  description text,
  receipt_amount numeric default 0,
  payment_amount numeric default 0,
  balance numeric,
  payment_type text,
  finance_name text,
  interest_amount numeric
);

create table if not exists deposit (
  deposit_no text primary key,
  finance_name text references finance(finance_name),
  depositer_name text,
  depositer_phone_no text,
  deposit_amount numeric,
  interest_per_month_per_lakh numeric,
  repaid_amount numeric default 0,
  outstand_amount numeric default 0,
  deposit_status text default 'Active',
  interest_type text
);

-- Helpful indexes
create index if not exists idx_loan_customer on loan(customer_stl_no);
create index if not exists idx_loan_finance on loan(finance_name);
create index if not exists idx_interest_loan on interest_row(loan_no);
create index if not exists idx_ledger_finance on ledger(finance_name);

-- ── Interest posting as a server-side function (mirrors the app engine) ───────
-- Round to nearest 10, inclusive day count. Call from a scheduled Supabase cron
-- to replace the monthly Apps Script run.
create or replace function round10(v numeric) returns numeric
  language sql immutable as $$ select round(v / 10) * 10 $$;
