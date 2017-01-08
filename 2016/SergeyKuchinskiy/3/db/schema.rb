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

ActiveRecord::Schema.define(version: 20161117104022) do
  create_table "phrases", force: :cascade do |t|
    t.integer "word_id"
    t.integer "last_user"
    t.index ["word_id"], name: "index_phrases_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "words", force: :cascade do |t|
    t.string   "data"
    t.datetime "published_at"
    t.integer  "user_id"
    t.integer  "phrase_id"
    t.index ["phrase_id"], name: "index_words_on_phrase_id"
    t.index ["user_id"], name: "index_words_on_user_id"
  end
end
