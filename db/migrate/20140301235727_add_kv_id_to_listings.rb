class AddKvIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :kv_id, :string
  end
end
