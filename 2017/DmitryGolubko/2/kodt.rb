require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'
require_relative "battle"
require_relative "parser"

battler = ENV['NAME']
word_to_count = ENV['CRITERIA']

agent = Mechanize.new

battles = Parser.get_battles(agent, "https://genius.com/api/artists/117146/songs?page=1", 1)
unless battler.nil?
  battles = Parser.get_battles_by_name(battler)
end
Parser.get_content(agent, battles, word_to_count)

unless battler.nil?
  Parser.count_wins(battles, battler)
end