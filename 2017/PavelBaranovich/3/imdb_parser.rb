require 'mechanize'

class IMDbParser
  ARTICLE_LINK = 'http://www.imdb.com/list/ls072706884/'.freeze

  attr_writer :names

  def initialize
    @names = []
  end

  def parse
    agent = Mechanize.new
    page = agent.get(ARTICLE_LINK)

    i = 0
    page.links_with(href: %r{^\/name}).each do |link|
      next if link.href.to_s =~ /\?/
      @names.push(link.text) if i.odd?
      i += 1
    end
  end
end
