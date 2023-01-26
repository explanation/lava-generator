import ProductModel from "./ProductModel"


export default interface LineitemModel {
  id: number
  created_at: Date
  updated_at: Date
  product: ProductModel
}
