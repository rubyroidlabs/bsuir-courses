require 'mechanize'

class Parser
  IMDB_LIST = 'http://www.imdb.com/list/ls072706884/'.freeze

  def initialize
    @page = Mechanize.new.get(IMDB_LIST)
  end

  def get_data
    file = File.new('celeb.txt', 'w')
    @page.search('div.info b').each do |a|
      file.print(a.text + '<--->')
    end
    file.close
  end

  def read_data
    file = File.new('celeb.txt')
    content = file.read
    file.close
    content.split('<--->')
  end
end
