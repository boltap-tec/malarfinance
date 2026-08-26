-- Hand Exchange upgrade — adds the optional "Category" column (Customer / Supplier).
-- Run this ONCE in Supabase (Dashboard → SQL Editor) if you already ran migrate.sql
-- before this upgrade. It is safe to re-run and never touches any finance table.
alter table "Hand_Exchange" add column if not exists "Category" text;
