require 'mechanize'
require 'pry'
require_relative 'battle'

class Kotd
  attr_accessor :list_battles

  def initialize
    @list_battles = []
  end

  def loading_battles(criterion)
    a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    threads = []
    a.get('https://genius.com/artists/King-of-the-dot') do |page|
      text = 'Show all albums by King of the Dot'
      albums_page = a.click(page.link_with(text: /#{text}/))
      link_albums = '/albums/King-of-the-dot/'
      albums_page.links_with(href: /#{link_albums}/ ).each do |page_album|
        threads << Thread.new do
          a.get(page_album.href) do |page_battles|
            link_bat = '/King-of-the-dot-'
            page_battles.links_with(href: /#{link_bat}/).each do |page_battle|
              a.get(page_battle.href) do |link_to_battle|
                battle = Battle.new(link_to_battle.uri)
                battle.get_data(link_to_battle.css('.lyrics').text, criterion)
                add_battle(battle)
              end end end end end
      threads.each { |thread| show_loading(thread) }
    end
  end

  def add_battle(battle)
    if !battle.first_name.nil? && !battle.second_name.nil?
      @list_battles << battle
    end
  end

  def show_loading(thread)
    while thread.alive?
      print '.'
      sleep(0.1)
    end
  end

  def show_battles(name)
    if name.nil?
      list_battles.each(&:show)
    else
      count_wins = 0
      count_losses = 0
      list_battles.each do |battle|
        if [battle.first_name, battle.second_name].include?(name)
          battle.show
          if battle.get_winner == name
            count_wins += 1
          elsif battle.get_winner != 'Draw'
            count_losses += 1
          end
        else next
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
