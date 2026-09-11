-- Fix loans where interest leaked into the principal outstanding (old repay
-- screen). Restores the invariant  Outstand_Amount = Loan_Amount - Repaid_Amount
-- and re-syncs the STL_CRM customer roll-up.
--
-- WRITE operation. Run diagnose_principal_interest_leak.sql FIRST and review the
-- rows. Take a backup (Settings > Download backup, or a Supabase snapshot) before
-- running. Everything is wrapped in a transaction so you can ROLLBACK.

begin;

-- ── Option A: just Surrendar Puthur (Chi-STL4) ──────────────────────────────
-- Uncomment to fix ONLY this customer while you verify the approach.
-- update "Loan_Processing"
-- set "Outstand_Amount" = "Loan_Amount" - coalesce("Repaid_Amount", 0)
-- where "Customer_STL_NO" = 'Chi-STL4'
--   and round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) > 0;

-- ── Option B: every customer loan with a positive gap (the interest leak) ────
-- gap > 0 only: outstanding was reduced too much. Rows with gap < 0 (e.g. past
-- over-payments) are intentionally left untouched — review those by hand.
update "Loan_Processing"
set "Outstand_Amount" = "Loan_Amount" - coalesce("Repaid_Amount", 0),
    "Loan_Status" = case
      when ("Loan_Amount" - coalesce("Repaid_Amount", 0)) <= 0 then 'Closed'
      else "Loan_Status"
    end
where round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) > 0;

-- Re-sync each customer's Outstand_Loan roll-up from their loans.
update "STL_CRM" s
set "Outstand_Loan" = sub.tot
from (
  select "Customer_STL_NO", sum(coalesce("Outstand_Amount", 0)) as tot
  from "Loan_Processing"
  group by "Customer_STL_NO"
) sub
where s."Customer_STL_NO" = sub."Customer_STL_NO"
  and coalesce(s."Outstand_Loan", 0) <> sub.tot;

-- Verify BEFORE committing: this should now return 0 rows.
select "Customer_STL_NO", "Loan_No", "Loan_Amount", "Repaid_Amount", "Outstand_Amount",
       round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) as gap
from "Loan_Processing"
where round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) > 0;

-- If the numbers look right:   commit;
-- If anything looks wrong:     rollback;
commit;
