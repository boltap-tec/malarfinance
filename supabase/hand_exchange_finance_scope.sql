-- Hand Exchange → per-finance-firm book.
-- Adds a "Finance_Name" column so each finance firm has its own hand-exchange
-- book (instead of one shared global list), and files every EXISTING entry
-- under Malar_Finance. Run ONCE in Supabase (Dashboard → SQL Editor).
-- Safe to re-run; never touches any finance ledger table.

alter table "Hand_Exchange" add column if not exists "Finance_Name" text;

-- Existing hand-exchange records predate finance scoping → assign to Malar_Finance.
update "Hand_Exchange" set "Finance_Name" = 'Malar_Finance' where "Finance_Name" is null;
