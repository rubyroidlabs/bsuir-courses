require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'

class Parser
  PAGE = HTTParty.get('http://www.imdb.com/list/ls072706884/')
  PARSE_PAGE = Nokogiri::HTML(PAGE)

  def set_data
    actors = []
    PARSE_PAGE.css('.info b').map do |a|
      post_name = a.text
      actors.push(post_name)
    end
    actors
  end

  def file_print(actors)
    file = File.new('data.txt', 'w')
    actors.each do |a|
      file.puts a
    end
    file.close
  end

  def file_read
    file = File.new('data.txt')
    content = file.read
    file.close
    content
  end
end
