# here is the user tablesheet migration
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

# this table contain information about User
class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      # adress of the current_repo
      t.string :current_repo
      # last command
      t.string :last_command
    end
  end

  def down
    drop_table :users
  end
end

create = CreateUsers.new

binding.pry
