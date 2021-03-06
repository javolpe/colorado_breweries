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

ActiveRecord::Schema.define(version: 2021_06_16_195649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breweries", force: :cascade do |t|
    t.integer "db_id"
    t.string "obdb_id"
    t.string "name"
    t.string "brewery_type"
    t.string "street"
    t.string "address_2"
    t.string "address_3"
    t.string "city"
    t.string "state"
    t.string "county_province"
    t.string "postal_code"
    t.string "country"
    t.string "longitude"
    t.string "latitude"
    t.string "phone"
    t.string "website_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string "filter_name"
    t.string "filter_postal_code"
    t.string "filter_city"
    t.string "filter_brewery_type"
    t.string "sort_name"
    t.string "sort_postal_code"
    t.string "sort_city"
    t.string "sort_brewery_type"
    t.integer "counter", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
