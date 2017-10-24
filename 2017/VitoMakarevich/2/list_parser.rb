require 'mechanize'
require 'json'
# parses
class ListParser
  FIRST_PAGE_NUMBER = 1
  attr_accessor :query
  attr_accessor :songs

  def initialize(query = nil)
    @query = query
    @agent = Mechanize.new
    @songs = []
    parse
  end

  private

  def parse
    next_page_number = parse_page(FIRST_PAGE_NUMBER)
    next_page_number = parse_page(next_page_number) while next_page_number
  end

  def parse_page(page_number)
    file_page = @agent.get(link(page_number))
    json_page = JSON.parse(file_page.body)['response']
    next_page_number = json_page['next_page']
    songs_page = json_page['songs']
    songs_page.each { |song| song.select! { |k| k == 'url' || k == 'title' } }
    @songs += songs_page
    next_page_number
  end

  def link(page_number)
    if @query
      'https://genius.com/api/artists/117146/' \
      "songs/search?page=#{page_number}&q=#{query}&sort=popularity"
    else
      'https://genius.com/api/artists/117146/' \
      "songs?page=#{page_number}&sort=popularity"
    end
  end
end
