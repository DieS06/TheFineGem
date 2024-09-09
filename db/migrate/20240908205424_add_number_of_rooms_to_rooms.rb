class AddNumberOfRoomsToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :number_of_rooms, :integer
  end
end
