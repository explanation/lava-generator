import CommentModel from "./product/CommentModel"


export default interface PostModel {
	id: number
	title?: string
	body?: string
	published_at?: Date
	created_at: Date
	updated_at: Date
	comments: CommentModel[]
}
