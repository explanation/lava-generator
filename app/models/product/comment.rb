class Product::Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
end
