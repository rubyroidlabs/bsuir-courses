require 'mechanize'

class Parser
  attr_accessor :info

  def initialize
    @info = []
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
      @info.push(link.text) if met.odd?
      met += 1
    end
  end

  def write_to_file
    file = File.open('data.txt', 'w')
    @info.each do |text|
      file.puts(text)
    end
  end

  def reading_from_file
    File.open('data.txt', 'r') do |file|
      file.each do |text|
        @info.push(text)
      end
    end
  end
end
