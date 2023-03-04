class Product::Product < ApplicationRecord
	belongs_to :lineitem
	has_many :comments, as: :commentable

	attribute :track_id, :string
end
