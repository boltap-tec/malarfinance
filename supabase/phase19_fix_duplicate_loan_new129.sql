-- phase19_fix_duplicate_loan_new129.sql
-- Loan number New-129 ended up on TWO loans in New Finance:
--   * Manoj raghavendra shop (New-STL336) — the original ₹10,000 loan of 2026-04-04
--   * Periasamy cable (New-STL353)        — a ₹90,000 loan given 2026-09-10
-- The app used to number a new loan as (loan count + 1), so after a loan was
-- deleted it re-issued an existing number. Every edit/delete keyed on Loan_No then
-- hit both rows, which overwrote Manoj's loan with Periasamy's amount and date.
--
-- This script:
--   1. gives Periasamy's loan (and its interest + ledger rows) a fresh loan number
--   2. puts Manoj's New-129 back to its original values (from the import)
--   3. re-adds Manoj's Apr–Jul 2026 interest rows if they are missing
--   4. refreshes Manoj's customer totals
-- Run the PREVIEW queries first, then the whole script in the Supabase SQL editor,
-- then hard-refresh the app.

-- ── PREVIEW (run on their own first) ─────────────────────────────────────────
-- select "Loan_No", "Customer_STL_NO", "Customer_Name", "Loan_Given_Date", "Loan_Amount", "Repaid_Amount", "Outstand_Amount", "Loan_Status"
--   from "Loan_Processing" where "Loan_No" = 'New-129';
-- select "ID", "Customer_STL_NO", "Month", "Interest_Amount", "Status" from "Interest_Details" where "Loan_No" = 'New-129' order by "Customer_STL_NO", "Month";
-- select "Ref_ID", "Date_Transaction", "Nature_Transaction", "STL_No", "Receipt_Amount", "Payment_Amount" from "Transaction_Ledger" where "Loan_No" = 'New-129' order by "STL_No", "Date_Transaction";
-- Any other shared loan numbers?
-- select "Loan_No", count(*) from "Loan_Processing" group by 1 having count(*) > 1;

begin;

-- 1. Renumber Periasamy cable's loan to the next free New Finance loan number.
do $$
declare
  new_no text;
begin
  select 'New-' || (coalesce(max((regexp_match("Loan_No", '-(\d+)$'))[1]::int), 0) + 1)
    into new_no
    from "Loan_Processing"
   where "Finance_Name" = 'New Finance';

  update "Loan_Processing"
     set "Loan_No" = new_no
   where "Loan_No" = 'New-129' and trim("Customer_STL_NO") = 'New-STL353';

  update "Interest_Details"
     set "Loan_No" = new_no,
         "ID" = replace("ID", '-New-129-', '-' || new_no || '-')
   where "Loan_No" = 'New-129' and trim("Customer_STL_NO") = 'New-STL353';

  update "Transaction_Ledger"
     set "Loan_No" = new_no,
         "ID" = replace("ID", '-New-129-', '-' || new_no || '-')
   where "Loan_No" = 'New-129' and trim("STL_No") = 'New-STL353';

  raise notice 'Periasamy cable loan renumbered New-129 -> %', new_no;
end $$;

-- 2. Restore Manoj raghavendra shop's New-129 to its original values.
--    No principal repayment is recorded for this loan, so ₹10,000 is outstanding.
update "Loan_Processing"
   set "Customer_STL_NO" = 'New-STL336',
       "Loan_Given_Date" = '2026-04-04',
       "Loan_Amount" = 10000,
       "Interest_Per_day_Per_Lakh" = 70,
       "Repaid_Amount" = 0,
       "Outstand_Amount" = 10000,
       "Loan_Status" = 'Active',
       "Referred_Partner" = 'New-P2',
       "Payment_Type" = 'Cash',
       "Interest_Type" = 'Per_Day'
 where "Loan_No" = 'New-129' and trim("Customer_STL_NO") = 'New-STL336';

-- …or re-create it if the row is gone altogether.
insert into "Loan_Processing" ("Finance_Name", "Loan_Given_Date", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "Loan_Amount", "Interest_Per_day_Per_Lakh", "Repaid_Amount", "Outstand_Amount", "Loan_Status", "Referred_Partner", "Payment_Type", "Interest_Type", "Customer_Type", "Customer_Ref")
select 'New Finance', '2026-04-04', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618, 10000, 70, 0, 10000, 'Active', 'New-P2', 'Cash', 'Per_Day', 'Existing', 'New-STL336-Manoj raghavendra shop'
 where not exists (select 1 from "Loan_Processing" where "Loan_No" = 'New-129' and "Customer_STL_NO" = 'New-STL336');

-- 3. Manoj's Apr–Jul 2026 interest rows (skipped if already there). July is marked
--    Paid: the ledger has its ₹220 receipt on 2026-08-08.
insert into "Interest_Details" ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Total_Month_Days")
select v.* from (values
  ('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-04-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618, '2026-04-01', '2026-04-30', '2026-04-04', 27, '70', 190, 10000, '2026-04-04', '04-2026', 'Interest-04-2026', 190, 'Paid', 0, 'New-P2', 0, 'Yes', 190, 0, 'Per_Day', 30),
  ('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-05-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618, '2026-05-01', '2026-05-31', '2026-05-01', 31, '70', 220, 10000, '2026-04-04', '05-2026', 'Interest-05-2026', 220, 'Paid', 0, 'New-P2', 0, 'Yes', 220, 0, 'Per_Day', 31),
  ('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-06-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618, '2026-06-01', '2026-06-30', '2026-06-01', 30, '70', 210, 10000, '2026-04-04', '06-2026', 'Interest-06-2026', 210, 'Paid', 0, 'New-P2', 0, 'Yes', 210, 0, 'Per_Day', 30),
  ('Manoj raghavendra shop-New-STL336-New-129-10000-Interest-07-2026', 'New Finance', 'New-129', 'New-STL336', 'Manoj raghavendra shop', 8838622618, '2026-07-01', '2026-07-31', '2026-07-01', 31, '70', 220, 10000, '2026-04-04', '07-2026', 'Interest-07-2026', 220, 'Paid', 0, 'New-P2', 0, 'Yes', 220, 0, 'Per_Day', 31)
) as v("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name", "Customer_Phone_No", "From_Date", "To_Date", "Actual_From_Date", "No_Days", "Interest_Per_day_Per_Lakh", "Interest_Amount", "Loan_Amount", "Loan_Given_Date", "Month", "Description", "Amount_Received", "Status", "Interest_Pending", "Referred_Partner", "Pending_Month_Interest", "Eligible", "Total_Month_Interest", "Total_Loan_Amount", "Interest_Type", "Total_Month_Days")
where not exists (select 1 from "Interest_Details" i where i."Customer_STL_NO" = 'New-STL336' and i."Month" = v."Month");

-- 4. Customer roll-up.
update "STL_CRM"
   set "Total_Loan_Given" = 10000, "Outstand_Loan" = 10000
 where "Customer_STL_NO" = 'New-STL336' and "Finance_Name" = 'New Finance';

commit;
