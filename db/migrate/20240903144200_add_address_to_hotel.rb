class AddAddressToHotel < ActiveRecord::Migration[7.2]
  def up
    add_reference :hotels, :address, foreign_key: true
    add_column :hotels, :rooms_ids, :integer, array: true, default: []
  end
  def down
    remove_column :hotels, :address, foreign_key: true
    remove_column :hotels, :rooms_ids
  end
end
