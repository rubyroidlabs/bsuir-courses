require_relative 'battle'
require 'mechanize'
# class for creating Battles from html pages
class BattleParser
  def initialize
    @agent = Mechanize.new
  end

  def parse(battle_info)
    raw_page = @agent.get(battle_info['url'])
    splitted_battle_title = battle_info['title'].split(/vs.|Vs.|VS.+/)
    first = { name: splitted_battle_title.first.strip, text: '' }
    second = { name: splitted_battle_title.last.strip, text: '' }
    battle_text = raw_page.parser.css('.song_body-lyrics').first.text
    rounds = battle_text.downcase.split(/\[?round+[\w\s]+\]?/)
    rounds[1..rounds.count].each_with_index do |round, index|
      index.odd? ? first[:text] += round : second[:text] += round
    end
    Battle.new(first: first, second: second)
  end
end
