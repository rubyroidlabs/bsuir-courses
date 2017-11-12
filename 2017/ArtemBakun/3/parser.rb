require 'mechanize'

class Parser
  attr_accessor :data

  def initialize
    @data = []
  end

  def parser
    agent = Mechanize.new
    page = agent.get('http://www.imdb.com/list/ls072706884/')
    met = 0
    page.links.each do |link|
      l = link.href
      next unless l =~ /name/
      next if l =~ /ref_=rlm/
      next if l =~ /search/
      @data.push(link.text) if met.odd?
      met += 1
    end
  end

  def write_to_file
    file = File.open('data.txt','w')
    @data.each do |text|
      file.puts(text)
    end
  end

  def reading_from_file
    File.open('data.txt', 'r') do |file|
      file.each do |text|
        @data.push(text)
      end
    end
  end
end
