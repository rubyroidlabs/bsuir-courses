ActiveRecord::Schema.define(version: 20171124000441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'adverts', force: :cascade do |t|
    t.string 'tittle'
    t.string 'description'
    t.string 'currency'
    t.integer 'count'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'courses', force: :cascade do |t|
    t.decimal 'coefficient', precision: 10, scale: 5
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'responses', force: :cascade do |t|
    t.string 'text'
    t.integer 'advert_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'phone'
    t.integer 'person_id'
    t.string 'person_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
