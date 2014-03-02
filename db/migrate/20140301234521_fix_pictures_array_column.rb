class FixPicturesArrayColumn < ActiveRecord::Migration
  def change
    remove_column :listings, :pictures
    add_column :listings, :pictures, :string, array: true
  end
end
