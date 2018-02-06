require 'mechanize'
require 'pry'
# class for parse info from imdb
class Parser
  PAGE = 'http://www.imdb.com/list/ls072706884/'.freeze
  SELECTOR = '.list_item > .info > b > a'.freeze
  def self.parse
    agent = Mechanize.new
    items = agent.get(PAGE).parser.css(SELECTOR).map(&:text)
    file = File.new('infofile', 'w+')
    file.puts(items)
    file.close
  end
end
