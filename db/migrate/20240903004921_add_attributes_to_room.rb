class AddAttributesToRoom < ActiveRecord::Migration[7.2]
  def up
    add_column :rooms, :beds, :integer
    add_column :rooms, :capacity, :integer
    add_column :rooms, :price_per_night, :float
    add_column :rooms, :reserve_ids, :integer, array: true, default: []
  end

  def down
    remove_column :rooms, :beds
    remove_column :rooms, :capacity
    remove_column :rooms, :price_per_night
    remove_column :rooms, :reserve_ids
  end
end
