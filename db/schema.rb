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

ActiveRecord::Schema.define(version: 20160630010733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string   "mls_id"
    t.string   "address"
    t.string   "street_name"
    t.string   "street_number"
    t.string   "listing_status"
    t.string   "municipality"
    t.string   "apt_unit"
    t.integer  "beds"
    t.integer  "wr"
    t.string   "lsc"
    t.integer  "list_price"
    t.integer  "sale_price"
    t.string   "postal"
    t.string   "listing_type"
    t.integer  "dom"
    t.integer  "taxes"
    t.text     "client_remarks"
    t.text     "raw_data"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "listings", force: :cascade do |t|
    t.text     "raw_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.text     "html"
    t.string   "url"
    t.boolean  "exported",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
