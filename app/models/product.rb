class Product < ApplicationRecord
  belongs_to :lineitem
  has_many :comments

  attribute :track_id, :string
end
