require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'
require_relative 'battle'
require_relative 'parser'

battler = ENV['NAME']
word_to_count = ENV['CRITERIA']

battles = Parser.get_battles('https://genius.com/api/artists/117146/songs')
unless battler.nil?
  battles = Parser.get_battles_by_name(battler)
end
Parser.get_content(battles, word_to_count)
unless battler.nil?
  Parser.count_wins(battles, battler)
end
