require 'mechanize'
require 'json'

class GayStarNewsParser
  attr_accessor :link, :info

  def initialize(link)
    @link = link
    @info = {}
  end

  def parse_page
    agent = Mechanize.new
    page = agent.get(@link)
    names = page.search('p/strong')
    descriptions = page.search('div/p')
    i = 0
    j = 2
    loop do
      temp = ''
      temp_name = names[i].text.to_s
      temp_name.slice!(0..temp_name.index('.'))
      temp_name.slice!(temp_name.index('(')..temp_name.index(')'))
      temp_name.strip!
      loop do
        break if descriptions[j].text.to_s.index(/[0-9]/).zero? || j == 105
        temp += descriptions[j].text.to_s
        j += 1
      end
      @info.store(temp_name, temp)
      i += 1
      j += 2
      break if i == names.size
    end
  end

  def show
    @info.each do |key, value|
      puts key
      puts value
    end
  end

  def copy
    celebrities = @info
    celebrities
  end
end
