-- Add status column to orders table
ALTER TABLE orders ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'pending';
ALTER TABLE orders ADD COLUMN IF NOT EXISTS rider_id UUID;
ALTER TABLE orders ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- Create storage bucket for product images (run this in Supabase Storage UI: create 'product-images' bucket as PUBLIC)
-- Then run these policies in SQL Editor:

-- Storage policies for product-images bucket
INSERT INTO storage.buckets (id, name, public) VALUES ('product-images', 'product-images', true)
ON CONFLICT (id) DO NOTHING;

-- Allow authenticated users to upload images
CREATE POLICY "Allow authenticated uploads" ON storage.objects
FOR INSERT TO authenticated WITH CHECK (bucket_id = 'product-images');

-- Allow public to read images
CREATE POLICY "Allow public read" ON storage.objects
FOR SELECT TO anon USING (bucket_id = 'product-images');

-- Update orders table RLS to allow admin to manage all orders
DROP POLICY IF EXISTS "Users can view own orders" ON orders;
CREATE POLICY "Users can view own orders" ON orders FOR SELECT USING (
  auth.uid() = user_id OR auth.role() = 'authenticated'
);

CREATE POLICY "Admin can update orders" ON orders
FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
