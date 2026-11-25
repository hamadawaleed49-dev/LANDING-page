-- الصق الملف ده كله في Supabase: SQL Editor ثم New query ثم Run
create table if not exists pages (
  slug text primary key,
  config jsonb not null,
  updated_at timestamptz default now()
);
create table if not exists orders (
  id bigint generated always as identity primary key,
  created_at timestamptz default now(),
  page text, product text, color text, size text, price numeric,
  name text, phone text, gov text, address text,
  status text default 'جديد', note text
);
alter table pages  enable row level security;
alter table orders enable row level security;

-- الزوار: يقرأوا إعدادات الصفحات ويبعتوا أوردرات بس
create policy "pages read"    on pages  for select using (true);
create policy "orders insert" on orders for insert to anon, authenticated with check (true);

-- أنت (بعد تسجيل الدخول): كل حاجة
create policy "pages admin"   on pages  for all    to authenticated using (true) with check (true);
create policy "orders read"   on orders for select to authenticated using (true);
create policy "orders update" on orders for update to authenticated using (true) with check (true);
create policy "orders delete" on orders for delete to authenticated using (true);
