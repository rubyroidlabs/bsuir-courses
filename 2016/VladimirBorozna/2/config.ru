require 'bundler'
Bundler.require(:default)
require './lib/bot'
require './config/application'

run Bot::Base.new
