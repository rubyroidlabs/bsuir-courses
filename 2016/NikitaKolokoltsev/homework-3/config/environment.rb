require "bundler"
Bundler.require
configure :development do
  ActiveRecord::Base.establish_connection(
    adapter: "postgresql",
    database: "development_db"
  )
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgres:///localhost/mydb")
end

require_all "app"
