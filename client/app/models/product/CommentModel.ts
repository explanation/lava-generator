import ProductModel from "./ProductModel"
import PostModel from "../PostModel"


export default interface CommentModel {
	 id: number
	 body: string
	 author: string
	 created_at: Date
	 updated_at: Date
	 product_id: number
	 commentable: ProductModel | PostModel
}
