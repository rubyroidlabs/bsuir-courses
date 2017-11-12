require 'mechanize'
require 'json'

class IMDbParser
  attr_accessor :link, :info

  def initialize(link)
    @link = link
    @info = {}
  end

  def parse_page
    agent = Mechanize.new
    page = agent.get(@link)
    names = page.search('div.info').css('b').css('a')
    descriptions = page.search('div.description')
    descriptions.shift
    i = 0
    loop do
      temp = descriptions[i].text.to_s
      temp.slice!(0..1)
      temp.slice!(temp.size - 14..temp.size)
      @info.store(names[i].text.to_s, temp)
      i += 1
      break if i == names.size
    end
  end

  def copy
    celebrities = @info
    celebrities
  end

  def show
    @info.each do |key, value|
      puts key
      puts value
    end
  end
end
