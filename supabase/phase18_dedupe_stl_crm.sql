-- phase18_dedupe_stl_crm.sql
--
-- Symptom: one customer (e.g. New-STL352 "Jeeva Tea Kumba") listed many times
--          on the Customers page.
-- Cause:   "STL_CRM" has no key, and the Save button stayed clickable while the
--          insert was in flight, so repeat taps stored the same customer again.
--
-- This removes the extra copies (keeping one row per finance + STL no.), then
-- adds a UNIQUE (Finance_Name, Customer_STL_NO) constraint so it can't recur.
-- The key is per finance on purpose: two finances may legitimately share a code
-- until Settings → Fix prefixes re-codes them.
--
-- Run once in the Supabase SQL editor. Safe to re-run (idempotent).

-- 0) Preview — the duplicated customers and how many copies each has:
--   select "Finance_Name", "Customer_STL_NO", "Customer_Name", count(*)
--   from "STL_CRM"
--   group by "Finance_Name", "Customer_STL_NO", "Customer_Name"
--   having count(*) > 1;

begin;

-- 1) Delete the 2nd, 3rd, … copy of each finance + STL no. (the first stays).
--    Balances are not lost: the app recomputes the roll-up columns from loans
--    and interest rows.
with dup as (
  select ctid, row_number() over (
    partition by "Finance_Name", "Customer_STL_NO" order by ctid) as rn
  from "STL_CRM"
)
delete from "STL_CRM" t
using dup
where t.ctid = dup.ctid and dup.rn > 1;

-- 2) Enforce uniqueness from now on (no-op if already there).
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'STL_CRM_finance_stl_key'
  ) then
    alter table "STL_CRM"
      add constraint "STL_CRM_finance_stl_key" unique ("Finance_Name", "Customer_STL_NO");
  end if;
exception when duplicate_object or duplicate_table then null;
end $$;

commit;

-- Verification — should return 0 rows:
--   select "Finance_Name", "Customer_STL_NO", count(*) from "STL_CRM"
--   group by "Finance_Name", "Customer_STL_NO" having count(*) > 1;
