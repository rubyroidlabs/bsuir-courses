ActiveRecord::Schema.define(version: 20_171_127_094_429) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  create_table 'ads', force: :cascade do |t|
    t.string 'title'
    t.text 'content'
    t.text 'contact_details'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
