class CreateReserveRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :reserve_rooms do |t|
      t.datetime :startDate
      t.datetime :endDate
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
