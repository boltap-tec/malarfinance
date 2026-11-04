-- phase20_fix_all_duplicate_loan_numbers.sql
-- Several loan numbers are held by more than one Loan_Processing row
-- (New-125 … New-137; New-130 three times). Two causes:
--   (a) a double-tapped "Disburse" saved the SAME loan twice — same customer,
--       date and amount. The extra copy is deleted (renaming it would create a
--       phantom second loan and double the outstanding), along with its twin
--       "Loan_To_Customer" ledger row so cash isn't counted twice.
--   (b) count-based numbering re-issued a number to a DIFFERENT customer's loan.
--       The oldest loan keeps the number; later ones become <no>-1, <no>-2, …
--       and their interest + ledger rows (matched by customer STL) follow.
-- A group where the same customer holds two DIFFERENT loans under one number
-- can't be split safely — it is left alone and reported (NOTICE) for a manual fix.
--
-- Run PREVIEW first, then the script, then STEP 3, then hard-refresh the app.

-- ── PREVIEW ──────────────────────────────────────────────────────────────────
-- select "Loan_No", "Customer_STL_NO", "Customer_Name", "Loan_Given_Date", "Loan_Amount", "Repaid_Amount", "Outstand_Amount", "Loan_Status"
--   from "Loan_Processing"
--  where "Loan_No" in (select "Loan_No" from "Loan_Processing" group by 1 having count(*) > 1)
--  order by "Loan_No", "Loan_Given_Date";

begin;

-- STEP 1 — (a) exact copies of the same loan.
create temp table twin_loans on commit drop as
select ctid as rid, "Loan_No" as loan_no, trim("Customer_STL_NO") as stl,
       row_number() over (partition by "Loan_No", trim("Customer_STL_NO"), "Loan_Given_Date", "Loan_Amount" order by ctid) as rn
  from "Loan_Processing";

delete from "Transaction_Ledger" t
 using (select ctid as rid,
               row_number() over (partition by "Loan_No", trim("STL_No"), "Date_Transaction", "Payment_Amount" order by ctid) as rn
          from "Transaction_Ledger"
         where "Nature_Transaction" = 'Loan_To_Customer'
           and ("Loan_No", trim("STL_No")) in (select loan_no, stl from twin_loans where rn > 1)) x
 where t.ctid = x.rid and x.rn > 1;

delete from "Loan_Processing"
 where ctid in (select rid from twin_loans where rn > 1);

-- STEP 2 — (b) one number on different customers' loans.
do $$
declare
  r record;
  new_no text;
begin
  for r in
    select * from (
      select ctid as rid, "Loan_No" as old_no, trim("Customer_STL_NO") as stl, "Customer_Name" as name,
             row_number() over (partition by "Loan_No" order by "Loan_Given_Date", ctid) as rn,
             count(*) over (partition by "Loan_No") as n,
             count(*) over (partition by "Loan_No", trim("Customer_STL_NO")) as n_same
        from "Loan_Processing"
    ) g
    where n > 1
    order by old_no, rn
  loop
    if r.n_same > 1 then
      raise notice 'SKIPPED %: % (%) holds two different loans under this number — fix by hand', r.old_no, r.name, r.stl;
      continue;
    end if;
    if r.rn = 1 then continue; end if;   -- the oldest loan keeps the number

    new_no := r.old_no || '-' || (r.rn - 1);

    update "Loan_Processing" set "Loan_No" = new_no where ctid = r.rid;

    update "Interest_Details"
       set "Loan_No" = new_no,
           "ID" = replace("ID", '-' || r.old_no || '-', '-' || new_no || '-')
     where "Loan_No" = r.old_no and trim("Customer_STL_NO") = r.stl;

    update "Transaction_Ledger"
       set "Loan_No" = new_no,
           "ID" = replace("ID", '-' || r.old_no || '-', '-' || new_no || '-')
     where "Loan_No" = r.old_no and trim("STL_No") = r.stl;

    raise notice '% -> % for % (%)', r.old_no, new_no, r.name, r.stl;
  end loop;
end $$;

commit;

-- STEP 3 — run on its own afterwards. Makes the database itself refuse a second
-- loan with an existing number from now on. If it errors, some number is still
-- shared (a SKIPPED group above) — fix that, then run it again.
-- create unique index "Loan_Processing_Loan_No_key" on "Loan_Processing" ("Loan_No");
