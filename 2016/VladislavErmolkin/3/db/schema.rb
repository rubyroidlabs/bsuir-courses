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

ActiveRecord::Schema.define(version: 20161120193811) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "phrases", force: :cascade do |t|
    t.string "body"
  end

  create_table "updates", force: :cascade do |t|
    t.datetime "update_time"
    t.string   "word"
    t.integer  "user_id"
    t.integer  "phrase_id"
    t.string   "prev_phrase"
    t.index ["phrase_id"], name: "index_updates_on_phrase_id", using: :btree
    t.index ["user_id"], name: "index_updates_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end
end
