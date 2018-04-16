# here is the requests tablesheet migration
require 'pg'
require 'active_record'
require 'pry'

PASSPORT = YAML.load(File.read('../passport.yml'))
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base::establish_connection(
  adapter: 'postgresql',
  host: '',
  user: PASSPORT['user'],
  database: PASSPORT['database']
)

class CreateRequests < ActiveRecord::Migration[5.0]
  def up
    create_table :requests do |t|
      # owner of the request
      t.references :user, foreign_key: true, index: true
      # text of the request
      t.string :query
      # repository address
      t.string :repository
      # is active
      t.boolean :active
      # when we had do it
      t.timestamps
    end
  end

  def down
    drop_table :requests
  end
end

create = CreateRequests.new

binding.pry
