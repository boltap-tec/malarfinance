-- Diagnose Nagaraj Post (New-STL301, New Finance): repayment interest in Oct 2026.
--   5 Oct repay ₹1,00,000 was charged ₹250 (expected ₹280 for 1–4 Oct @ ₹70/L/day)
--   13 Oct repay ₹2,90,000 was charged 05–12 Oct ₹1,620 (expected 01–12 Oct ₹2,440)
-- Suspected cause: loan New-134's stored Loan_Given_Date was 05 Oct (its entry
-- date) when the repayments were recorded, though its ledger row says 29 Sep.
--
-- READ-ONLY: these are SELECTs. Nothing is modified. Run each block and share
-- the results.

-- 1) The customer's loans — given date, rate, amounts.
select "Loan_No", "Loan_Given_Date", "Loan_Amount", "Repaid_Amount", "Outstand_Amount",
       "Interest_Type", "Interest_Per_day_Per_Lakh", "Loan_Status", "created_at"
from "Loan_Processing"
where "Customer_STL_NO" = 'New-STL301'
order by "Loan_Given_Date";

-- 2) The customer's "interest posted till" date (repayment interest starts the day after).
select "Customer_STL_NO", "Customer_Name", "Interest_Posted_Upto"
from "STL_CRM"
where "Customer_STL_NO" = 'New-STL301';

-- 3) Sep/Oct interest rows (monthly posting + repayment rows).
select "ID", "Loan_No", "From_Date", "To_Date", "No_Days", "Loan_Amount",
       "Interest_Amount", "Amount_Received", "Status", "Description", "created_at"
from "Interest_Details"
where "Customer_STL_NO" = 'New-STL301'
  and "To_Date" >= '2026-09-01'
order by "To_Date", "created_at";

-- 4) Loan given / repaid ledger rows — compare Date_Transaction with the loan dates above.
select "Date_Transaction", "Nature_Transaction", "Loan_No", "Description",
       "Receipt_Amount", "Payment_Amount", "created_at"
from "Transaction_Ledger"
where "STL_No" = 'New-STL301'
  and "Nature_Transaction" in ('Loan_To_Customer', 'Customer_Loan_Prin_Repayment')
order by "Date_Transaction";

-- 5) Activity log — any edit of New-134 or of these ledger rows (shows Before/After dates).
select "Date", "User", "Action", "Entity", "Entity_Label", "Before", "After"
from "Log"
where "Entity_Label" ilike '%New-134%' or "Entity_Label" ilike '%Nagaraj%'
order by "Date";

-- 6) ALL finances: loans whose given date disagrees with their "Loan disbursed"
--    ledger date (the same mismatch that under-billed New-134).
select l."Finance_Name", l."Loan_No", l."Customer_Name", l."Loan_Amount", l."Loan_Status",
       l."Loan_Given_Date", t."Date_Transaction" as ledger_date
from "Loan_Processing" l
join "Transaction_Ledger" t
  on t."Loan_No" = l."Loan_No" and t."Finance_Name" = l."Finance_Name"
 and t."Nature_Transaction" = 'Loan_To_Customer'
where t."Date_Transaction"::date <> l."Loan_Given_Date"::date
order by l."Finance_Name", l."Loan_No";
