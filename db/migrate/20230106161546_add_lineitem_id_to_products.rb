class AddLineitemIdToProducts < ActiveRecord::Migration[7.0]
	def change
		add_reference :products, :product_lineitem, null: false, foreign_key: true
	end
end
