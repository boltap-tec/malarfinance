-- fix_mal21_suresh_restore.sql
--
-- What happened (from the Activity Log), all by Malarvizhi on 2026-11-02:
--   06:48  "Edit Mal-21 · Amuthavel" — partner Mal-P1 → Mal-P2 on Malar_Appa's
--          loan Mal-21 (Amuthavel, ₹3,50,000, Closed). Malar_Finance ALSO has a
--          Mal-21 (Suresh annan vangapalayam, ₹2,20,000, Active), and the edit
--          updated by loan number only, so Suresh's loan was overwritten with
--          Amuthavel's figures (Closed, outstanding 0) — it vanished from lists.
--   07:02  "delete Mal-21 · Amuthavel" — deleted by loan number only, so BOTH
--          Mal-21 rows were removed.
--   07:03  ledger Ref 1600 "Loan disbursed — Mal-21" (Suresh, ₹2,20,000) deleted.
-- Also: Mal-STL69 has two identical STL_CRM rows (both Malar_Finance).
--
-- This puts Suresh's loan, its ledger entry and Amuthavel's loan back exactly as they were
-- logged, and removes the duplicate customer row. Run it BEFORE
-- phase17_malar_appa_prefix.sql. Run once; the inserts skip rows that exist.

begin;

-- 1) Suresh annan vangapalayam's loan Mal-21, from its creation log entry
--    (no repayment was recorded on it, so the created row is its current state)
insert into "Loan_Processing"
select (jsonb_populate_record(null::"Loan_Processing",
          l."After" || jsonb_build_object('created_at', l."Date"))).*   -- keep its original entry date
from "Log" l
where l."Action" = 'create' and l."Entity" = 'Loan_Processing'
  and l."After"->>'Loan_No' = 'Mal-21' and l."After"->>'Finance_Name' = 'Malar_Finance'
  and not exists (select 1 from "Loan_Processing" p
                  where p."Loan_No" = 'Mal-21' and p."Finance_Name" = 'Malar_Finance');

-- 2) Its "Loan disbursed — Mal-21" ledger row (Ref 1600), from the delete log
insert into "Transaction_Ledger"
select (jsonb_populate_record(null::"Transaction_Ledger", l."Before")).*
from "Log" l
where l."Action" = 'delete' and l."Entity" = 'Transaction_Ledger'
  and l."Before"->>'Ref_ID' = '1600' and l."Before"->>'Loan_No' = 'Mal-21'
  and not exists (select 1 from "Transaction_Ledger" t where t."Ref_ID" = '1600');

-- 3) Keep one of the two identical Mal-STL69 customer rows
delete from "STL_CRM"
where ctid in (select ctid from "STL_CRM"
               where "Customer_STL_NO" = 'Mal-STL69' and "Finance_Name" = 'Malar_Finance'
               order by ctid offset 1);

-- 4) Amuthavel's closed Malar_Appa loan Mal-21, from its delete log entry (the
--    row as it stood just before the delete, partner Mal-P2 as last edited)
insert into "Loan_Processing"
select (jsonb_populate_record(null::"Loan_Processing", l."Before")).*
from "Log" l
where l."Action" = 'delete' and l."Entity" = 'Loan_Processing'
  and l."Before"->>'Loan_No' = 'Mal-21' and l."Before"->>'Finance_Name' = 'Malar_Appa'
  and not exists (select 1 from "Loan_Processing" p
                  where p."Loan_No" = 'Mal-21' and p."Finance_Name" = 'Malar_Appa');

commit;

-- 5) Check — expect: Suresh's loan (Malar_Finance, Active, out 220000) AND
--    Amuthavel's (Malar_Appa, Closed, out 0), ledger 1600, one customer row
select 'loan' as kind, "Finance_Name", "Loan_No", "Customer_Name", "Outstand_Amount"::text as v, "Loan_Status" as s
from "Loan_Processing" where "Loan_No" = 'Mal-21'
union all
select 'ledger', "Finance_Name", "Ref_ID", "Customer_Name", "Payment_Amount"::text, "Nature_Transaction"
from "Transaction_Ledger" where "Ref_ID" = '1600'
union all
select 'customer', "Finance_Name", "Customer_STL_NO", "Customer_Name", "Outstand_Loan"::text, "Status"
from "STL_CRM" where "Customer_STL_NO" = 'Mal-STL69';
