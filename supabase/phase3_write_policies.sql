-- ─────────────────────────────────────────────────────────────────────────────
-- Phase 3 — make the app's writes persist to Supabase.
--
-- Until now only READ policies existed, so anything you add/edit in the app
-- (new finance, finance edit, loan closure, interest payment) lived only in the
-- browser and vanished on refresh. This script:
--   1. Creates the newer tables the app uses (Worker, Notification, Message, Log).
--   2. Grants insert / update / delete on EVERY table so writes stick.
--
-- ⚠️  These policies allow the public (anon) key to write. That's fine while you
-- build, but before real customers use it, lock this down with proper auth.
-- Run this once in Supabase → SQL Editor.
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists "Worker" (
  "Worker_ID" text, "Finance_Name" text, "Worker_Name" text, "Phone_Number" text,
  "Allowed_Menus" jsonb, "Status" text, "Created_By" text
);
create table if not exists "Notification" (
  "id" text, "Finance_Name" text, "To_Phone" text, "To_Party" text,
  "Title" text, "Body" text, "Date" text, "Read" boolean
);
create table if not exists "Message" (
  "id" text, "Date" text, "From_Phone" text, "From_Name" text, "Scope" text,
  "To_Phone" text, "To_Name" text, "Finance_Name" text, "Body" text
);
create table if not exists "Log" (
  "id" text, "Date" text, "User" text, "Action" text, "Entity" text,
  "Entity_Label" text, "Before" jsonb, "After" jsonb, "Restored" boolean
);

-- Enable RLS + a full read/write policy on every table in the public schema.
do $$
declare t text;
begin
  for t in select tablename from pg_tables where schemaname = 'public' loop
    execute format('alter table public.%I enable row level security', t);
    execute format('drop policy if exists "app_read" on public.%I', t);
    execute format('create policy "app_read" on public.%I for select using (true)', t);
    execute format('drop policy if exists "app_write" on public.%I', t);
    execute format('create policy "app_write" on public.%I for all using (true) with check (true)', t);
  end loop;
end $$;
