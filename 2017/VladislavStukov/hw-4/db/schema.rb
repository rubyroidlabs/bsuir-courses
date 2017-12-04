ActiveRecord::Schema.define(version: 20_171_130_110_545) do
  enable_extension 'plpgsql'

  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.text 'text'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'contact_data'
    t.boolean 'sold_bonsticks'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'commenter'
    t.text 'body'
    t.integer 'article_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'contact_data'
    t.index ['article_id'], name: 'index_comments_on_article_id'
  end
end
