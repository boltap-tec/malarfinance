-- App login PINs — one PIN per PHONE number (shared across every role that phone
-- holds), stored centrally so it works on every device / the APK. Default '1234'
-- until the person changes it in-app. Run ONCE in Supabase (SQL Editor).
-- Safe to re-run: it never overwrites a PIN that already exists.

create table if not exists "App_Credential" (
  "Phone" text primary key,
  "PIN" text not null default '1234',
  "Updated_On" text
);

alter table "App_Credential" enable row level security;
drop policy if exists "app_read" on "App_Credential";
create policy "app_read" on "App_Credential" for select using (true);
drop policy if exists "app_write" on "App_Credential";
create policy "app_write" on "App_Credential" for all using (true) with check (true);

-- Seed a default 1234 PIN for every login phone (MDs, partners, workers). Each
-- distinct phone gets ONE row, so a phone that is both MD and partner shares it.
insert into "App_Credential" ("Phone", "PIN")
select distinct trim(phone) as phone, '1234'
from (
  select "Phone_Number"::text as phone from "Finance_Details" where "Phone_Number" is not null
  union
  select "Phone_Number"::text from "Partner" where "Phone_Number" is not null
  union
  select "Phone_Number"::text from "Worker" where "Phone_Number" is not null
) t
where trim(coalesce(phone, '')) <> ''
on conflict ("Phone") do nothing;
