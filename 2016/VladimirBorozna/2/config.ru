require "bundler"
Bundler.require(:default)
require_all "lib"
require "./config/application"

run Bot::Base.new
