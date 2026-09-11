-- Diagnose loans/deposits where interest appears to have leaked into the
-- principal outstanding (from the old repayment screen, before the rewrite).
--
-- Invariant the current app always maintains for every row:
--     Loan_Amount = Repaid_Amount + Outstand_Amount
-- (creation sets Outstand = full amount; every repayment moves principal from
--  Outstand into Repaid, leaving the sum unchanged — interest is never touched.)
--
-- Any row where this does NOT balance is corrupted. A POSITIVE gap means the
-- outstanding was reduced too much (interest was netted out of principal) and
-- needs that gap ADDED BACK to Outstand_Amount. A NEGATIVE gap usually means a
-- past over-payment clamped Outstand to 0 — inspect those separately.
--
-- READ-ONLY: these are SELECTs. Nothing is modified. Run each block and review.

-- 1) Customer loans (the flow where the leak was found — Surrendar Puthur etc.)
select
  "Finance_Name", "Customer_STL_NO", "Customer_Name", "Loan_No",
  "Loan_Amount", "Repaid_Amount", "Outstand_Amount", "Loan_Status",
  round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) as gap
from "Loan_Processing"
where round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) <> 0
order by gap desc, "Finance_Name", "Customer_STL_NO";

-- 2) Deposits (same invariant: Deposit_Amount = Repaid_Amount + Outstand_Amount)
select
  "Finance_Name", "Deposit_No", "Depositer_Name",
  "Deposit_Amount", "Repaid_Amount", "Outstand_Amount", "Deposit_Status",
  round(("Deposit_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) as gap
from "Deposit_Amount"
where round(("Deposit_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) <> 0
order by gap desc, "Finance_Name", "Deposit_No";

-- 3) Other-finance loans (same invariant)
select
  "Finance_Name", "Loan_No", "Loan_bought_Finance_Name",
  "Loan_Amount", "Repaid_Amount", "Outstand_Amount", "Loan_Status",
  round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) as gap
from "Other_Finance_Loan"
where round(("Loan_Amount" - coalesce("Repaid_Amount",0) - coalesce("Outstand_Amount",0))::numeric, 2) <> 0
order by gap desc, "Finance_Name", "Loan_No";
