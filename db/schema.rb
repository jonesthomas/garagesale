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

ActiveRecord::Schema.define(version: 20140115202900) do

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author"
  end

  create_table "listings", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "specific_location"
    t.string   "zip_code"
    t.decimal  "price",             precision: 8, scale: 2
    t.text     "details"
    t.boolean  "active",                                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listings", ["user_id", "created_at"], name: "index_listings_on_user_id_and_created_at"

  create_table "messages", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "author"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
