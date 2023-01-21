import Product from "./ProductModel"


export default interface Comment {
  id: number
  body: string
  author: string
  created_at: Date
  updated_at: Date
  product_id: number
  product: Product
}
