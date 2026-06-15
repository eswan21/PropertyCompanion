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

ActiveRecord::Schema[8.1].define(version: 2026_06_15_161458) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "properties", force: :cascade do |t|
    t.string "address"
    t.string "council_tax_band"
    t.datetime "created_at", null: false
    t.text "disadvantages"
    t.string "epc_rating"
    t.string "location"
    t.text "notes"
    t.boolean "open", default: true, null: false
    t.integer "personal_priority"
    t.string "postcode"
    t.integer "price_per_month"
    t.bigint "search_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["search_id"], name: "index_properties_on_search_id"
  end

  create_table "property_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "created_by_id", null: false
    t.string "event_type", null: false
    t.text "note"
    t.bigint "property_id", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_property_events_on_created_by_id"
    t.index ["property_id"], name: "index_property_events_on_property_id"
  end

  create_table "search_permissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "search_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["search_id", "user_id"], name: "index_search_permissions_on_search_id_and_user_id", unique: true
    t.index ["search_id"], name: "index_search_permissions_on_search_id"
    t.index ["user_id"], name: "index_search_permissions_on_user_id"
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "properties", "searches"
  add_foreign_key "property_events", "properties"
  add_foreign_key "property_events", "users", column: "created_by_id"
  add_foreign_key "search_permissions", "searches"
  add_foreign_key "search_permissions", "users"
  add_foreign_key "searches", "users"
end
