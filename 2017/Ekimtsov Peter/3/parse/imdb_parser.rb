require 'mechanize'

# IMDB list parser
class IMDBParser
  URL = 'http://www.imdb.com/list/ls072706884/'.freeze

  def initialize
    @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @page = @agent.get(URL)
    @orientations = []
    @names = []
  end

  def names_orientation
    @page.css('.list.detail').css('b').css('a').each do |name|
      @names.push(name.text)
    end
    @page.css('.list.detail').css('.description').each do |orientation|
      @orientations.push(orientation.text.slice(/Gay|Lesbian|Bisexual/))
    end
    Hash[@names.zip(@orientations)]
  end
end
