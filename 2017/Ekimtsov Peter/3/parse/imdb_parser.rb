require 'mechanize'

# IMDB list parser
class IMDBParser
  URL_1 = 'http://www.imdb.com/list/ls072706884/'.freeze
  URL_2 = 'http://www.imdb.com/list/ls059456655/'.freeze

  attr_reader :names

  def initialize
    @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @page1 = @agent.get(URL_1)
    @page2 = @agent.get(URL_2)
    @names = []
    names_info
  end

  private

  def names_info
    @page1.css('.list.detail').css('b').css('a').each do |name|
      @names.push(name.text)
    end
    @page2.css('.list.detail').css('b').css('a').each do |name|
      @names.push(name.text)
    end
  end
end
