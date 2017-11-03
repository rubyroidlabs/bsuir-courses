require 'mechanize'
require 'json'
require_relative 'battle'
class BattleUtils
  def self.get_battle_by(name = nil)
    agent = Mechanize.new
    next_page = 1
    begin
      request = 'https://genius.com/api/artists/117146/'
      request += if name
                   "songs/search?page=#{next_page}&q=#{name}&sort=title"
                 else
                   "songs?page=#{next_page}&sort=title"
                 end
      respond = agent.get(request).content # download json and convert to string
      respond = JSON.parse(respond)
      battle_list = respond['response']['songs'].uniq
      battle_list.each do |battle_hash|
        battle_title = battle_hash['title'] # creating battle object for yield
        battle_url = battle_hash['url']
        battle_page = agent.get(battle_url)
        battle_text = battle_page.search('.lyrics p').text
        battle = Battle.new(battle_title, battle_url, battle_text)
        yield(battle)
      end
      next_page = respond['response']['next_page']
    end while next_page
  end
end
