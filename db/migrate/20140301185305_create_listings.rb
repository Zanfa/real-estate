class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.string :pictures
      t.string :price

      t.timestamps
    end
  end
end
