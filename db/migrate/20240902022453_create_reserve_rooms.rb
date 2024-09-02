class CreateReserveRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :reserve_rooms do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :status
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
