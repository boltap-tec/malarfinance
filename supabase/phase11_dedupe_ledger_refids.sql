-- phase11_dedupe_ledger_refids.sql
--
-- Symptom: editing (or deleting) ONE ledger entry changed SEVERAL at once.
-- Cause:   "Transaction_Ledger" has no primary key / unique constraint, and the
--          data import left many rows sharing the same "Ref_ID". The app edits
--          and deletes rows by Ref_ID (update ... where "Ref_ID" = $1), so the
--          change hit every row that shared that id.
--
-- This migration gives every ledger row a UNIQUE "Ref_ID", then adds a UNIQUE
-- constraint so it can never happen again. After running it, refresh the app
-- (pull latest / reload) and each edit or delete will affect only its own row.
--
-- Run once in the Supabase SQL editor. Safe to re-run (idempotent).

begin;

-- 1) Reassign every DUPLICATE Ref_ID (the 2nd, 3rd, … occurrence) to a fresh
--    numeric id above the current maximum PURELY-numeric Ref_ID. Using the
--    numeric max (not composite string ids) keeps these clear of the ids the app
--    itself generates (max numeric + 1) and avoids bigint overflow on long
--    composite ids. The FIRST row of each group keeps its original Ref_ID.
do $$
declare mx bigint;
begin
  select coalesce(max("Ref_ID"::bigint), 0) into mx
    from "Transaction_Ledger" where "Ref_ID" ~ '^\d+$';

  with dup as (
    select ctid, row_number() over (partition by "Ref_ID" order by ctid) as rn
    from "Transaction_Ledger"
  ),
  tofix as (
    select ctid, row_number() over (order by ctid) as seq
    from dup where rn > 1
  )
  update "Transaction_Ledger" t
  set "Ref_ID" = (mx + tofix.seq)::text
  from tofix
  where t.ctid = tofix.ctid;
end $$;

-- 2) Give any remaining NULL / empty Ref_IDs a fresh id too (a single such row
--    can survive step 1, since NULLs group together in the window partition).
do $$
declare mx bigint;
begin
  select coalesce(max("Ref_ID"::bigint), 0) into mx
    from "Transaction_Ledger" where "Ref_ID" ~ '^\d+$';

  with tofix as (
    select ctid, row_number() over (order by ctid) as seq
    from "Transaction_Ledger"
    where "Ref_ID" is null or "Ref_ID" = ''
  )
  update "Transaction_Ledger" t
  set "Ref_ID" = (mx + tofix.seq)::text
  from tofix
  where t.ctid = tofix.ctid;
end $$;

-- 3) Enforce uniqueness from now on. (Wrapped so re-running is a no-op.)
--    Skip if the constraint is already there. Adding a UNIQUE constraint also
--    creates an index of the same name, so a leftover index raises 42P07
--    (duplicate_table), not 42710 (duplicate_object) — catch both so a partial
--    prior run can't abort this.
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'Transaction_Ledger_Ref_ID_key'
  ) then
    alter table "Transaction_Ledger"
      add constraint "Transaction_Ledger_Ref_ID_key" unique ("Ref_ID");
  end if;
exception when duplicate_object or duplicate_table then null;
end $$;

commit;

-- Verification — both queries should return 0 rows:
--   select "Ref_ID", count(*) from "Transaction_Ledger"
--   group by "Ref_ID" having count(*) > 1;
--
--   select count(*) from "Transaction_Ledger" where "Ref_ID" is null or "Ref_ID" = '';
