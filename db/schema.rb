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

ActiveRecord::Schema.define(version: 20170507211356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.text    "name",        null: false
    t.integer "zip_code_id"
  end

  create_table "station_statuses", force: :cascade do |t|
    t.integer  "station_id",      null: false
    t.integer  "bikes_available", null: false
    t.integer  "docks_available", null: false
    t.datetime "time",            null: false
  end

  create_table "stations", force: :cascade do |t|
    t.text    "name",              null: false
    t.float   "latitude",          null: false
    t.float   "longitude",         null: false
    t.integer "dock_count",        null: false
    t.date    "installation_date", null: false
    t.integer "city_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "duration",         null: false
    t.datetime "start_date",       null: false
    t.datetime "end_date",         null: false
    t.integer  "start_station_id", null: false
    t.integer  "end_station_id",   null: false
    t.integer  "bike_id",          null: false
    t.integer  "zip_code_id"
    t.integer  "subscription_id"
  end

  create_table "weathers", force: :cascade do |t|
    t.date    "date",            null: false
    t.float   "max_temp",        null: false
    t.float   "mean_temp",       null: false
    t.float   "min_temp",        null: false
    t.float   "mean_humidity",   null: false
    t.float   "mean_visibility", null: false
    t.float   "mean_wind_speed", null: false
    t.float   "precipitation",   null: false
    t.integer "city_id"
  end

  create_table "zip_codes", force: :cascade do |t|
    t.integer "zip_code", null: false
  end

end
