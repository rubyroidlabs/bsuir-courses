require 'bundler'
Bundler.require(:default)
require './lib/bot'
require './config/application'
require './seeds'

run Bot::Base.new
