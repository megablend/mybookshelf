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

ActiveRecord::Schema.define(version: 20160108115433) do

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id",      limit: 4
    t.integer  "position",       limit: 4
    t.integer  "level",          limit: 4
    t.integer  "children_count", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",           limit: 32,    null: false
    t.string   "image",          limit: 255
    t.text     "description",    limit: 65535
  end

  add_index "categories", ["name", "parent_id"], name: "index_categories_on_name_and_parent_id", unique: true, using: :btree

  create_table "categories_images", force: :cascade do |t|
    t.integer  "category_id", limit: 4
    t.string   "page_image",  limit: 255, null: false
    t.string   "menu_image",  limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "categories_images", ["category_id"], name: "index_categories_images_on_category_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "company_profiles", force: :cascade do |t|
    t.string "name",                limit: 100, null: false
    t.string "address",             limit: 128, null: false
    t.string "email",               limit: 96,  null: false
    t.string "telephone",           limit: 20,  null: false
    t.string "facebook_profile",    limit: 50
    t.string "twitter_profile",     limit: 50
    t.string "google_plus_profile", limit: 50
    t.string "youtube_profile",     limit: 50
    t.string "bbm_profile",         limit: 50
    t.string "domain_name",         limit: 50
  end

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
    t.string   "verification_code", limit: 50
  end

  add_index "merchants", ["email"], name: "index_merchants_on_email", unique: true, using: :btree
  add_index "merchants", ["state_id"], name: "index_merchants_on_state_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string  "isbn_number",      limit: 64
    t.string  "resource_id",      limit: 32
    t.integer "quantity",         limit: 4,                           default: 0
    t.integer "merchant_id",      limit: 4
    t.integer "products_type_id", limit: 4
    t.decimal "price",                       precision: 15, scale: 4, default: 0.0
    t.integer "points",           limit: 8,                           default: 0
    t.integer "status",           limit: 1,                           default: 0
    t.integer "approved",         limit: 1,                           default: 0
    t.integer "viewed",           limit: 8,                           default: 0
    t.integer "vat_option_id",    limit: 4
    t.decimal "special_price",               precision: 15, scale: 4, default: 0.0
    t.decimal "ebook_price",                 precision: 15, scale: 4, default: 0.0
  end

  add_index "products", ["merchant_id"], name: "index_products_on_merchant_id", using: :btree
  add_index "products", ["products_type_id"], name: "index_products_on_products_type_id", using: :btree
  add_index "products", ["vat_option_id"], name: "index_products_on_vat_option_id", using: :btree

  create_table "products_categories", id: false, force: :cascade do |t|
    t.integer "product_id",  limit: 4
    t.integer "category_id", limit: 4
  end

  add_index "products_categories", ["category_id"], name: "index_products_categories_on_category_id", using: :btree
  add_index "products_categories", ["product_id"], name: "index_products_categories_on_product_id", using: :btree

  create_table "products_descriptions", force: :cascade do |t|
    t.string  "title",            limit: 255,   null: false
    t.string  "author",           limit: 255,   null: false
    t.text    "description",      limit: 65535
    t.integer "product_id",       limit: 4
    t.string  "publisher",        limit: 255
    t.date    "publish_date"
    t.text    "tag",              limit: 65535
    t.string  "meta_title",       limit: 255,   null: false
    t.string  "meta_description", limit: 255,   null: false
    t.string  "meta_keyword",     limit: 255,   null: false
    t.string  "slug",             limit: 255,   null: false
  end

  add_index "products_descriptions", ["product_id"], name: "index_products_descriptions_on_product_id", using: :btree

  create_table "products_ebooks", force: :cascade do |t|
    t.string   "ebook",           limit: 255,             null: false
    t.integer  "product_id",      limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "ebook_protected", limit: 1,   default: 0
  end

  add_index "products_ebooks", ["product_id"], name: "index_products_ebooks_on_product_id", using: :btree

  create_table "products_images", force: :cascade do |t|
    t.integer "product_id", limit: 4
    t.string  "image",      limit: 255
  end

  add_index "products_images", ["product_id"], name: "index_products_images_on_product_id", using: :btree

  create_table "products_types", force: :cascade do |t|
    t.string   "product_type", limit: 128,             null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "status",       limit: 1,   default: 1
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 64, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "store_types", force: :cascade do |t|
    t.string "name", limit: 64, null: false
  end

  add_index "store_types", ["name"], name: "index_store_types_on_name", unique: true, using: :btree

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
  add_index "stores", ["url"], name: "index_stores_on_url", unique: true, using: :btree

  create_table "temporary_epub_uploads", force: :cascade do |t|
    t.string   "file_name",   limit: 255, null: false
    t.integer  "merchant_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "temporary_epub_uploads", ["merchant_id"], name: "index_temporary_epub_uploads_on_merchant_id", using: :btree

  create_table "temporary_products_descriptions", force: :cascade do |t|
    t.integer  "products_type_id",  limit: 4
    t.string   "title",             limit: 255,                                          null: false
    t.string   "isbn",              limit: 255
    t.integer  "vat_option_id",     limit: 4
    t.decimal  "price",                           precision: 15, scale: 4,               null: false
    t.decimal  "special_price",                   precision: 15, scale: 4
    t.text     "description",       limit: 65535,                                        null: false
    t.integer  "quantity",          limit: 4,                                            null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.integer  "merchant_id",       limit: 4
    t.integer  "product_protected", limit: 1,                              default: 0
    t.string   "author",            limit: 128
    t.string   "publisher",         limit: 128
    t.date     "publish_date"
    t.decimal  "ebook_price",                     precision: 15, scale: 4, default: 0.0
  end

  add_index "temporary_products_descriptions", ["merchant_id"], name: "index_temporary_products_descriptions_on_merchant_id", using: :btree
  add_index "temporary_products_descriptions", ["products_type_id"], name: "index_temporary_products_descriptions_on_products_type_id", using: :btree
  add_index "temporary_products_descriptions", ["vat_option_id"], name: "index_temporary_products_descriptions_on_vat_option_id", using: :btree

  create_table "temporary_uploads", force: :cascade do |t|
    t.string   "upload_type", limit: 32,  null: false
    t.string   "file_name",   limit: 255, null: false
    t.integer  "merchant_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "temporary_uploads", ["merchant_id"], name: "index_temporary_uploads_on_merchant_id", using: :btree

  create_table "vat_options", force: :cascade do |t|
    t.string   "name",       limit: 50, null: false
    t.integer  "status",     limit: 1,  null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_foreign_key "categories_images", "categories"
  add_foreign_key "local_govts", "states"
  add_foreign_key "merchants", "states"
  add_foreign_key "products", "merchants"
  add_foreign_key "products", "products_types"
  add_foreign_key "products", "vat_options"
  add_foreign_key "products_categories", "categories"
  add_foreign_key "products_categories", "products"
  add_foreign_key "products_descriptions", "products"
  add_foreign_key "products_ebooks", "products"
  add_foreign_key "products_images", "products"
  add_foreign_key "stores", "merchants"
  add_foreign_key "stores", "store_types"
  add_foreign_key "temporary_epub_uploads", "merchants"
  add_foreign_key "temporary_products_descriptions", "merchants"
  add_foreign_key "temporary_products_descriptions", "products_types"
  add_foreign_key "temporary_products_descriptions", "vat_options"
  add_foreign_key "temporary_uploads", "merchants"
end
