class Product::Lineitem < ApplicationRecord
  has_one :product
end
