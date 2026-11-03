-- Diagnose the Malar_Finance / Malar_Appa code collision.
--
-- Both finance names start with "Mal", so financePrefix() gives both the same
-- "Mal" prefix and their STL numbers, loan numbers and partner IDs overlap
-- (Mal-STL69 can exist in BOTH houses). The app's edits update by the code
-- alone, so editing one house's loan also overwrites the other house's row with
-- the same code. This shows which codes overlap and what the recent edit did.
--
-- READ-ONLY: these are SELECTs. Nothing is modified. Run each block and review.

-- 1) Every STL number that exists in both houses
select "Customer_STL_NO", "Finance_Name", "Customer_Name", "Outstand_Loan", "Total_Loan_Given"
from "STL_CRM"
where "Customer_STL_NO" in (
  select "Customer_STL_NO" from "STL_CRM"
  where "Finance_Name" in ('Malar_Finance', 'Malar_Appa')
  group by "Customer_STL_NO" having count(distinct "Finance_Name") > 1)
order by "Customer_STL_NO", "Finance_Name";

-- 2) Every loan number that exists in both houses (rows that a single edit hits twice)
select "Loan_No", "Finance_Name", "Customer_STL_NO", "Customer_Name", "Referred_Partner",
       "Loan_Amount", "Repaid_Amount", "Outstand_Amount", "Loan_Status"
from "Loan_Processing"
where "Loan_No" in (
  select "Loan_No" from "Loan_Processing"
  where "Finance_Name" in ('Malar_Finance', 'Malar_Appa')
  group by "Loan_No" having count(distinct "Finance_Name") > 1)
order by "Loan_No", "Finance_Name";

-- 3) Every partner ID that exists in both houses
select "Partner_ID", "Finance_Name", "Partner_Name"
from "Partner"
where "Partner_ID" in (
  select "Partner_ID" from "Partner"
  where "Finance_Name" in ('Malar_Finance', 'Malar_Appa')
  group by "Partner_ID" having count(distinct "Finance_Name") > 1)
order by "Partner_ID", "Finance_Name";

-- 4) Both houses' rows for Mal-STL69 and their loans, as they stand now
select 'customer' as kind, "Finance_Name", "Customer_STL_NO", "Customer_Name",
       null as "Loan_No", null as "Referred_Partner", "Outstand_Loan" as amount, null as "Loan_Status"
from "STL_CRM" where "Customer_STL_NO" = 'Mal-STL69'
union all
select 'loan', "Finance_Name", "Customer_STL_NO", "Customer_Name",
       "Loan_No", "Referred_Partner", "Outstand_Amount", "Loan_Status"
from "Loan_Processing" where "Customer_STL_NO" = 'Mal-STL69'
order by 2, 1;

-- 5) The loan edits logged for Mal-STL69 (Before = the row the edit started from)
select "Date", "User", "Entity_Label", "Before", "After"
from "Log"
where "Entity" = 'Loan_Processing'
  and ("Before"->>'Customer_STL_NO' = 'Mal-STL69' or "After"->>'Customer_STL_NO' = 'Mal-STL69')
order by "Date" desc;
