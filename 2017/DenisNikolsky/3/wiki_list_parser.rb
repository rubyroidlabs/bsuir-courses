require 'mechanize'
require 'json'
require_relative 'Parser'

class WikiParser < Parser
  attr_accessor :links, :celeb

  def parse_wiki(link, celeb)
    @celeb = celeb
    page = @agent.get(link)
    title = 'List of gay, lesbian or bisexual people:'
    links = page.links_with(text: /#{title}.+/)
    parse_list(links)
    @celeb
  end

  def parse_list(links)
    numb_threads = 3
    package = links.size / numb_threads
    th = []
    first = 0
    numb_threads.times do |i|
      th << open_thread(links[first...package * (i + 1)])
      first += package
    end
    th.each(&:join)
  end

  def open_thread(links)
    links.each do |link|
      parse_table(link)
    end
  end

  def parse_table(link)
    page = link.click
    table = page.search('.wikitable')
    rows = table.css('tr')
    rows.shift.css('th')
    rows.map do |row|
      name = row.css('td .fn').text
      next if @celeb.key?(name)
      info = case row.css('td').map(&:text)[-1].scan(/[GLB]/).join
             when 'G'
               'Gay'
             when 'L'
               'Lesbian'
             else
               'Bisexual'
             end
      puts name, info
      @celeb[name] = info
    end
  end
end
