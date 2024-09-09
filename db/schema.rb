ActiveRecord::Schema[7.2].define(version: 2024_09_08_223436) do
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.string "place_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hotel_id"
    t.index ["hotel_id"], name: "index_addresses_on_hotel_id"
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
    t.integer "rooms_ids", default: [], array: true
    t.decimal "rating", precision: 10, scale: 2
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
    t.integer "room_type"
    t.string "code"
    t.boolean "status"
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "beds"
    t.integer "capacity"
    t.decimal "price_per_night", precision: 10, scale: 2
    t.integer "reserve_ids", default: [], array: true
    t.integer "number_of_rooms"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "hotels"
  add_foreign_key "comments", "rooms"
  add_foreign_key "comments", "users"
  add_foreign_key "hotels", "users"
  add_foreign_key "payments", "reserve_rooms", column: "reserve_id"
  add_foreign_key "payments", "users"
  add_foreign_key "reserve_rooms", "rooms"
  add_foreign_key "reserve_rooms", "users"
  add_foreign_key "rooms", "hotels"
end
