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

-- 6) ALL-IN-ONE: run this block on its own (select it, then Run) — one result
--    with every row that matters for Mal-STL69 / Mal-21, JSON shown as text.
--    Partner edits save Finance_Name too, so a clashing Partner_ID may now show
--    BOTH rows under the same finance — hence "count(*) > 1", not distinct finance.
select 1 as part, 'loan' as kind, "Finance_Name" as finance, "Loan_No" as code,
       concat_ws(' | ', "Customer_STL_NO", "Customer_Name", 'partner=' || "Referred_Partner",
                 'amt=' || "Loan_Amount", 'repaid=' || "Repaid_Amount", 'out=' || "Outstand_Amount", "Loan_Status") as details,
       null::timestamptz as at
from "Loan_Processing"
where "Customer_STL_NO" = 'Mal-STL69' or "Loan_No" = 'Mal-21'
union all
select 2, 'customer', "Finance_Name", "Customer_STL_NO",
       concat_ws(' | ', "Customer_Name", 'out=' || "Outstand_Loan", 'given=' || "Total_Loan_Given", "Status"), null
from "STL_CRM" where "Customer_STL_NO" = 'Mal-STL69'
union all
select 3, 'partner', "Finance_Name", "Partner_ID", concat_ws(' | ', "Partner_Name", "Phone_Number"), null
from "Partner"
where "Partner_ID" in (select "Partner_ID" from "Partner" where "Partner_ID" like 'Mal-%'
                       group by "Partner_ID" having count(*) > 1)
union all
select 4, 'log ' || "Action" || ' ' || "Entity", "User", "Entity_Label",
       concat_ws('  ==>  ', "Before"::text, "After"::text), "Date"
from "Log"
where "Entity" in ('Partner', 'Loan_Processing', 'STL_CRM')
  and "Date" >= '2026-10-01'
  and ("Entity_Label" ilike '%suresh%' or "Before"::text ilike '%Mal-STL69%' or "After"::text ilike '%Mal-STL69%'
       or "Entity" = 'Partner')
order by part, at, finance, code;

-- 7) WHERE DID LOAN Mal-21 GO? Run this block on its own. Block 6 found no
--    Loan_Processing row for Mal-21 / Mal-STL69 at all, yet the customer still
--    shows out=220000. This lists every loan for "Suresh … vanga…" under ANY
--    code, every logged action that mentions Mal-21 anywhere (a delete of a
--    Malar_Appa "Mal-21" by code would have removed both houses' rows), and the
--    ledger rows for Mal-21 / Mal-STL69.
select 1 as part, 'loan' as kind, "Finance_Name" as finance, "Loan_No" as code,
       concat_ws(' | ', "Customer_STL_NO", "Customer_Name", 'partner=' || "Referred_Partner",
                 'amt=' || "Loan_Amount", 'out=' || "Outstand_Amount", "Loan_Status") as details,
       null::timestamptz as at
from "Loan_Processing"
where "Customer_Name" ilike '%suresh%vanga%' or "Customer_Name" ilike '%suresh%balu%'
union all
select 2, 'log ' || "Action" || ' ' || "Entity", "User", "Entity_Label",
       left(concat_ws('  ==>  ', "Before"::text, "After"::text), 1500), "Date"
from "Log"
where "Entity_Label" ilike '%Mal-21%' or "Before"::text ilike '%"Mal-21"%' or "After"::text ilike '%"Mal-21"%'
   or "Entity_Label" ilike '%vanga%'
union all
select 3, 'ledger', "Finance_Name", "Ref_ID",
       concat_ws(' | ', "Date_Transaction", "STL_No", "Loan_No", "Customer_Name", "Nature_Transaction",
                 'rcpt=' || "Receipt_Amount", 'pay=' || "Payment_Amount"), null
from "Transaction_Ledger"
where "Loan_No" = 'Mal-21' or "STL_No" = 'Mal-STL69'
order by part, at nulls last, code;
