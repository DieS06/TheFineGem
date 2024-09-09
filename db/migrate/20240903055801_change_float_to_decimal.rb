class ChangeFloatToDecimal < ActiveRecord::Migration[7.2]
  def change
    change_column :rooms, :price_per_night, :decimal, using: 'price_per_night::decimal'
  end
end
