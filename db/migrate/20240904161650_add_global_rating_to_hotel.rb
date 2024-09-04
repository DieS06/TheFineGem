class AddGlobalRatingToHotel < ActiveRecord::Migration[7.2]
  def change
    add_column :hotels, :rating, :decimal, precision: 10, scale: 2
  end
end
