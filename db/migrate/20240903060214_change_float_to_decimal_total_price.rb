class ChangeFloatToDecimalTotalPrice < ActiveRecord::Migration[7.2]
  def change
    change_column :reserve_rooms, :total_price, :decimal, using: 'total_price::decimal'
  end
end
