create table if not exists public.user_progress (
 user_id uuid primary key references auth.users(id) on delete cascade,
 payload jsonb not null default '{}'::jsonb,
 updated_at timestamptz not null default now()
);
alter table public.user_progress enable row level security;
create policy "progress_select_own" on public.user_progress for select to authenticated using ((select auth.uid())=user_id);
create policy "progress_insert_own" on public.user_progress for insert to authenticated with check ((select auth.uid())=user_id);
create policy "progress_update_own" on public.user_progress for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
