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

ActiveRecord::Schema.define(version: 20160813150332) do

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

  create_table "properties", force: :cascade do |t|
    t.string   "mls_id"
    t.string   "for"
    t.string   "address"
    t.string   "street_name"
    t.string   "street_number"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "listing_status"
    t.string   "municipality"
    t.string   "home_type"
    t.string   "home_style"
    t.string   "apt_unit"
    t.integer  "bedrooms"
    t.integer  "washrooms"
    t.integer  "kitchens"
    t.integer  "sqft_from"
    t.integer  "sqft_to"
    t.string   "basement"
    t.string   "fronting_on"
    t.integer  "family_rooms"
    t.string   "heat_type"
    t.string   "air_conditioner"
    t.string   "exterior"
    t.string   "drive"
    t.string   "garage"
    t.integer  "parking_spaces"
    t.string   "water"
    t.string   "sewer"
    t.string   "lot"
    t.float    "lot_length"
    t.float    "lot_width"
    t.integer  "rooms"
    t.string   "pool"
    t.string   "cross_streets"
    t.string   "last_status"
    t.integer  "list_price"
    t.integer  "leased_price"
    t.integer  "sale_price"
    t.datetime "leased_date"
    t.datetime "sold_date"
    t.string   "postal"
    t.string   "listing_type"
    t.integer  "dom"
    t.integer  "taxes"
    t.text     "client_remarks"
    t.jsonb    "images_links"
    t.datetime "print_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "extras"
    t.string   "apx_age"
    t.string   "apx_sqft"
    t.jsonb    "parsed_data"
    t.integer  "basement_bedrooms"
    t.integer  "basement_washrooms"
    t.integer  "basement_kitchens"
    t.integer  "total_rooms"
    t.integer  "basement_rooms"
    t.float    "expected_return_rate"
    t.datetime "exported_at"
  end

  create_table "realtor_entries", force: :cascade do |t|
    t.jsonb    "data"
    t.string   "mls_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "exported_at"
  end

  create_table "rent_listings", force: :cascade do |t|
    t.string   "mls_id",               null: false
    t.integer  "status"
    t.datetime "list_date"
    t.datetime "rent_date"
    t.datetime "last_fetched_status"
    t.integer  "days_on_market"
    t.float    "expected_return_rate"
    t.integer  "asking_price"
    t.integer  "closing_price"
    t.integer  "taxes"
    t.string   "address"
    t.string   "postal"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "home_type"
    t.integer  "home_style"
    t.integer  "rooms_total"
    t.integer  "family_rooms"
    t.integer  "bedrooms"
    t.integer  "washrooms"
    t.integer  "kitchens"
    t.integer  "basement_type"
    t.integer  "basement_rooms"
    t.integer  "basement_bedrooms"
    t.integer  "basement_washrooms"
    t.integer  "basement_kitchens"
    t.string   "heat_type"
    t.string   "air_conditioner"
    t.float    "sqft_from"
    t.float    "sqft_to"
    t.integer  "num_of_stories"
    t.integer  "parking_spaces"
    t.string   "garage"
    t.float    "lot_length"
    t.float    "lot_width"
    t.string   "apx_age"
    t.string   "ammenities"
    t.string   "pool"
    t.string   "water"
    t.string   "sewer"
    t.string   "exterior"
    t.string   "ammenities_near_by"
    t.string   "cross_streets"
    t.text     "remarks"
    t.text     "extras"
    t.jsonb    "raw_data"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "sale_listings", force: :cascade do |t|
    t.string   "mls_id",               null: false
    t.integer  "status"
    t.datetime "list_date"
    t.datetime "sold_date"
    t.datetime "last_fetched_status"
    t.integer  "days_on_market"
    t.float    "expected_return_rate"
    t.integer  "asking_price"
    t.integer  "closing_price"
    t.integer  "taxes"
    t.string   "address"
    t.string   "postal"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "home_type"
    t.integer  "home_style"
    t.integer  "rooms_total"
    t.integer  "family_rooms"
    t.integer  "bedrooms"
    t.integer  "washrooms"
    t.integer  "kitchens"
    t.integer  "basement_type"
    t.integer  "basement_rooms"
    t.integer  "basement_bedrooms"
    t.integer  "basement_washrooms"
    t.integer  "basement_kitchens"
    t.string   "heat_type"
    t.string   "air_conditioner"
    t.float    "sqft_from"
    t.float    "sqft_to"
    t.integer  "num_of_stories"
    t.integer  "parking_spaces"
    t.string   "garage"
    t.float    "lot_length"
    t.float    "lot_width"
    t.string   "apx_age"
    t.string   "ammenities"
    t.string   "pool"
    t.string   "water"
    t.string   "sewer"
    t.string   "exterior"
    t.string   "ammenities_near_by"
    t.string   "cross_streets"
    t.text     "remarks"
    t.text     "extras"
    t.jsonb    "raw_data"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
