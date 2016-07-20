require 'bundler'
Bundler.require

ActiveRecord::Base.establish_conection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

require_all 'app'
