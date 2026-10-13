-- One-off: post the AUGUST 2026 interest for Priya (Chi-STL2 · Chit_Malar).
-- The monthly run skipped this customer, so no Aug row exists. This creates the
-- missing Interest_Details row directly, mirroring what the app's posting would
-- have written, and advances the customer's "posted up to" date so the app stays
-- consistent.
--
-- Assumption: bills the WHOLE of August (2026-08-01 → 2026-08-31, 31 days) on the
-- current outstanding of the customer's ACTIVE loan(s). If the loan started
-- mid-August, was already partly billed, or the VERIFY amount looks wrong, run
-- `rollback;` and send me the PRE-CHECK output — I'll adjust the proration.
--
-- Handles both interest types:
--   • Per_Month : outstanding × Interest_Per_Month_Per_Lakh / 100000
--   • Per_Day   : outstanding × Interest_Per_day_Per_Lakh  / 100000 × 31
-- Total rounded to the nearest ₹10 (as the app rounds per customer).
--
-- Run in the Supabase SQL Editor. Review the pre-checks + VERIFY, then commit.

begin;

-- ── PRE-CHECK 1 — the loan(s) and the customer's posted-till ──────────────────
-- Expect the loan to be 'Active' with a non-zero outstanding, and
-- Interest_Posted_Upto to be BEFORE 2026-08-31 (that gap is why Aug was skipped).
select l."Loan_No", l."Loan_Status", l."Outstand_Amount", l."Interest_Type",
       l."Interest_Per_Month_Per_Lakh", l."Interest_Per_day_Per_Lakh",
       l."Loan_Given_Date", c."Interest_Posted_Upto",
       c."Customer_Name", c."Finance_Name", l."Referred_Partner"
from "Loan_Processing" l
join "STL_CRM" c on c."Customer_STL_NO" = l."Customer_STL_NO"
where l."Customer_STL_NO" = 'Chi-STL2';

-- ── PRE-CHECK 2 — any August interest already posted (must be EMPTY) ──────────
-- If this returns a row, Aug is already billed — STOP and rollback; do not insert.
select "ID", "Month", "From_Date", "To_Date", "Interest_Amount", "Status"
from "Interest_Details"
where "Customer_STL_NO" = 'Chi-STL2' and "Month" = '08-2026';

-- ── INSERT — the consolidated August row (only if none exists) ────────────────
with agg as (
  select
    c."Finance_Name"                as fin,
    c."Customer_Name"               as cname,
    max(l."Referred_Partner")       as partner,
    count(*)                        as loan_cnt,
    max(l."Loan_No")                as any_loan,
    max(l."Interest_Type")          as itype,
    sum(coalesce(l."Outstand_Amount", 0)) as out_sum,
    round(sum(
      case
        when lower(coalesce(l."Interest_Type", 'Per_Month')) = 'per_day'
          then coalesce(l."Outstand_Amount", 0) * coalesce(l."Interest_Per_day_Per_Lakh", 0) / 100000.0 * 31
        else coalesce(l."Outstand_Amount", 0) * coalesce(l."Interest_Per_Month_Per_Lakh", 0) / 100000.0
      end
    ) / 10.0) * 10                  as interest_amt
  from "Loan_Processing" l
  join "STL_CRM" c on c."Customer_STL_NO" = l."Customer_STL_NO"
  where l."Customer_STL_NO" = 'Chi-STL2'
    and lower(coalesce(l."Loan_Status", '')) = 'active'
    and coalesce(l."Outstand_Amount", 0) > 0
  group by c."Finance_Name", c."Customer_Name"
)
insert into "Interest_Details"
  ("ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Customer_Name",
   "From_Date", "To_Date", "No_Days", "Interest_Amount", "Loan_Amount",
   "Month", "Description", "Amount_Received", "Status", "Interest_Pending",
   "Referred_Partner", "Interest_Type")
select
  'Chi-STL2-08-2026', fin,
  case when loan_cnt = 1 then any_loan else '' end,
  'Chi-STL2', cname,
  '2026-08-01', '2026-08-31', 31, interest_amt, out_sum,
  '08-2026', 'Aug-2026 interest', 0, 'Pending', interest_amt,
  partner, itype
from agg
where interest_amt > 0
  and not exists (
    select 1 from "Interest_Details"
    where "Customer_STL_NO" = 'Chi-STL2' and "Month" = '08-2026'
  );

-- ── Advance the customer's posted-till (only forward, never backward) ─────────
update "STL_CRM"
set "Interest_Posted_Upto" = '2026-08-31'
where "Customer_STL_NO" = 'Chi-STL2'
  and coalesce("Interest_Posted_Upto", '') < '2026-08-31';

-- ── VERIFY — one row, Interest_Amount = Interest_Pending, Status Pending ──────
select "ID", "Finance_Name", "Loan_No", "Customer_STL_NO", "Interest_Amount",
       "Loan_Amount", "From_Date", "To_Date", "No_Days", "Month", "Status",
       "Interest_Pending"
from "Interest_Details"
where "Customer_STL_NO" = 'Chi-STL2' and "Month" = '08-2026';

-- Amount correct & exactly one row? ->  commit;
-- Already posted, wrong amount, or unsure? ->  rollback;
commit;

-- ── OPTIONAL (only if you want the Posting-register TOTALS to include it) ─────
-- The breakdown popup reads Interest_Details directly, so Chi-STL2 will already
-- show there once the row above is committed. The register's "Customer" cell
-- total/count is a stored snapshot and won't auto-update. To bump it, replace
-- <SCOPE> with the Finance_Name on that register row ('Chit_Malar' if you posted
-- that finance alone, or 'ALL' if you posted All finances), and run:
--
-- update "Interest_Posting_Log"
-- set "Customer_Amount" = coalesce("Customer_Amount",0) + (
--       select coalesce("Interest_Amount",0) from "Interest_Details"
--       where "Customer_STL_NO"='Chi-STL2' and "Month"='08-2026' limit 1),
--     "Customer_Lines"  = coalesce("Customer_Lines",0) + 1
-- where "Finance_Name" = '<SCOPE>' and "Month" = '2026-08';
