ActiveRecord::Schema.define(version: 201_711_281_641_58) do
  create_table 'articles', force: :cascade,
               options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'name'
    t.text 'info'
    t.string 'contact'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
