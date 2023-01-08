export default interface Product {
  id: number
  name: string
  price?: number
  stock?: number
  created_at: Date
  updated_at: Date
  product_lineitem_id: number
  lineitem?: Lineitem
  comments: Comment[]
}