-- HASHIMI MOBILES warranty and claims starter schema.
-- Apply in a NEW Supabase project only after reviewing this file.
create extension if not exists pgcrypto;

create type public.claim_status as enum (
  'registered', 'under_review', 'sent_to_brand',
  'in_progress', 'ready_for_pickup', 'completed', 'rejected'
);
create type public.warranty_status as enum ('pending_verification','active','expired','void');

create table public.customer_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  phone text,
  preferred_language text not null default 'ps' check (preferred_language in ('ps','fa','en')),
  created_at timestamptz not null default now()
);

create table public.staff_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  role text not null check (role in ('owner','manager','service_staff')),
  active boolean not null default true
);

create table public.products (
  id uuid primary key default gen_random_uuid(),
  brand text not null,
  model text not null,
  created_at timestamptz not null default now()
);

create table public.purchases (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid references public.customer_profiles(id),
  invoice_number text not null unique,
  purchase_date date not null,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

create table public.warranties (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id),
  purchase_id uuid references public.purchases(id),
  customer_id uuid references public.customer_profiles(id),
  imei1 text not null unique check (imei1 ~ '^[0-9]{15}$'),
  imei2 text unique check (imei2 is null or imei2 ~ '^[0-9]{15}$'),
  provider text not null,
  policy_reference text,
  coverage_summary text not null,
  exclusions_summary text,
  purchase_date date not null,
  start_date date not null,
  expiry_date date,
  status public.warranty_status not null default 'pending_verification',
  verified_by uuid references auth.users(id),
  verified_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.claims (
  id uuid primary key default gen_random_uuid(),
  claim_code text not null unique,
  warranty_id uuid not null references public.warranties(id),
  customer_id uuid references public.customer_profiles(id),
  issue_category text not null,
  description text not null,
  status public.claim_status not null default 'registered',
  decision_reason text,
  estimated_completion date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.claim_updates (
  id uuid primary key default gen_random_uuid(),
  claim_id uuid not null references public.claims(id) on delete cascade,
  status public.claim_status not null,
  public_note text not null,
  updated_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

create table public.claim_attachments (
  id uuid primary key default gen_random_uuid(),
  claim_id uuid not null references public.claims(id) on delete cascade,
  storage_path text not null,
  uploaded_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

create index warranties_customer_idx on public.warranties(customer_id);
create index warranties_imei_idx on public.warranties(imei1);
create index claims_customer_idx on public.claims(customer_id);
create index claims_status_idx on public.claims(status);
create index claim_updates_claim_idx on public.claim_updates(claim_id, created_at);

-- Enable RLS. Policies below are deliberately restrictive starter policies.
alter table public.customer_profiles enable row level security;
alter table public.staff_profiles enable row level security;
alter table public.products enable row level security;
alter table public.purchases enable row level security;
alter table public.warranties enable row level security;
alter table public.claims enable row level security;
alter table public.claim_updates enable row level security;
alter table public.claim_attachments enable row level security;

-- Customers can read/update only their own profile.
create policy "customer reads own profile" on public.customer_profiles
for select to authenticated using (id = auth.uid());
create policy "customer updates own profile" on public.customer_profiles
for update to authenticated using (id = auth.uid()) with check (id = auth.uid());

-- Authenticated users can read product catalogue.
create policy "authenticated read products" on public.products
for select to authenticated using (true);

-- Customers see only records attached to their account.
create policy "customer reads own purchases" on public.purchases
for select to authenticated using (customer_id = auth.uid());
create policy "customer reads own warranties" on public.warranties
for select to authenticated using (customer_id = auth.uid());
create policy "customer reads own claims" on public.claims
for select to authenticated using (customer_id = auth.uid());
create policy "customer reads own claim updates" on public.claim_updates
for select to authenticated using (
  exists (select 1 from public.claims c where c.id = claim_id and c.customer_id = auth.uid())
);

-- IMPORTANT:
-- Do not create public IMEI lookup or customer insert policies.
-- Add staff-only write/read policies using a SECURITY DEFINER helper that checks
-- staff_profiles.active and role. Review policies with a Supabase security expert
-- before production. Never expose the service_role key in the app.
