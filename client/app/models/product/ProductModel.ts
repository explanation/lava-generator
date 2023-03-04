import LineitemModel from "./LineitemModel"
import CommentModel from "./CommentModel"


export default interface ProductModel {
	id: number
	name: string
	price?: number
	stock?: number
	created_at: Date
	updated_at: Date
	product_lineitem_id: number
	track_id?: string
	lineitem: LineitemModel
	comments: CommentModel[]
}
