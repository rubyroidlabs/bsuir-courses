require 'mechanize'

# Imdb class is used for fetching  artists from imdb site
class Imdb
  MAIN_PAGE_URL = 'http://www.imdb.com/list/ls072706884/'.freeze
  ARTISTS_LINK_XPATH = '//div[@class="list detail"]//div[@class="info"]/b/a'.freeze

  def initialize
    @agent = Mechanize.new
  end

  def main_page
    @agent.get(MAIN_PAGE_URL)
  end

  def artists
    unless @artists_list
      @artists_list = {}
      main_page.search(ARTISTS_LINK_XPATH).each do |node|
        @artists_list[node.text] = ''
      end
    end
    @artists_list
  end
end
