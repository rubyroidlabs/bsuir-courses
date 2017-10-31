require_relative 'libs/song_urls_manager'
require_relative 'libs/master_of_ceremony'
require_relative 'libs/battle'
require 'mechanize'
require 'thread'

def print_every_battle(agent, url_manager, criteria)
  threads = []
  url_manager.songs.each do |song_url|
    threads << Thread.new do
      page = agent.get(song_url)
      battle = Battle.new(page, criteria)
      puts battle.results + "\n"
    end
  end
  threads.each(&:join)
end

def print_searched_battles(agent, url_manager, criteria, search_request)
  mc = MasterOfCeremony.new(search_request)
  threads = []
  url_manager.search_songs(search_request).each do |song_url|
    threads << Thread.new do
      page = agent.get(song_url)
      battle = Battle.new(page, criteria)
      mc.won? battle.winner
      puts battle.results + "\n"
    end
  end
  threads.each(&:join)
  puts "#{mc.name}: #{mc.winnings} winnings"
  puts "#{mc.name}: #{mc.losses} losses"
end

name = ENV['NAME']
criteria = ENV['CRITERIA']
url_manager = SongUrlsManager.new('https://genius.com/api/artists/117146')
agent = Mechanize.new
criteria = '' if criteria.nil?
if name.nil?
  print_every_battle(agent, url_manager, criteria)
else
  print_searched_battles(agent, url_manager, criteria, name)
end
