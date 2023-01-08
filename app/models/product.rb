class Product < ApplicationRecord
  belongs_to :lineitem
  has_many :comments
end
