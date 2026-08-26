-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 8 — fix loans where an interest payment was mistakenly also booked as a
-- principal repayment (the old "Repay" screen pre-filled both boxes).
--
-- Confirmed corrections (master data = correct baseline):
--   • Ramkumar  Mal-6 : ₹32,320 wrongly repaid as principal (was interest-only)
--                       → Outstanding back to ₹2,50,000, Repaid ₹1,00,000
--   • Balu      Mal-3 : ₹57,020 wrongly repaid as principal
--                       → Outstanding back to ₹4,00,000, Repaid ₹0
--
-- Each block: restore the loan, fix the customer roll-up, and remove the phantom
-- principal-repayment receipt from the cash ledger (the real interest receipt is
-- left untouched). Run once in Supabase → SQL Editor. Safe if a row is missing
-- (the DELETE simply matches nothing).
-- ─────────────────────────────────────────────────────────────────────────────

-- Ramkumar · Mal-6 (STL Mal-STL14)
update "Loan_Processing"
  set "Repaid_Amount" = 100000, "Outstand_Amount" = 250000, "Loan_Status" = 'Active'
  where "Loan_No" = 'Mal-6';
update "STL_CRM" set "Outstand_Loan" = 750000 where "Customer_STL_NO" = 'Mal-STL14';
delete from "Transaction_Ledger"
  where "Nature_Transaction" = 'Customer_Loan_Prin_Repayment'
    and "STL_No" = 'Mal-STL14' and "Receipt_Amount" = 32320;

-- Balu · Mal-3 (STL Mal-STL11)
update "Loan_Processing"
  set "Repaid_Amount" = 0, "Outstand_Amount" = 400000, "Loan_Status" = 'Active'
  where "Loan_No" = 'Mal-3';
update "STL_CRM" set "Outstand_Loan" = 450000 where "Customer_STL_NO" = 'Mal-STL11';
delete from "Transaction_Ledger"
  where "Nature_Transaction" = 'Customer_Loan_Prin_Repayment'
    and "STL_No" = 'Mal-STL11' and "Receipt_Amount" = 57020;
