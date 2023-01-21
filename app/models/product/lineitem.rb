class Product::Lineitem < ApplicationRecord
  self.table_name = "product_lineitems"
  has_one :product
end
