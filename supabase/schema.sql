-- URBAN JULIET starter schema. Run in Supabase SQL Editor after reviewing.
create extension if not exists pgcrypto;
create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  description text not null default '',
  category text not null,
  price_kobo integer not null check (price_kobo >= 0),
  image_url text,
  is_active boolean not null default true,
  stock_quantity integer not null default 0 check (stock_quantity >= 0),
  created_at timestamptz not null default now()
);
create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  reference text unique not null,
  customer_name text not null,
  customer_email text not null,
  customer_phone text not null,
  shipping_address jsonb not null,
  subtotal_kobo integer not null check (subtotal_kobo >= 0),
  shipping_kobo integer not null default 0 check (shipping_kobo >= 0),
  total_kobo integer not null check (total_kobo >= 0),
  payment_status text not null default 'pending' check (payment_status in ('pending','paid','failed','refunded')),
  fulfillment_status text not null default 'unfulfilled' check (fulfillment_status in ('unfulfilled','processing','shipped','delivered','cancelled')),
  paystack_reference text unique,
  created_at timestamptz not null default now()
);
create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  product_name text not null,
  unit_price_kobo integer not null check (unit_price_kobo >= 0),
  quantity integer not null check (quantity > 0)
);
create table if not exists public.newsletter_subscribers (
  id uuid primary key default gen_random_uuid(),
  email text unique not null,
  created_at timestamptz not null default now()
);
-- Start with public access disabled. Add narrow RLS policies / Edge Functions only when the flows are ready.
alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.newsletter_subscribers enable row level security;
-- Products read policy is safe for active catalogue only; all order writes should go through trusted server functions.
 drop policy if exists "Public can view active products" on public.products;
create policy "Public can view active products" on public.products for select using (is_active = true);
-- Do NOT add public insert/select policies to orders or order_items.
