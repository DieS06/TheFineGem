class CreateCatalogs < ActiveRecord::Migration[7.2]
  def change
    create_table :catalogs do |t|
      t.boolean :status
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
