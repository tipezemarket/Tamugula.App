# Tamugula - Grocery Delivery for Mzuzu, Malawi

A full-stack e-commerce platform for online grocery delivery in Mzuzu, Malawi.

## Tech Stack
- Next.js 15 (App Router) + TypeScript
- Tailwind CSS + shadcn/ui
- Supabase (PostgreSQL, Auth, Storage)
- Zustand for state management
- Leaflet for maps
- Sonner for toast notifications

## Setup Instructions

### 1. Prerequisites
- Node.js 18+
- Supabase account

### 2. Environment Variables
Copy `.env.local.example` to `.env.local` and fill in your Supabase credentials:
```
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 3. Supabase Setup
1. Create a new Supabase project
2. Run the SQL in `supabase/seed.sql` in the Supabase SQL Editor
3. This creates the tables and seeds 30 Malawi grocery products

### 4. Install & Run
```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

## Features
- Homepage with hero, benefits, featured products, categories
- Shop page with search, category and price filters
- Product detail pages
- Shopping cart with persistent state (localStorage)
- Checkout flow: address, delivery time, payment method
- Order tracking with status steps
- User authentication (phone/email + OTP simulation)
- Admin dashboard for managing products
- Dark mode support
- PWA-ready with manifest
- Mobile-first, responsive design

## Project Structure
```
tamugula/
├── app/
│   ├── api/           # API routes
│   ├── admin/         # Admin dashboard
│   ├── shop/          # Products page
│   ├── product/[id]/  # Product detail
│   ├── cart/          # Cart page
│   ├── checkout/      # Checkout flow
│   ├── orders/        # Order history
│   └── auth/          # Authentication
├── components/        # UI components
├── store/            # Zustand stores
├── lib/              # Utilities & Supabase client
└── types/            # TypeScript types
```

## Deployment
Deploy to Vercel:
```bash
vercel --prod
```

## Notes
- Currently uses sample data (30 products in `lib/sample-data.ts`)
- Connect to Supabase for full backend functionality
- Payment methods are simulated (Airtel Money, TNM Mpamba, Cards)
- Delivery areas are hardcoded to Mzuzu locations
