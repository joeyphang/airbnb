class ChangeColumnToNewDataTypeFromListings < ActiveRecord::Migration[5.2]
	def change
		change_column :listings, :price, 'integer USING price::integer'
  	end
end
