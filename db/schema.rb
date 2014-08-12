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

ActiveRecord::Schema.define(version: 20140810115946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broadcast_messages", force: true do |t|
    t.text     "message"
    t.integer  "alert_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "products_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "available_at"
    t.boolean  "is_promoted",        default: false
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "employee"
    t.string   "price"
    t.integer  "category_id"
    t.integer  "reservations_count", default: 0
    t.integer  "reservation_slots",  default: 1
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "reservations", force: true do |t|
    t.datetime "starts_at"
    t.integer  "user_id"
    t.integer  "product_id"
    t.boolean  "is_canceled", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["product_id"], name: "index_reservations_on_product_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "admin"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
