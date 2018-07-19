class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
    	t.belongs_to :user, index: true
    	t.string :title
    	t.string :description
    	t.string :country
    	t.string :num_of_guest
    	t.string :num_of_bedroom
    	t.string :num_of_bath
    	t.string :price
    	t.string :amenities, array: true, default: []

      	t.timestamps
    end
  end
end
