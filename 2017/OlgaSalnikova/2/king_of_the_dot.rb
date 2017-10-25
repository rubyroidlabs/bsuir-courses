require 'mechanize'
require_relative 'battle'

# class is used for defining the winner of the battle
class KingOfTheDot
  MAIN_PAGE_URL = 'https://genius.com/artists/King-of-the-dot'.freeze
  ALL_SONGS_LINK = 'Show all songs by King of the Dot'.freeze
  PAGES_XPATH = '//div[@class="pagination"]//a[not(@class="next_page")]'.freeze
  SONGS_LINKS_XPATH = './/ul[contains(@class, "song_list")]//a'.freeze
  SONG_TITLE_XPATH = './/span[@class="song_title"]'.freeze
  SONG_TEXT_XPATH = '//div[@class="lyrics"]/p'.freeze

  def initialize(name = nil, criteria = nil)
    @name = name
    @criteria = criteria
    @agent = Mechanize.new
    @wins = 0
    @loses = 0
  end

  def main_page
    @agent.get(MAIN_PAGE_URL)
  end

  def pages
    page = main_page.links.detect { |l| l.text =~ /#{ALL_SONGS_LINK}/ }.click
    @pages = [page]
    page.search(PAGES_XPATH).each do |a|
      puts "Download '#{a[:href]}'"
      @pages << @agent.get(a[:href])
    end
    @pages
  end

  def song_urls
    @song_urls = {}
    pages.each do |page|
      page.search(SONGS_LINKS_XPATH).each do |song|
        @song_urls[song.at(SONG_TITLE_XPATH).text] = song[:href]
      end
    end
    @song_urls
  end

  def print_all_battles_log
    song_urls.each do |title, url|
      next if @name && !Battle.get_singers(title).include?(@name)
      print_battle_log(title, url)
    end
  end

  def print_battle_log(title, url)
    song_page = @agent.get(url)
    song_text = song_page.at(SONG_TEXT_XPATH).text
    battle = Battle.new(title: title,
                        url: url,
                        text: song_text,
                        criteria: @criteria)
    battle.print
    print_stats(battle.winner) if @name
  end

  def print_stats(winner)
    if winner.include?(@name)
      @wins += 1
    else
      @loses += 1
    end
    puts "#{@name} wins #{@wins} times, loses #{@loses} times."
  end
end
