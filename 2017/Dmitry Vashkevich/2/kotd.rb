require 'mechanize'
require 'pry'
require_relative 'battle'

class Kotd

  attr_accessor :list_battles

  def initialize
    @list_battles = []
  end

  def loading_battles (criterion)
    a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    list_battles = []
    threads = []
    a.get('https://genius.com/artists/King-of-the-dot') do |page|
      albums_page = a.click(page.link_with(:text => /Show all albums by King of the Dot/))
      albums_page.links_with(:href => %r{/albums/King-of-the-dot/} ).each do |page_album|
        threads << Thread.new do
          a.get(page_album.href) do |page_battles|
            page_battles.links_with(:href=>%r{/King-of-the-dot-}).each do |page_battle|
              a.get(page_battle.href) do |link_to_battle|
                battle = Battle.new(link_to_battle.uri)
                battle.get_data(link_to_battle.css('.lyrics').text, criterion)
                @list_battles << battle if battle.first_name != nil && battle.second_name != nil
              end
            end
          end
        end
      end
      threads.each do |thread|
        while thread.alive?
          print '.'
          sleep(0.1)
        end
      end
      puts '!'
    end
  end

  def show_battles(name)
    if name.nil?
      list_battles.each do |battle|
        battle.show
      end
    else
      count_wins = 0
      count_losses = 0
      list_battles.each do |battle|
        if battle.first_name == name || battle.second_name == name
          battle.show
          if battle.get_winner == name
            count_wins += 1
          elsif battle.get_winner != "Draw"
            count_losses += 1
          end
        end
      end
      if count_wins > 0 || count_losses > 0
        puts "#{name} wins #{count_wins} times, loses #{count_losses} times."
      else
        puts "Information about #{name} is missing"
      end
    end
  end
end
