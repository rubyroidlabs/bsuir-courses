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

ActiveRecord::Schema.define(version: 20_161_115_025_012) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "phrases", primary_key: "phrase_id", force: :cascade do |t|
    t.integer  "words_count", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string "name"
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
  end

  create_table "words", primary_key: "word_id", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "phrase_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index %w(phrase_id word_id), name: "index_words_on_phrase_id_and_word_id", using: :btree
    t.index ["phrase_id"], name: "index_words_on_phrase_id", using: :btree
    t.index ["user_id"], name: "index_words_on_user_id", using: :btree
  end
end
