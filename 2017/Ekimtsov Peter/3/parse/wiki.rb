require 'mechanize'

# Wikipedia list parser
class WikiParser
  URL = 'https://en.wikipedia.org/wiki/List_of_gay,_lesbian_or_bisexual_people'.freeze

  attr_reader :names

  def initialize
    @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @page = @agent.get(URL)
    @names = []
    @links = []
    names_info
  end

  private

  def names_info
    @links = @page.links_with(text: /List of gay, lesbian or bisexual people/)
    @links.each do |link|
      page = link.click
      page.search('.wikitable').css('span.fn').css('a').each do |elem|
        @names.push(elem.text)
      end
    end
  end
end
