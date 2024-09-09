class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.string :payment_method, null: false
      t.string :status, null: false
      t.datetime :payment_date, null: false
      t.integer :user_id, null: false
      t.integer :reserve_id, null: false
      t.string :transaction_id

      t.timestamps
    end

    add_foreign_key :payments, :users
    add_foreign_key :payments, :reserve_rooms, column: :reserve_id
  end
end
