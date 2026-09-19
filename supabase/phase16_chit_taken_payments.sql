-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 16 — Chit payout payment history (payments to chit-taken members).
--
-- Until now, paying a chit-taken member their payout only bumped a running total
-- on "Chit_Taken_Member" (Amount_Given_to_Member) and kept the last remark. This
-- adds one row per individual payout installment, so you can:
--   • see the full history of every payment made to a chit-taken member, and
--   • edit or delete a wrongly-entered payment (the running totals re-sync).
--
-- The running totals on Chit_Taken_Member stay the source of truth for "given /
-- pending"; this table is the itemised ledger behind them. Payouts made before
-- this table existed show up as a single "Earlier payouts" line in the app.
--
-- ⚠️  Like the earlier phases, these policies let the public (anon) key read &
-- write. Fine while you build; lock down with real auth before outside customers
-- use it. Run this once in Supabase → SQL Editor.
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists "Chit_Taken_Payment" (
  "Payment_ID" text primary key,
  "Chit_Taken_ID" text,       -- the taking (Chit_Taken_Member) this payout is against
  "Chit_ID" text,
  "Member_ID" text,
  "Member_Name" text,
  "Finance_Name" text,
  "Month_Count" numeric,
  "Date" text,                -- when the money was given
  "Amount" numeric,
  "Payment_Type" text,        -- Cash | UPI | Account | Other
  "Remarks" text
);

-- The app fetches a taking's payments by Chit_Taken_ID, and a fund's by Chit_ID.
create index if not exists "idx_chit_payment_taken" on "Chit_Taken_Payment" ("Chit_Taken_ID");
create index if not exists "idx_chit_payment_chit"  on "Chit_Taken_Payment" ("Chit_ID");

-- Read + write policies (anon), matching the rest of the app.
alter table "Chit_Taken_Payment" enable row level security;
drop policy if exists "app_read" on "Chit_Taken_Payment";
create policy "app_read" on "Chit_Taken_Payment" for select using (true);
drop policy if exists "app_write" on "Chit_Taken_Payment";
create policy "app_write" on "Chit_Taken_Payment" for all using (true) with check (true);
