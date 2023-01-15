import Product from "../product/LineitemModel"
export default interface Lineitem {
  id: number
  created_at: Date
  updated_at: Date
  product: Product
}
