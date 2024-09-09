class RemoveAddressFromHotels < ActiveRecord::Migration[7.2]
  def change
    remove_reference :hotels, :address, null: false, foreign_key: true

    add_reference :addresses, :hotel, foreign_key: true
  end
end
