# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema
# definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more
# migrations you'll amass, the slower it'll run and the greater likelihood
# for issues).
#
# It's strongly recommended that you check this file into your version
# control system.

def create_table_adverts
  create_table 'adverts', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'content', null: false
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'trade'
    t.index %w[user_id created_at],
            name: 'index_adverts_on_user_id_and_created_at'
  end
end

def create_table_users
  create_table 'comments', force: :cascade do |t|
    t.string 'content', null: false
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'advert_id', null: false
    t.index ['advert_id'], name: 'index_comments_on_advert_id'
    t.index %w[user_id created_at],
            name: 'index_comments_on_user_id_and_created_at'
  end
end

def create_table_comments
  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest'
    t.string 'remember_token'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['remember_token'], name: 'index_users_on_remember_token'
  end
end

ActiveRecord::Schema.define(version: 20_171_128_024_029) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table_adverts
  create_table_users
  create_table_comments
end
