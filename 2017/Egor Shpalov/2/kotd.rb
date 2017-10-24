require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'rubocop'
require 'pry'
require_relative 'parse'
require_relative 'multithread'
require_relative 'output'

MAIN_LINK = 'https://genius.com/artists/King-of-the-dot'.freeze

a = Mechanize.new { |agent| agent.follow_meta_refresh = true }
a.get(MAIN_LINK) do |home_page|
  battles = Parse.main_parse(home_page)
  total = Multithread.multiparse(battles)
  total_results = total.first
  total_links = total.last
  Output.outprint(total_results, total_links)
end
