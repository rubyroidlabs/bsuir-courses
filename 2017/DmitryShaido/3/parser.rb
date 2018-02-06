require 'mechanize'

LINK = 'http://www.imdb.com/list/ls072706884/'.freeze

class Parser
  attr_accessor :page, :list_of_names

  def initialize
    agent = Mechanize.new
    @page = agent.get(LINK)

    print_names
    read_names
  end

  def print_names
    file = File.open('list.txt', 'w')

    @page.search('div.info b').each do |name|
      file.print(name.text + '\n')
    end

    file.close
  end

  def read_names
    file = File.open('list.txt', 'r')
    @list_of_names = file.read.split('\n')
    file.close
  end
end
