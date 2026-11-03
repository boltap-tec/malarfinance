-- phase17_malar_appa_prefix.sql
--
-- Symptom: editing a Malar_Appa loan / customer / partner also changed a
--          Malar_Finance one (or the other way round).
-- Cause:   both finance names start with "Mal", so both houses' codes were
--          "Mal-…" (Mal-STL69, Mal-21, Mal-P3 …) and existed in BOTH houses.
--          The app edits rows by code alone, so one edit hit both.
--
-- This re-codes every EXISTING Malar_Appa row from "Mal-…" to "MalA-…", the
-- prefix the app now gives Malar_Appa (financePrefix in repository.ts). It does
-- the same job as Settings → "Fix prefixes now", without needing the new build.
-- Malar_Finance rows are never touched: every update is scoped by Finance_Name.
-- Amounts, dates, balances, Ref_IDs and interest IDs are not changed.
--
-- BEFORE RUNNING: download a backup, and run block 6 of
-- diagnose_malar_code_collision.sql. If a Malar_Appa partner was moved into
-- Malar_Finance by the partner edit, put it back first (Finance_Name =
-- 'Malar_Appa') or its loans will point at a partner code that doesn't exist.
--
-- Run once in the Supabase SQL editor. Safe to re-run: "MalA-…" never matches
-- 'Mal-%', so already re-coded rows are skipped.

begin;

-- 1) Jewel photos carry no Finance_Name — re-code only photos whose loan number
--    belongs to Malar_Appa alone (do this before the jewel loans move).
update "Jewel_Loan_Photo" p set "Loan_No" = 'MalA' || substr(p."Loan_No", 4)
where p."Loan_No" like 'Mal-%'
  and p."Loan_No" in (select "Loan_No" from "Jewel_Loan" where "Finance_Name" = 'Malar_Appa')
  and p."Loan_No" not in (select "Loan_No" from "Jewel_Loan" where "Finance_Name" <> 'Malar_Appa');

-- 2) Every code column, Malar_Appa rows only (same list as CODE_COLUMNS in the app)
update "STL_CRM" set "Customer_STL_NO" = 'MalA' || substr("Customer_STL_NO", 4)
where "Finance_Name" = 'Malar_Appa' and "Customer_STL_NO" like 'Mal-%';

update "Loan_Processing" set "Loan_No" = 'MalA' || substr("Loan_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Loan_No" like 'Mal-%';
update "Loan_Processing" set "Customer_STL_NO" = 'MalA' || substr("Customer_STL_NO", 4)
where "Finance_Name" = 'Malar_Appa' and "Customer_STL_NO" like 'Mal-%';
update "Loan_Processing" set "Referred_Partner" = 'MalA' || substr("Referred_Partner", 4)
where "Finance_Name" = 'Malar_Appa' and "Referred_Partner" like 'Mal-%';

update "Interest_Details" set "Loan_No" = 'MalA' || substr("Loan_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Loan_No" like 'Mal-%';
update "Interest_Details" set "Customer_STL_NO" = 'MalA' || substr("Customer_STL_NO", 4)
where "Finance_Name" = 'Malar_Appa' and "Customer_STL_NO" like 'Mal-%';
update "Interest_Details" set "Referred_Partner" = 'MalA' || substr("Referred_Partner", 4)
where "Finance_Name" = 'Malar_Appa' and "Referred_Partner" like 'Mal-%';

update "Deposit_Amount" set "Deposit_No" = 'MalA' || substr("Deposit_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Deposit_No" like 'Mal-%';
update "Depositer_Interest" set "Deposit_No" = 'MalA' || substr("Deposit_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Deposit_No" like 'Mal-%';

update "Other_Finance_Loan" set "Loan_No" = 'MalA' || substr("Loan_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Loan_No" like 'Mal-%';
update "Other_Finance_Interest" set "Loan_No" = 'MalA' || substr("Loan_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Loan_No" like 'Mal-%';

update "Jewel_Loan" set "Loan_No" = 'MalA' || substr("Loan_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Loan_No" like 'Mal-%';

update "Transaction_Ledger" set "STL_No" = 'MalA' || substr("STL_No", 4)
where "Finance_Name" = 'Malar_Appa' and "STL_No" like 'Mal-%';
update "Transaction_Ledger" set "Loan_No" = 'MalA' || substr("Loan_No", 4)
where "Finance_Name" = 'Malar_Appa' and "Loan_No" like 'Mal-%';

update "Partner" set "Partner_ID" = 'MalA' || substr("Partner_ID", 4)
where "Finance_Name" = 'Malar_Appa' and "Partner_ID" like 'Mal-%';

commit;

-- 3) Check: every Malar_Appa code should now start with "MalA-" (all zeros)
select 'STL_CRM' as tbl, count(*) as still_mal from "STL_CRM" where "Finance_Name" = 'Malar_Appa' and "Customer_STL_NO" like 'Mal-%'
union all select 'Loan_Processing', count(*) from "Loan_Processing" where "Finance_Name" = 'Malar_Appa' and ("Loan_No" like 'Mal-%' or "Customer_STL_NO" like 'Mal-%' or "Referred_Partner" like 'Mal-%')
union all select 'Interest_Details', count(*) from "Interest_Details" where "Finance_Name" = 'Malar_Appa' and ("Loan_No" like 'Mal-%' or "Customer_STL_NO" like 'Mal-%')
union all select 'Deposit_Amount', count(*) from "Deposit_Amount" where "Finance_Name" = 'Malar_Appa' and "Deposit_No" like 'Mal-%'
union all select 'Transaction_Ledger', count(*) from "Transaction_Ledger" where "Finance_Name" = 'Malar_Appa' and ("STL_No" like 'Mal-%' or "Loan_No" like 'Mal-%')
union all select 'Partner', count(*) from "Partner" where "Finance_Name" = 'Malar_Appa' and "Partner_ID" like 'Mal-%';
