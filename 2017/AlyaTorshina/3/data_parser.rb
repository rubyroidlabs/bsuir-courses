require 'mechanize'

class DataParser
  LINK = 'http://www.imdb.com/list/ls072706884/'.freeze

  def initialize
    @page = Mechanize.new.get(LINK)
  end

  def record
    file = File.new('data.txt', 'w')
    @page.search('div.info b').each do |item|
      file.print(item.text + '*')
    end
    file.close
  end

  def read
    file = File.new('data.txt')
    content = file.read
    file.close
    content.split('*')
  end
end
