require 'mechanize'
require_relative 'kotd_battle'

class Kotd
  START_PAGE = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'.freeze

  attr_reader :links, :name, :criteria

  def initialize(name = nil, criteria = nil)
    @links = []
    @name = name
    @criteria = criteria
    parse_links
  end

  def run
    if @name
      run_by_name
    else
      run_all
    end
  end

  private

  def parse_links
    puts 'Initializing...'
    puts
    agent = Mechanize.new
    page = agent.get(START_PAGE)
    page.links_with(href: /\w+-lyrics/).each { |link| @links << link }
    next_page = page.links_with(class: 'next_page').first
    while next_page
      page = next_page.click
      page.links_with(href: /\w+-lyrics/).each { |link| @links << link }
      next_page = page.links_with(class: 'next_page').first
    end
  end

  def run_all
    @links.each do |link|
      battle = KotdBattle.new(link.click, @criteria)
      puts battle
      puts
    end
  end

  def run_by_name
    wins = 0
    battles = @links.select { |link| link.text.scan(@name).size >= 1 }
    battles.each do |link|
      battle = KotdBattle.new(link.click, @criteria)
      wins += 1 if battle.winners.include?(@name.to_sym)
      puts battle
      puts
    end
    loses = battles.size - wins
    puts @name + ' wins ' + wins.to_s + ' times, loses ' + loses.to_s + ' times'
  end
end

name = ENV['NAME']
criteria = ENV['CRITERIA']
Kotd.new(name, criteria).run
