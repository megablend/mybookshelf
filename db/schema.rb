# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150916064913) do

  create_table "local_govts", force: :cascade do |t|
    t.string  "name",     limit: 255, null: false
    t.integer "state_id", limit: 4
  end

  add_index "local_govts", ["state_id"], name: "index_local_govts_on_state_id", using: :btree

  create_table "merchants", force: :cascade do |t|
    t.string   "firstname",         limit: 32,              null: false
    t.string   "lastname",          limit: 32,              null: false
    t.string   "phone_number",      limit: 32,              null: false
    t.string   "email",             limit: 96,              null: false
    t.string   "address",           limit: 128,             null: false
    t.string   "city",              limit: 128,             null: false
    t.string   "landmark",          limit: 128,             null: false
    t.integer  "state_id",          limit: 4
    t.string   "password_digest",   limit: 255,             null: false
    t.string   "remember_digest",   limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "account_status",    limit: 1,   default: 1
    t.integer  "email_verified",    limit: 1,   default: 0
    t.string   "verification_code", limit: 12
  end

  add_index "merchants", ["email"], name: "index_merchants_on_email", unique: true, using: :btree
  add_index "merchants", ["state_id"], name: "index_merchants_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 64, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "store_types", force: :cascade do |t|
    t.string "name", limit: 64, null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name",          limit: 128,   null: false
    t.text     "description",   limit: 65535
    t.string   "url",           limit: 128,   null: false
    t.integer  "store_type_id", limit: 4
    t.integer  "merchant_id",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "stores", ["merchant_id"], name: "index_stores_on_merchant_id", using: :btree
  add_index "stores", ["store_type_id"], name: "index_stores_on_store_type_id", using: :btree

  add_foreign_key "local_govts", "states"
  add_foreign_key "merchants", "states"
  add_foreign_key "stores", "merchants"
  add_foreign_key "stores", "store_types"
end
