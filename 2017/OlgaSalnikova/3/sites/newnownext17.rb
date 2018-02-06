require 'mechanize'

# Newnownext2017 class is used for fetching artists from newnownext site
# who are comming out in 2017 year
class Newnownext2017
  MAIN_PAGE_URL = 'http://www.newnownext.com/gay-celebrities-coming-out-2017/'.freeze
  ARTIST_CONTAINER = '//ol[contains(@class, "listicle-container")]//li'.freeze
  ARTIST_NAME_XPATH = './/div[@class = "heading-container"]/h3'.freeze
  ARTIST_DESCRIPTION = './/div[@class = "description-container"]/p'.freeze

  def initialize
    @agent = Mechanize.new
  end

  def main_page
    @agent.get(MAIN_PAGE_URL)
  end

  def artists
    unless @artists_list
      @artists_list = {}
      main_page.search(ARTIST_CONTAINER).each do |artist|
        @artists_list[artist.at(ARTIST_NAME_XPATH).text] = artist.search(ARTIST_DESCRIPTION).text
      end
    end
    @artists_list
  end
end
