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

ActiveRecord::Schema.define(version: 20_161_120_171_551) do
  create_table 'phrases', force: :cascade do |t|
    t.integer 'user_id',      null: false
    t.string  'created_at',   null: false
    t.string  'value',        null: false
    t.integer 'last_changer', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string  'firstname',                     null: false
    t.string  'secondname',                    null: false
    t.boolean 'phrase_writed', default: false
  end

  create_table 'words', force: :cascade do |t|
    t.integer 'phrase_id', null: false
    t.integer 'user_id',   null: false
    t.string  'added_at',  null: false
    t.string  'value',     null: false
  end
end
