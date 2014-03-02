class ChangePicturesToArray < ActiveRecord::Migration
  def change
    change_column :listings, :pictures, :string, array: true
  end
end
