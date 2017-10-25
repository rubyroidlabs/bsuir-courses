require 'rubygems'
require 'mechanize'
require 'json'
require_relative 'battle.rb'

class Battles
  def initialize
    @agent = Mechanize.new
    @request = 'https://genius.com/api/artists/117146/songs?page='
    @songs = []
  end

  def get_all_battles
    next_page = 1
    puts "Подождите пока баттлы загрузятся."
    until next_page.nil?
      puts '...'
      songs = @agent.get(@request + next_page.to_s).content
      songs = JSON.parse(songs)
      next_page = songs['response']['next_page']
      songs = songs['response']['songs'].uniq
      songs.map do |song|
        battle = Battle.new(@agent.get(song['url']), song)
        @songs << battle
      end
    end
  end

  def put_all_battles
    @songs.map do |battle|
      battle.count_symbols
      puts battle.song['title'] + ' - ' + battle.song['url']
      battle.output
    end
  end

  def put_name_battles(name)
    wins = 0
    loses = 0
    @songs.map do |battle|
      if (battle.rappers.first == name) || (battle.rappers.last == name)
        battle.count_symbols
        puts battle.song['title'] + ' - ' + battle.song['url']
        battle.output
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
