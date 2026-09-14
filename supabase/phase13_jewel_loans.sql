-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 13 — Jewel Loans (gold pledged to borrow) + photos.
--
-- Mirrors jewel.xlsx: a register of loans the firm/owner TOOK by mortgaging
-- gold ornaments — from whom, by whom, grams, item particulars — plus several
-- photos of the pledged jewels.
--
-- Two tables:
--   • "Jewel_Loan"        — the light register row (pulled at app startup).
--   • "Jewel_Loan_Photo"  — one row per photo (compressed image data URL). This
--                            is intentionally NOT loaded at startup; the app
--                            fetches a single loan's photos when it is opened,
--                            so the heavy image data never slows the main load.
--
-- The old "Jewel_Loan" stub was just ("id" text); this replaces it. It is empty
-- in production, so dropping it loses nothing.
--
-- ⚠️  Like phase3, these policies let the public (anon) key read & write. Fine
-- while you build; lock down with real auth before outside customers use it.
-- Run this once in Supabase → SQL Editor.
-- ─────────────────────────────────────────────────────────────────────────────

drop table if exists "Jewel_Loan" cascade;
create table "Jewel_Loan" (
  "Finance_Name" text,
  "Loan_No" text,
  "Loan_Taken_From" text,
  "Loan_Taken_By" text,
  "Loan_Taken_Date" text,
  "Loan_Amount" numeric,
  "Interest_Rate" numeric,
  "Loan_Closed_Date" text,
  "Interest_Amount" numeric,
  "Loan_Total_grams" numeric,
  "Particular_Description" text,
  "Loan_Status" text,
  "Due_Date" text,
  "Remark1" text,
  "Photo_Count" numeric
);

drop table if exists "Jewel_Loan_Photo" cascade;
create table "Jewel_Loan_Photo" (
  "id" text,
  "Loan_No" text,
  "Finance_Name" text,
  "Data" text,          -- compressed image, stored as a data: URL (image/jpeg)
  "Caption" text,
  "Sort" numeric,
  "Created_Date" text
);

-- Fetching a loan's photos always filters by Loan_No — index it.
create index if not exists "idx_jewel_photo_loan" on "Jewel_Loan_Photo" ("Loan_No");

-- Read + write policies (anon), matching the rest of the app.
alter table "Jewel_Loan" enable row level security;
drop policy if exists "app_read" on "Jewel_Loan";
create policy "app_read" on "Jewel_Loan" for select using (true);
drop policy if exists "app_write" on "Jewel_Loan";
create policy "app_write" on "Jewel_Loan" for all using (true) with check (true);

alter table "Jewel_Loan_Photo" enable row level security;
drop policy if exists "app_read" on "Jewel_Loan_Photo";
create policy "app_read" on "Jewel_Loan_Photo" for select using (true);
drop policy if exists "app_write" on "Jewel_Loan_Photo";
create policy "app_write" on "Jewel_Loan_Photo" for all using (true) with check (true);
