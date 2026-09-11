-- One-off correction for Surrendar Puthur (Chi-STL4).
-- His loan's outstanding is showing 1,93,800; it should be 2,00,000. The old
-- repayment screen folded a past interest amount (6,200) into Repaid_Amount, so
-- the row balances internally and the generic reconcile can't detect it.
--
-- This forces the true state: Outstand_Amount = 2,00,000 and
-- Repaid_Amount = Loan_Amount - 2,00,000 (interest removed from principal).
-- Interest_Details (his pending interest) is NOT touched.
--
-- Run in the Supabase SQL Editor. Transaction-wrapped: review the pre-check and
-- the verify output, then COMMIT (or ROLLBACK).

begin;

-- PRE-CHECK — expect exactly ONE row with a non-zero outstanding. If more than
-- one active loan appears here, STOP and rollback; tell me the Loan_No to target.
select "Loan_No", "Loan_Amount", "Repaid_Amount", "Outstand_Amount", "Loan_Status"
from "Loan_Processing"
where "Customer_STL_NO" = 'Chi-STL4'
order by coalesce("Outstand_Amount",0) desc;

-- FIX — the active loan carrying the outstanding.
update "Loan_Processing"
set "Repaid_Amount"   = "Loan_Amount" - 200000,
    "Outstand_Amount" = 200000,
    "Loan_Status"     = 'Active'
where "Customer_STL_NO" = 'Chi-STL4'
  and coalesce("Outstand_Amount", 0) > 0;

-- Refresh his customer roll-up (this is the number the Customers list shows).
update "STL_CRM" s
set "Outstand_Loan"    = sub.tot,
    "Total_Loan_Given" = sub.given
from (
  select "Customer_STL_NO",
         sum(coalesce("Outstand_Amount", 0)) as tot,
         sum(coalesce("Loan_Amount", 0))     as given
  from "Loan_Processing"
  where "Customer_STL_NO" = 'Chi-STL4'
  group by "Customer_STL_NO"
) sub
where s."Customer_STL_NO" = sub."Customer_STL_NO";

-- VERIFY — loan Outstand_Amount and STL_CRM Outstand_Loan should both read 200000.
select l."Loan_No", l."Loan_Amount", l."Repaid_Amount", l."Outstand_Amount",
       c."Outstand_Loan"
from "Loan_Processing" l
join "STL_CRM" c on c."Customer_STL_NO" = l."Customer_STL_NO"
where l."Customer_STL_NO" = 'Chi-STL4';

-- Looks right? -> commit;   Something off? -> rollback;
commit;
