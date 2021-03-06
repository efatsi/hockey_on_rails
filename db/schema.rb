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

ActiveRecord::Schema.define(version: 20170224202945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clock_data", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "period"
    t.string   "clock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "remote_id"
    t.string   "clock"
    t.string   "description"
    t.string   "event_type"
    t.datetime "updated"
    t.integer  "game_id"
    t.string   "period"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "wall_clock"
  end

  create_table "games", force: :cascade do |t|
    t.string   "description"
    t.string   "remote_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "watch",       default: false
    t.datetime "game_time"
  end

  create_table "manual_events", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "event_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ip_address"
  end

end
