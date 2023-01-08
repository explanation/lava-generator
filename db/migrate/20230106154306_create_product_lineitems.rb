class CreateProductLineitems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_lineitems do |t|

      t.timestamps
    end
  end
end
