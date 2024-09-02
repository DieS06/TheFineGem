class CreateCatalogs < ActiveRecord::Migration[7.2]
  def change
    create_table :catalogs do |t|
      t.references :hotel, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
