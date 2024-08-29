class CreateRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :name,          null: false, default: ""
      t.boolean :status,       null: false, default: true

      t.timestamps

      ## Rememberable
      t.datetime :remember_created_at
    end
  end
end
