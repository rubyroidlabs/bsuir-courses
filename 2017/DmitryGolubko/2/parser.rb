require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'
require 'uri'
require_relative 'battle'

class Parser
  @agent = Mechanize.new
  def self.get_battles(link)
    page_number = 1
    @battles = Array.new
    @request = URI(link)
    while page_number
      @request.query = URI.encode_www_form(page: page_number)
      page = @agent.get(@request)
      json_data = JSON.parse(page.body)
      json_response = json_data['response']['songs']
      json_response.each do |battle|
        @battles << Battle.new(battle['title'], battle['url'])
      end
      page_number = json_data['response']['next_page']
    end
    @battles
  end

  def self.get_battles_by_name(battler)
    battles_list = Array.new
    @battles.each do |battle|
      if battle.battler?(battler)
        battles_list << battle
      end
    end
    battles_list
  end

  def self.get_content(battles, word_to_count)
    battles.each do |battle|
      text = Array.new
      content = @agent.get(battle.link).search('p')
      content.children.each do |element|
        text << element.text
      end
      battle.text = text
      battle.parse(word_to_count)
    end
  end

  def self.count_wins(battles, battler)
    wins = 0
    loses = 0
    battles.each do |battle|
      if battle.winner == battler
        wins += 1
      else
        loses += 1
      end
    end
    puts "#{battler} wins #{wins} times, loses #{loses} times"
  end
end
