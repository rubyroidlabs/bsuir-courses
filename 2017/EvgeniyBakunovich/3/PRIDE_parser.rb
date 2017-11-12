require 'mechanize'
require 'json'
class PrideParser
  attr_accessor :link, :info

  def initialize(link)
    @link = link
    @info = {}
  end

  def parse_page
    agent = Mechanize.new
    page = agent.get(@link)
    names = page.search('div.introBar')
    names.shift
    names.pop
    descriptions = page.search('div.readmore')
    descriptions.shift
    descriptions.pop
    i = 0
    loop do
      temp_name = names[i].text.to_s
      temp_name.slice!(0)
      temp_name.slice!(temp_name.index('  ')..temp_name.size)
      temp_name.chomp!
      temp_name.slice!(temp_name.size - 1)
      temp = descriptions[i].text.to_s
      temp.slice!(0)
      temp.delete!(/[\n]/).delete!(/\"/)
      @info.store(temp_name, temp)
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
