require 'mechanize'

class Parse
  IMDB_LINK = 'http://www.imdb.com/list/ls072706884/'.freeze
  FILE = 'status_list'.freeze

  def self.imdb
    agent = Mechanize.new
    page = agent.get(IMDB_LINK)
    file = File.open(FILE, 'w')
    page.css('.list.detail .list_item').size.times do |i|
      person = page.css('.list.detail .info b')[i].text
      status = page.css('.list.detail .description')[i].text.split(' ')[1]
      file.puts("#{person}-#{status}")
    end
    file.close
  end
end

Parse.imdb
