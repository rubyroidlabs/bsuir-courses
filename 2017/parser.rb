require 'mechanize'
# class for parsing site
class Parser
  attr_accessor :address
  attr_accessor :page
  attr_accessor :agent
  attr_accessor :people_list
  attr_accessor :people_list_arr
  def initialize
    @address = 'http://www.imdb.com/list/ls072706884/'.freeze
    @agent = Mechanize.new
    @page = agent.get(address)
  end

  def load_people_list
    @people_list = agent.page.search('.info b a').map(&:text).join("\n")
  end

  def write_people_list
    File.open('Celebrities.txt', 'w') { |file| file.puts people_list }
  end

  def read_people_list
    str = File.open('Celebrities.txt', &:read)
    @people_list_arr = str.split(/\n+/)
  end
end
