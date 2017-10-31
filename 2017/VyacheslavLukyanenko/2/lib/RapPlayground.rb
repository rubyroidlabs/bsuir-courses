require 'mechanize'
require 'json'
require_relative 'BattleParse'

class RapPlayground
  def initialize(name, criteria)
    @name = name
    @criteria = criteria
  end

  def load_battles
    new_battler = BattleParse.new(@name, @criteria)
    agent = Mechanize.new
    last_page = 1
    loop do
      req = 'https://genius.com/api/artists/117146/'
      if @name.nil?
        req += "songs?page=#{last_page}&sort=title"
      else
        req += "songs/search?page=#{last_page}&q=#{@name}&sort=title"
      end
      last_page = make_new_battle(agent.get(req).content, agent, new_battler)
      break unless last_page
    end
    if !@name.nil?
      new_battler.show_wins_count
    end
  end

  def make_new_battle(qq, agent, new_battler)
    qq = JSON.parse(qq)
    song_list = qq['response']['songs'].uniq
    song_list.each do |song|
      song_page = agent.get(song['url'])
      song_text = song_page.search('.lyrics p').text
      song_properties = {}
      song_properties[:uri] = song['url']
      song_properties[:title] = song['title']
      song_properties[:text] = song_text
      new_battler.parse_n_choose(song_properties)
    end
    qq['response']['next_page']
  end
end
