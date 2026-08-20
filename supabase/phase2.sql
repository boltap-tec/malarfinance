-- ─────────────────────────────────────────────────────────────────────────────
-- Arul Finance — Phase 2 tables
-- Run this in the Supabase SQL editor AFTER migrate.sql. It adds the tables the
-- Phase 2 features use. Table + column names are quoted to match the app's
-- Dataset keys exactly (repository queries them as-is, e.g. from('Worker')).
-- These four are the only NEW tables; Other_Finance_Loan already exists.
-- ─────────────────────────────────────────────────────────────────────────────

-- Workers created by the MD, with the list of menus they may use.
create table if not exists "Worker" (
  "Worker_ID"     text primary key,
  "Finance_Name"  text,
  "Worker_Name"   text,
  "Phone_Number"  text,
  "Allowed_Menus" jsonb default '[]'::jsonb,  -- array of route paths, e.g. ["/loans","/ledger"]
  "Status"        text default 'Active',
  "Created_By"    text
);

-- Bell notifications (new loan → referred partner, new message → recipient, …).
create table if not exists "Notification" (
  "id"           text primary key,
  "Finance_Name" text,
  "To_Phone"     text,          -- recipient's phone (their login)
  "To_Party"     text,
  "Title"        text,
  "Body"         text,
  "Date"         timestamptz default now(),
  "Read"         boolean default false
);
create index if not exists notification_to_phone_idx on "Notification" ("To_Phone");

-- Group + direct messages between MD / partners / workers.
create table if not exists "Message" (
  "id"           text primary key,
  "Date"         timestamptz default now(),
  "From_Phone"   text,
  "From_Name"    text,
  "Scope"        text,          -- 'group' | 'direct'
  "To_Phone"     text,          -- set for direct messages
  "To_Name"      text,
  "Finance_Name" text,
  "Body"         text
);
create index if not exists message_scope_idx on "Message" ("Scope");
create index if not exists message_to_phone_idx on "Message" ("To_Phone");

-- Audit trail. Before/After keep the row snapshot so deletes/revokes can be undone.
create table if not exists "Log" (
  "id"           text primary key,
  "Date"         timestamptz default now(),
  "User"         text,
  "Action"       text,          -- create | update | delete | restore | revoke
  "Entity"       text,          -- dataset table key, e.g. 'Partner'
  "Entity_Label" text,
  "Before"       jsonb,
  "After"        jsonb,
  "Restored"     boolean default false
);
create index if not exists log_date_idx on "Log" ("Date" desc);

-- Optional: a place to persist per-app settings & credentials once you move auth
-- off localStorage (phone + password, default 1234, and the interest-config dates).
-- Left commented until we wire real writes; see the app notes for the plan.
-- create table if not exists "App_User" (
--   "Phone"        text primary key,
--   "Name"         text,
--   "Role"         text,         -- 'md' | 'partner' | 'worker'
--   "Finance_Name" text,
--   "Password"     text default '1234',
--   "Allowed_Menus" jsonb default '[]'::jsonb
-- );
