require 'mechanize'

# LgbtWikipedia class is used for fetching artist from wikipedia site
class LgbtWikipedia
  ARTISTS_LINK_XPATH = '//div[@class = "mw-category-group"]//a'.freeze
  LGBT_CATEGORIES = [
    'https://en.wikipedia.org/wiki/Category:LGBT_actresses',
    'https://en.wikipedia.org/wiki/Category:Bisexual_actresses',
    'https://en.wikipedia.org/wiki/Category:Lesbian_actresses',
    'https://en.wikipedia.org/wiki/Category:Bisexual_actors',
    'https://en.wikipedia.org/wiki/Category:Bisexual_actresses',
    'https://en.wikipedia.org/wiki/Category:Bisexual_male_actors',
    'https://en.wikipedia.org/wiki/Category:LGBT_male_actors',
    'https://en.wikipedia.org/wiki/Category:Gay_actors'
  ].freeze

  def initialize
    @agent = Mechanize.new
  end

  def pages
    @pages = LGBT_CATEGORIES.map do |page|
      @agent.get(page)
    end
  end

  def artists
    unless @artists_list
      @artists_list = {}
      pages.each do |page|
        page.search(ARTISTS_LINK_XPATH).each do |name|
          @artists_list[correct_artist_name(name.text)] = ''
        end
      end
    end
    @artists_list
  end

  private

  def correct_artist_name(text)
    if text.include?('(')
      text[/([^(]+?)\s*\(/, 1]
    else
      text
    end
  end
end
