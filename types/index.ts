export interface Product {
  id: string
  name: string
  category: string
  price: number
  image_url: string
  description: string
  stock: number
  unit: string
  created_at?: string
}

export interface CartItem extends Product {
  quantity: number
}

export interface Order {
  id: string
  user_id: string
  total: number
  status: 'pending' | 'confirmed' | 'preparing' | 'out_for_delivery' | 'delivered'
  delivery_address: string
  delivery_area: string
  delivery_fee: number
  payment_method: string
  created_at: string
  items: OrderItem[]
}

export interface OrderItem {
  id: string
  order_id: string
  product_id: string
  quantity: number
  price: number
  product?: Product
}

export interface MzuzuArea {
  name: string
  deliveryFee: number
  lat: number
  lng: number
}

export const MZUZU_AREAS: MzuzuArea[] = [
  { name: 'City Centre', deliveryFee: 800, lat: -11.4525, lng: 34.0214 },
  { name: 'Luwinga', deliveryFee: 1000, lat: -11.4389, lng: 34.0125 },
  { name: 'Chibavi', deliveryFee: 1000, lat: -11.4667, lng: 34.0333 },
  { name: 'Masasa', deliveryFee: 1200, lat: -11.4750, lng: 34.0417 },
  { name: 'Zolozolo', deliveryFee: 1200, lat: -11.4250, lng: 34.0083 },
  { name: 'Katawa', deliveryFee: 1500, lat: -11.4833, lng: 34.0500 },
  { name: 'Nkhorongo', deliveryFee: 1500, lat: -11.4167, lng: 33.9917 },
  { name: 'Mchengautuwa', deliveryFee: 2000, lat: -11.4917, lng: 34.0583 },
]

export const CATEGORIES = [
  'Fresh Produce',
  'Groceries & Pantry',
  'Drinks & Beverages',
  'Household Essentials',
  'Personal Care',
  'Dairy & Eggs',
  'Bakery',
  'Meat & Fish',
]
