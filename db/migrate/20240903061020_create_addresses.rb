class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city
      t.string :place_name

      t.timestamps
    end
  end
end
