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

ActiveRecord::Schema[7.0].define(version: 2023_06_24_072522) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactions", force: :cascade do |t|
    t.string "note"
    t.float "amount", default: 0.0, null: false
    t.integer "transaction_type"
    t.integer "status"
    t.date "transaction_date", null: false
    t.bigint "wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.string "current_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.float "balance", default: 0.0, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "transactions", "wallets"
  add_foreign_key "wallets", "users"
end
