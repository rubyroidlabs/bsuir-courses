ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require :default, ENV['RACK_ENV'].to_sym
