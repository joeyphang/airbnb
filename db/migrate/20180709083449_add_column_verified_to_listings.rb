class AddColumnVerifiedToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :verified, :boolean, default: false
  end
end
