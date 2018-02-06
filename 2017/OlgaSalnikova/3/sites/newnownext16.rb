require 'mechanize'

# Newnownext2016 class is used for fetching artists from newnownext site,
# who are comming out in 2016 year
class Newnownext2016
  MAIN_PAGE_URL = 'http://www.newnownext.com/gay-celebrities-coming-out-2016/10/2016/'.freeze
  ARTIST_XPATH_CONTAINER = '//ol[contains(@class, "listicle-container")]//li'.freeze
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
      main_page.search(ARTIST_XPATH_CONTAINER).each do |artist|
        unless artist.at(ARTIST_NAME_XPATH).text == ''
          @artists_list[artist.at(ARTIST_NAME_XPATH).text] = artist.search(ARTIST_DESCRIPTION).text
        end
      end
    end
    @artists_list
  end
end
