-- Tamugula Supabase Seed Script
-- Run this in your Supabase SQL Editor

-- Create products table
CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price INTEGER NOT NULL,
  image_url TEXT,
  description TEXT,
  stock INTEGER DEFAULT 0,
  unit TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  total INTEGER NOT NULL,
  status TEXT DEFAULT 'pending',
  delivery_address TEXT,
  delivery_area TEXT,
  delivery_fee INTEGER,
  payment_method TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create order_items table
CREATE TABLE IF NOT EXISTS order_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id),
  quantity INTEGER NOT NULL,
  price INTEGER NOT NULL
);

-- Enable Row Level Security
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

-- Policies: Products are readable by everyone
CREATE POLICY "Products are viewable by everyone" ON products FOR SELECT USING (true);

-- Orders: Users can only see their own orders
CREATE POLICY "Users can view own orders" ON orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own orders" ON orders FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Order items: Users can only see their own order items
CREATE POLICY "Users can view own order items" ON order_items FOR SELECT USING (
  order_id IN (SELECT id FROM orders WHERE user_id = auth.uid())
);

-- Seed products (30 Malawi grocery items)
INSERT INTO products (name, category, price, image_url, description, stock, unit) VALUES
('Krush 100% Mango Juice 1L', 'Drinks & Beverages', 2500, 'https://images.unsplash.com/photo-1546173159-315724a31696?w=400', 'Refreshing 100% mango juice, no added sugar.', 50, '1L bottle'),
('Parmalat Fresh Milk 1L', 'Dairy & Eggs', 1800, 'https://images.unsplash.com/photo-1550583724-b269d5b37f48?w=400', 'Fresh pasteurized milk from Parmalat.', 40, '1L carton'),
('Tropical Power Yoghurt 500g', 'Dairy & Eggs', 1200, 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400', 'Creamy strawberry flavored yoghurt.', 35, '500g tub'),
('Maputo Cooking Oil 2L', 'Groceries & Pantry', 5500, 'https://images.unsplash.com/photo-1474979266404-e4c3d3fd629d?w=400', 'Pure vegetable cooking oil.', 30, '2L bottle'),
('Tip Top Rice 2kg', 'Groceries & Pantry', 3200, 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400', 'Premium long grain white rice.', 45, '2kg bag'),
('Nsima Flour (Maize Meal) 5kg', 'Groceries & Pantry', 4500, 'https://images.unsplash.com/photo-1512343879784-a960bfabb9a2?w=400', 'Fine maize meal for making nsima.', 50, '5kg bag'),
('Illovo Sugar 2kg', 'Groceries & Pantry', 2800, 'https://images.unsplash.com/photo-1536304929831-ee1ca9d44f06?w=400', 'Pure white granulated sugar.', 60, '2kg packet'),
('Table Salt 1kg', 'Groceries & Pantry', 600, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400', 'Fine table salt for cooking.', 100, '1kg packet'),
('Sunlight Washing Soap 500g', 'Household Essentials', 1500, 'https://images.unsplash.com/photo-1584302179602-e4c3d3fd629d?w=400', 'Effective washing soap for laundry.', 40, '500g bar'),
('Vaseline Body Lotion 400ml', 'Personal Care', 2200, 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc1?w=400', 'Deep moisture body lotion.', 30, '400ml bottle'),
('Clear Shampoo 400ml', 'Personal Care', 2000, 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=400', 'Anti-dandruff shampoo for men.', 25, '400ml bottle'),
('Fresh Bread Loaf', 'Bakery', 800, 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400', 'Soft and fresh white bread.', 20, '1 loaf'),
('Farm Fresh Eggs 30-pack', 'Dairy & Eggs', 3500, 'https://images.unsplash.com/photo-1484557985045-edf25e08da73?w=400', 'Free-range chicken eggs.', 30, '30 eggs'),
('Fresh Tomatoes 1kg', 'Fresh Produce', 1500, 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400', 'Locally grown fresh tomatoes.', 40, '1kg'),
('Red Onions 1kg', 'Fresh Produce', 1200, 'https://images.unsplash.com/photo-1508747703725-719777637f5a?w=400', 'Fresh red onions from local farms.', 50, '1kg'),
('Green Cabbage', 'Fresh Produce', 1000, 'https://images.unsplash.com/photo-1513542789411-b6a5d4f31646?w=400', 'Fresh green cabbage head.', 35, '1 head'),
('Irish Potatoes 5kg', 'Fresh Produce', 3000, 'https://images.unsplash.com/photo-1518977676601-a2d3fd5f87cb?w=400', 'Fresh Irish potatoes.', 45, '5kg bag'),
('Carrots 1kg', 'Fresh Produce', 1000, 'https://images.unsplash.com/photo-1445282768818-728615cc910a?w=400', 'Fresh crunchy carrots.', 40, '1kg'),
('Coca-Cola 500ml x 12', 'Drinks & Beverages', 3000, 'https://images.unsplash.com/photo-1567103472667-6898f3a79cf2?w=400', 'Pack of 12 Coca-Cola bottles.', 25, '12 pack'),
('Mineral Water 500ml x 6', 'Drinks & Beverages', 1800, 'https://images.unsplash.com/photo-1523362628745-0a75a797d56e?w=400', 'Pure mineral drinking water.', 50, '6 pack'),
('Jumbo Sausages 1kg', 'Meat & Fish', 4500, 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=400', 'Premium pork sausages.', 20, '1kg pack'),
('Chambo Fish 500g', 'Meat & Fish', 3500, 'https://images.unsplash.com/photo-1534422298222-326f5e5de981?w=400', 'Fresh Chambo fish from Lake Malawi.', 15, '500g'),
('Dettol Soap 100g x 4', 'Personal Care', 1800, 'https://images.unsplash.com/photo-1600857544205-0a75a797d56e?w=400', 'Antibacterial protection soap.', 40, '4 pack'),
('Toilet Paper 4-roll', 'Household Essentials', 1200, 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=400', 'Soft 3-ply toilet paper rolls.', 50, '4 rolls'),
('Jik Bleach 500ml', 'Household Essentials', 800, 'https://images.unsplash.com/photo-1563573392202-3f357d17e17e?w=400', 'Powerful cleaning bleach.', 35, '500ml bottle'),
('Blue Band Margarine 500g', 'Dairy & Eggs', 2000, 'https://images.unsplash.com/photo-1589923186741-b7d59d6bcdeb?w=400', 'Spreadable margarine for bread.', 30, '500g tub'),
('Soya Pieces 500g', 'Groceries & Pantry', 1500, 'https://images.unsplash.com/photo-1581861997502-170c8b2d0bdf?w=400', 'High protein soya chunks.', 25, '500g packet'),
('Green Pepper 500g', 'Fresh Produce', 800, 'https://images.unsplash.com/photo-1560512823-102c0907d860?w=400', 'Fresh green bell peppers.', 30, '500g'),
('Orange Fanta 500ml', 'Drinks & Beverages', 350, 'https://images.unsplash.com/photo-1629203851122-102c0907d860?w=400', 'Refreshing orange fizzy drink.', 60, '500ml bottle'),
('Tea Leaves 500g', 'Groceries & Pantry', 2500, 'https://images.unsplash.com/photo-1563565375-f3fdfdb8e6e3?w=400', 'Premium black tea leaves.', 40, '500g packet');
