class ChangeDecimalsPrecision < ActiveRecord::Migration[7.2]
  def change
    change_column :reserve_rooms, :total_price, :decimal, precision: 10, scale: 2
    change_column :rooms, :price_per_night, :decimal, precision: 10, scale: 2
  end
end
