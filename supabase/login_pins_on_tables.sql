-- Login PINs on each person's own row (so the PIN is visible in Supabase and read
-- from the respective table at login). Adds a "PIN" column to Finance_Details (MD),
-- Partner and Worker, defaulting to '1234', and sets every existing row to '1234'.
-- Run ONCE in Supabase (SQL Editor). Safe to re-run.

alter table "Finance_Details" add column if not exists "PIN" text default '1234';
update "Finance_Details" set "PIN" = '1234' where "PIN" is null or "PIN" = '';

alter table "Partner" add column if not exists "PIN" text default '1234';
update "Partner" set "PIN" = '1234' where "PIN" is null or "PIN" = '';

alter table "Worker" add column if not exists "PIN" text default '1234';
update "Worker" set "PIN" = '1234' where "PIN" is null or "PIN" = '';

-- The earlier per-phone credentials table is replaced by these per-row PINs.
drop table if exists "App_Credential";
