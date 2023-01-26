import ProductModel from "./ProductModel"


export default interface CommentModel {
  id: number
  body: string
  author: string
  created_at: Date
  updated_at: Date
  product_id: number
  product: ProductModel
}
