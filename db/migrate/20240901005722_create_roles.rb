class CreateRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :role_label
      t.boolean :status

      t.timestamps
    end
  end
end
