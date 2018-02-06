require_relative 'kodt'
require_relative 'parsegenius'
require 'mechanize'
name = ENV['NAME']
criteria = ENV['CRITERIA']
batl = ParseGenius.new(name, criteria)
batl.search_album
batl.show_finish_result
