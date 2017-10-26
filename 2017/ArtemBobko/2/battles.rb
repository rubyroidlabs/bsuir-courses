require 'rubygems'
require 'mechanize'
require 'json'
require 'uri'
require_relative 'battle.rb'


class Battles
  def initialize
    @agent = Mechanize.new
    @songs = []
  end

  def get_all_battles
    next_page = 1
    threads = []
    request = URI 'https://genius.com/api/artists/117146/songs?page=1'
    puts 'Подождите пока батлы загрузятся.'
    until request.query.eql? 'page='
      songs = JSON.parse(@agent.get(request).content)
      request.query = "page=#{songs['response']['next_page']}"
      songs = songs['response']['songs'].uniq
      threads << Thread.new do
        songs.map do |song|
          battle = Battle.new(@agent.get(song['url']), song)
          @songs << battle
        end
      end
    end
    threads.each(&:join)
  end

  def output_battle(battle)
    battle.count_symbols
    puts "#{battle.song['title']} - #{battle.song['url']}"
    battle.output
  end

  def put_all_battles
    @songs.map do |battle|
      process_battle(battle)
    end
  end

  def put_name_battles(name)
    wins = 0
    loses = 0
    @songs.map do |battle|
      if battle.rappers.any? {|r| r.eql? name}
        output_battle(battle)
        if battle.win?(name)
          wins += 1
        else
          loses += 1
        end
      end
    end
    puts "#{name} wins #{wins} times, loses #{loses} times."
  end
end
