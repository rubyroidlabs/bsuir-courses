require 'mechanize'


class Parser
  attr_accessor :celebrity
  def initialize
    @agent = Mechanize.new
    @celebrity = {}
  end
  module Imdb
    LINK = 'http://www.imdb.com/list/ls072706884/'.freeze
    def parse(c_name)
      page = @agent.get(LINK)
      @celebrity[:NAME] = c_name
      list = page.css('.list_item')
      list.each do |item|
        name_str = page.search('.info a').text
        next if @celebrity[:NAME].key?(name_str)
        case row.css('td').map(&:text).scan(/(Gay|Lesbian|Bisexual)/).join
          when 'Gay'
            @celebrity[:ORINTATION] = 'Gay'
          when 'Lesbian'
            @celebrity[:ORINTATION] = 'Lesbian'
          when 'Bisexual'
            @celebrity[:ORINTATION] = 'Bisexual'
        end
      end
      end
    end
  module Wiki
    LINK = 'https://en.wikipedia.org/wiki/List_of_gay,_lesbian_or_bisexual_people'.freeze
    def parse(c_name)
      page = @agent.get(LINK)
      @celebrity[:NAME] = c_name
      links = page.links_with(text: 'List of gay, lesbian or bisexual people:')
      links.each do |link|
        getInfo(link)
      end
    end

    def getInfo(link)
      page = @agent.get(link)
      table = page.search('.wikitable')
      table_lines = table.css('tr')
      table_lines.each do |line|
        str = line.css('td').text
        next if @celebrity[:NAME].key?(str)
        case row.css('td').map(&:text).scan(/[GLB]/).join
        when 'Gay'
          @celebrity[:ORINTATION] = 'Gay'
        when 'Lesbian'
          @celebrity[:ORINTATION] = 'Lesbian'
        when 'Bisexual'
          @celebrity[:ORINTATION] = 'Bisexual'
        end
      end
    end
  end
end
