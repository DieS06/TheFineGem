class ChangeStatusInReserveRoom < ActiveRecord::Migration[7.2]
  def up
    # Change status from boolean to integer
    change_column :reserve_rooms, :status, :integer, using: 'status::integer'

    # Add total_price column as a float
    add_column :reserve_rooms, :total_price, :float
  end

  def down
    # Revert status back to boolean
    change_column :reserve_rooms, :status, :boolean

    # Remove the total_price column
    remove_column :reserve_rooms, :total_price
  end
end
