# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_05_173656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "ci"
    t.string "name"
    t.bigint "ivatype_id", null: false
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ivatype_id"], name: "index_clients_on_ivatype_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "ivatypes", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "phones", force: :cascade do |t|
    t.string "number", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_phones_on_client_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "uniCode", null: false
    t.string "desc", limit: 20000, null: false
    t.string "detail", null: false
    t.decimal "basePrice", precision: 7, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reserveds", force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.bigint "item_id", null: false
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_reserveds_on_item_id"
    t.index ["reservation_id"], name: "index_reserveds_on_reservation_id"
  end

  create_table "sells", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.bigint "reservation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_sells_on_client_id"
    t.index ["reservation_id"], name: "index_sells_on_reservation_id"
    t.index ["user_id"], name: "index_sells_on_user_id"
  end

  create_table "solds", force: :cascade do |t|
    t.bigint "sell_id", null: false
    t.bigint "item_id", null: false
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_solds_on_item_id"
    t.index ["sell_id"], name: "index_solds_on_sell_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "passwd", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "clients", "ivatypes"
  add_foreign_key "items", "products"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "users"
  add_foreign_key "reserveds", "items"
  add_foreign_key "reserveds", "reservations"
  add_foreign_key "sells", "clients"
  add_foreign_key "sells", "reservations"
  add_foreign_key "sells", "users"
  add_foreign_key "solds", "items"
  add_foreign_key "solds", "sells"
end
