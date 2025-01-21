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

ActiveRecord::Schema[7.0].define(version: 2025_01_21_000006) do
  create_table "admin_sessions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "administrator_id", null: false
    t.string "session_token", null: false
    t.timestamp "expires_at", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_admin_sessions_on_administrator_id"
    t.index ["session_token"], name: "index_admin_sessions_on_session_token", unique: true
  end

  create_table "administrators", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "gift_codes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "administrator_id"
    t.string "unique_url", limit: 32, null: false
    t.integer "status", default: 0, null: false
    t.string "creation_request_id", limit: 40, null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "currency_code", limit: 3, null: false
    t.string "gc_id", null: false
    t.datetime "claimed_at"
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_gift_codes_on_administrator_id"
    t.index ["creation_request_id"], name: "index_gift_codes_on_creation_request_id", unique: true
    t.index ["unique_url"], name: "index_gift_codes_on_unique_url", unique: true
    t.index ["user_id"], name: "index_gift_codes_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "admin_sessions", "administrators"
  add_foreign_key "gift_codes", "users"
  add_foreign_key "gift_codes", "users", column: "administrator_id"
end
