class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.integer :type
      t.string :code
      t.string :price_range
      t.boolean :status
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
