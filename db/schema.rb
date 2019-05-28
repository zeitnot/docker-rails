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

ActiveRecord::Schema.define(version: 2019_05_28_120318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "poll_options", force: :cascade do |t|
    t.bigint "poll_id"
    t.string "name"
    t.index ["poll_id"], name: "index_poll_options_on_poll_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expires_at"
  end

  create_table "votes", id: false, force: :cascade do |t|
    t.bigint "poll_id"
    t.bigint "poll_option_id"
    t.inet "ip"
    t.datetime "created_at"
    t.index ["poll_id"], name: "index_votes_on_poll_id"
    t.index ["poll_option_id"], name: "index_votes_on_poll_option_id"
  end

  add_foreign_key "poll_options", "polls", on_delete: :cascade
  add_foreign_key "votes", "poll_options", on_delete: :cascade
  add_foreign_key "votes", "polls", on_delete: :cascade
end
