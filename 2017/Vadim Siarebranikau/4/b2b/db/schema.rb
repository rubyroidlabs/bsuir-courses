ActiveRecord::Schema.define(version: 201_711_261_856_26) do
  enable_extension 'plpgsql'
  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.string 'text'
    t.string 'contact'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
