require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'
require_relative "battle"

class Parser

  def self.get_battles(agent, link, page_number)
    @battles = Array.new
    while page_number
      page = agent.get("https://genius.com/api/artists/117146/songs?page=#{page_number}")
      json_data  = JSON.parse(page.body)
      json_response = json_data["response"]["songs"]
      json_response.each do |battle|
        @battles << Battle.new(battle["title"], battle["url"])
      end
      page_number = json_data["response"]["next_page"]
    end
    @battles
  end

  def self.get_battles_by_name(battler)
    battles_list = Array.new
    @battles.each do |battle|
      if battle.first_battler == battler || battle.second_battler == battler
        battles_list << battle
      end
    end
    battles_list
  end

  def self.get_content(agent, battles, word_to_count)
    battles.each do |battle|
      text = Array.new
      content = agent.get(battle.link).search("p")
      content.children.each do |element|
        if element.class == Nokogiri::XML::Text || element.class == Nokogiri::XML::Element
          text << element.text
        end
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
    puts battler + ' wins ' + wins.to_s + ' times, loses ' + loses.to_s + ' times'
  end

end