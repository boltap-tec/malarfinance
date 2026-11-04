-- One-off: correct Nagaraj Post's (New-STL301 · New Finance) October repayment
-- interest.
--
-- Cause: loan New-134 (₹3,00,000) was saved with Loan_Given_Date 2026-10-05 (its
-- entry date). Only its "Loan disbursed" ledger row (Ref 1587) was later moved to
-- 2026-09-29, so the loan itself kept 5 Oct and both repayments billed New-134
-- from 5 Oct:
--   • 5 Oct repay ₹1,00,000 (01–04 Oct): ₹250 → should be ₹280
--       (₹90,000 older loans + ₹10,000 of New-134, all @ ₹70/L/day × 4 days)
--   • 13 Oct repay ₹2,90,000: 05–12 Oct ₹1,620 → should be 01–12 Oct ₹2,440
--       (₹2,90,000 @ ₹70/L/day × 12 days = ₹2,436 → ₹2,440)
--
-- This script:
--   1) sets New-134's Loan_Given_Date to 2026-09-29 (matching its ledger row),
--   2) corrects the two repayment-interest rows,
--   3) refreshes the customer's Outstanding_Interest roll-up.
-- It does NOT add the 29–30 Sep interest on New-134 (₹420) — PRE-CHECK 3 shows
-- whether September's posting already covered it; send me that output first.
--
-- Run in the Supabase SQL Editor. Review the pre-checks + VERIFY, then `commit;`
-- (or `rollback;` if anything looks off).

begin;

-- ── PRE-CHECK 1 — the loans (expect New-134 Loan_Given_Date = 2026-10-05) ─────
-- Also check New-117's rate: it was created at 70000/L/day (typo for 70?).
select "Loan_No", "Loan_Given_Date", "Loan_Amount", "Repaid_Amount", "Outstand_Amount",
       "Interest_Type", "Interest_Per_day_Per_Lakh", "Loan_Status"
from "Loan_Processing"
where "Customer_STL_NO" = 'New-STL301' and "Finance_Name" = 'New Finance'
order by "Loan_Given_Date";

-- ── PRE-CHECK 2 — the two October repayment rows (expect ₹250 and ₹1,620, ────
-- both unpaid). If either shows Amount_Received > 0, rollback and tell me.
select "ID", "Loan_No", "From_Date", "To_Date", "Loan_Amount", "Interest_Amount",
       "Amount_Received", "Interest_Pending", "Status", "Description"
from "Interest_Details"
where "Customer_STL_NO" = 'New-STL301' and "Finance_Name" = 'New Finance'
  and "ID" like '%-repay-%' and "Month" = '10-2026'
order by "From_Date";

-- ── PRE-CHECK 3 — September posting: did it include New-134's 29–30 Sep? ─────
-- ₹90,000 × ₹70 × 30 days = ₹1,890 without New-134; ₹2,310 if it was included.
select "ID", "From_Date", "To_Date", "No_Days", "Loan_Amount", "Interest_Amount", "Status"
from "Interest_Details"
where "Customer_STL_NO" = 'New-STL301' and "Finance_Name" = 'New Finance'
  and "Month" = '09-2026';

-- ── FIX 1 — New-134's given date = its ledger date ─────────────────────────────
update "Loan_Processing"
set "Loan_Given_Date" = '2026-09-29'
where "Loan_No" = 'New-134' and "Finance_Name" = 'New Finance'
  and "Loan_Given_Date" = '2026-10-05';

-- ── FIX 2 — 5 Oct repayment interest, 01–04 Oct on ₹1,00,000: ₹250 → ₹280 ─────
update "Interest_Details"
set "Interest_Amount" = 280, "Interest_Pending" = 280
where "Customer_STL_NO" = 'New-STL301' and "Finance_Name" = 'New Finance'
  and "ID" like '%-repay-%'
  and "From_Date" = '2026-10-01' and "To_Date" = '2026-10-04'
  and "Interest_Amount" = 250 and coalesce("Amount_Received", 0) = 0;

-- ── FIX 3 — 13 Oct repayment interest on ₹2,90,000: 05–12 Oct ₹1,620 → ────────
-- 01–12 Oct ₹2,440.
update "Interest_Details"
set "From_Date" = '2026-10-01', "Interest_Amount" = 2440, "Interest_Pending" = 2440
where "Customer_STL_NO" = 'New-STL301' and "Finance_Name" = 'New Finance'
  and "ID" like '%-repay-%'
  and "From_Date" = '2026-10-05' and "To_Date" = '2026-10-12'
  and "Interest_Amount" = 1620 and coalesce("Amount_Received", 0) = 0;

-- ── FIX 4 — refresh the customer's roll-ups (as the app's recomputeCustomer) ──
update "STL_CRM" c
set "Outstanding_Interest" = coalesce((
      select sum(coalesce(i."Interest_Pending", 0)) from "Interest_Details" i
      where i."Customer_STL_NO" = c."Customer_STL_NO" and i."Finance_Name" = c."Finance_Name"), 0),
    "Total_Interest_Paid" = coalesce((
      select sum(coalesce(i."Amount_Received", 0)) from "Interest_Details" i
      where i."Customer_STL_NO" = c."Customer_STL_NO" and i."Finance_Name" = c."Finance_Name"), 0)
where c."Customer_STL_NO" = 'New-STL301' and c."Finance_Name" = 'New Finance';

-- ── VERIFY — expect New-134 given 2026-09-29, rows ₹280 + ₹2,440 pending, ─────
-- and Outstanding_Interest = ₹2,720 (if nothing else was pending).
select "Loan_No", "Loan_Given_Date" from "Loan_Processing"
where "Loan_No" = 'New-134' and "Finance_Name" = 'New Finance';

select "From_Date", "To_Date", "Interest_Amount", "Interest_Pending", "Status"
from "Interest_Details"
where "Customer_STL_NO" = 'New-STL301' and "Finance_Name" = 'New Finance'
  and "ID" like '%-repay-%' and "Month" = '10-2026'
order by "From_Date";

select "Outstanding_Interest", "Total_Interest_Paid" from "STL_CRM"
where "Customer_STL_NO" = 'New-STL301' and "Finance_Name" = 'New Finance';

-- If VERIFY looks right:  commit;
-- Otherwise:              rollback;
