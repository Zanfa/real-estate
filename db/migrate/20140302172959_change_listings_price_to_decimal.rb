class ChangeListingsPriceToDecimal < ActiveRecord::Migration
  def change
    change_column :listings, :price, 'decimal(10, 2) USING CAST(price AS decimal(10, 2))'
  end
end
