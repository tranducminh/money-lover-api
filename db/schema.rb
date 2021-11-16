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

ActiveRecord::Schema.define(version: 2021_11_15_153559) do

  create_table "categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "main_type", default: 0, null: false
    t.string "icon", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "wallet_id"
    t.index ["wallet_id"], name: "index_categories_on_wallet_id"
  end

  create_table "transactions", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "amount", default: 0, null: false
    t.text "note"
    t.datetime "debt_exp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "wallet_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "user_wallets", charset: "utf8mb4", force: :cascade do |t|
    t.integer "user_role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "wallet_id"
    t.index ["user_id"], name: "index_user_wallets_on_user_id"
    t.index ["wallet_id"], name: "index_user_wallets_on_wallet_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "total", default: 0, null: false
    t.boolean "is_freezed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "categories", "wallets"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "wallets"
  add_foreign_key "user_wallets", "users"
  add_foreign_key "user_wallets", "wallets"
end
