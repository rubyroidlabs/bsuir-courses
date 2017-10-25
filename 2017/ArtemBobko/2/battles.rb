require 'rubygems'
require 'mechanize'
require 'json'
require_relative 'battle.rb'

class Battles
  def initialize()
    @agent = Mechanize.new
    @request = 'https://genius.com/api/artists/117146/songs?page='
    @songs = Array.new
  end

  def get_all_battles()
    next_page = 1
    until next_page.nil?
      songs = @agent.get(@request + next_page.to_s).content
      songs = JSON.parse(songs)
      next_page = songs['response']['next_page']
      songs = songs['response']['songs'].uniq
      @songs += songs
    end
  end

  def put_all_battles
    @songs.map do |song|
      battle = Battle.new(@agent.get(song['url']), song)
      battle.count_symbols
      puts song['title'] + ' - ' + song['url']
      battle.output
    end
  end

  def put_name_battles(name)
    wins = 0
    loses = 0
    @songs.map do |song|
      battle = Battle.new(@agent.get(song['url']), song)
      if (battle.rappers[0] == name) || (battle.rappers[1] == name)
        battle.count_symbols
        puts song['title'] + ' - ' + song['url']
        battle.output
        if battle.is_win?(name)
          wins += 1
        else
          loses += 1
        end
      end
    end
    puts "#{name} wins #{wins} times, loses #{loses} times."
  end
end
