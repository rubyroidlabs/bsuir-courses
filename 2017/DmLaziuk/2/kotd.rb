require 'mechanize'
require_relative 'kotd_battle'

class Kotd
  START_PAGE = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'

  attr_reader :links, :name, :criteria

  def initialize(name = nil, criteria = nil)
    agent = Mechanize.new
    page = agent.get(START_PAGE)
    @links = []
    @name = name
    @criteria = criteria
    puts 'Initializing...'
    page.links_with(href: /\w+-lyrics/).each { |link| @links << link }
    next_page = page.links_with(class: 'next_page')[0]
    while next_page
      page = next_page.click
      page.links_with(href: /\w+-lyrics/).each { |link| @links << link }
      next_page = page.links_with(class: 'next_page')[0]
    end
  end

  def run
    if @name
      run_name
    else
      @links.each do |link|
        battle = KotdBattle.new(link.click, @criteria)
        puts battle
        puts
      end
    end
  end

  private

  def run_name
    wins = 0
    battles = @links.select { |link| link.text.scan(@name).size > 0 }
    battles.each do |link|
      battle = KotdBattle.new(link.click, @criteria)
      wins += 1 if battle.winner == @name
      puts battle
      puts
    end
    loses = battles.size - wins
    puts @name + ' wins ' + wins.to_s + ' times, loses ' + loses.to_s + ' times'
  end
end

name = ENV['NAME']
criteria = ENV['CRITERIA']

kb = Kotd.new(name, criteria)
kb.run
