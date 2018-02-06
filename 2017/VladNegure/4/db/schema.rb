ActiveRecord::Schema.define(version: 20_171_127_154_908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.text 'text', null: false
    t.bigint 'post_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_comments_on_post_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title', null: false
    t.integer 'bonsticks', null: false
    t.decimal 'bitcoins', precision: 17, scale: 15, null: false
    t.text 'description', null: false
    t.text 'contacts', null: false
    t.text 'operation', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'comments', 'posts'
end
