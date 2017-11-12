require 'mechanize'
require_relative 'constants'
require_relative 'comingout_db'

module Comingout
  class ParseWikipedia
    WIKI_PAGE = 'https://en.wikipedia.org/wiki/List_of_gay,_lesbian_or_bisexual_people'.freeze

    def initialize(db)
      @agent = Mechanize.new
      @db = db
      @count = 0
    end

    def parse
      print 'Parsing en.wikipedia.org '
      path = '//*[@id="mw-content-text"]/div/div[3]/ul/li/a'
      links = @agent.get(WIKI_PAGE).links_with(xpath: path)
      urls = links.map { |link| "https://en.wikipedia.org/wiki/#{link}" }
      urls.each do |url|
        print '.'
        page = @agent.get(url)
        parse_table(page)
      end
      puts "\n#{@count} entries added"
    end

    private

    def parse_table(page)
      tr = page.xpath('//*[@id="mw-content-text"]/div/table/tr')
      tr.shift # table header
      tr.each do |row|
        td = row.xpath('./td')
        next if td.size != 5 # duct tape for error in "Z" table
        name = td[0].xpath('.//a')
        ref = td[4].xpath('.//a/@href')
        ref_path = "//*[@id=\"#{ref.text[1..-1]}\"]"
        ref_path << '//span[@class="reference-text"]'
        ref_text = page.xpath(ref_path).text
        uri = "https://en.wikipedia.org#{name.xpath('@href')}"
        @db.add(name.text, uri, ref_text)
        @count += 1
      end
    end
  end
end
