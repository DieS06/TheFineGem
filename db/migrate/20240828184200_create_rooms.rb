class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :type,               null: false, default: ""
      t.string :code,               null: false, default: ""
      t.string :price_range,        null: false, default: ""
      t.integer :status,            null: false, default: 0
      t.references :hotel,          null: false, foreign_key: true
      t.json :reserve_room, default: []
      t.json :reserve_room, default: []
      t.timestamps
    end
  end
end
