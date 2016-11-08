require "bundler"
Bundler.require(:default)
require_all "lib"
require "./config/application"

Ohm.flush
require "./seeds"

run Bot::Base.new
