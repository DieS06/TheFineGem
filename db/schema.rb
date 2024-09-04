# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_04_161650) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.string "place_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.float "rate"
    t.boolean "status"
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_comments_on_room_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id"
    t.integer "rooms_ids", default: [], array: true
    t.decimal "rating", precision: 10, scale: 2
    t.index ["address_id"], name: "index_hotels_on_address_id"
    t.index ["user_id"], name: "index_hotels_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.string "payment_method", null: false
    t.string "status", null: false
    t.datetime "payment_date", null: false
    t.integer "user_id", null: false
    t.integer "reserve_id", null: false
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reserve_rooms", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "status"
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_price", precision: 10, scale: 2
    t.index ["room_id"], name: "index_reserve_rooms_on_room_id"
    t.index ["user_id"], name: "index_reserve_rooms_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "type"
    t.string "code"
    t.boolean "status"
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "beds"
    t.integer "capacity"
    t.decimal "price_per_night", precision: 10, scale: 2
    t.integer "reserve_ids", default: [], array: true
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "id_number"
    t.string "phone"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "rooms"
  add_foreign_key "comments", "users"
  add_foreign_key "hotels", "addresses"
  add_foreign_key "hotels", "users"
  add_foreign_key "payments", "reserve_rooms", column: "reserve_id"
  add_foreign_key "payments", "users"
  add_foreign_key "reserve_rooms", "rooms"
  add_foreign_key "reserve_rooms", "users"
  add_foreign_key "rooms", "hotels"
end
