class AddCoordsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :coords, :point, srid: 3785, index: true, spatial: true
  end
end
