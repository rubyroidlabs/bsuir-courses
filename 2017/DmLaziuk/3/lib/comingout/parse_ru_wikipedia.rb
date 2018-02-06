require 'mechanize'
require_relative 'constants'
require_relative 'comingout_db'

module Comingout
  class ParseRuWikipedia
    WIKI_PAGE = 'https://ru.wikipedia.org/wiki/Проект:ЛГБТ/Списки'\
      '/Известные_лесбиянки,_геи_и_бисексуалы_России'.freeze

    def initialize(db)
      @agent = Mechanize.new
      @db = db
      @count = 0
    end

    def parse
      print 'Parsing ru.wikipedia.org '
      print '.'
      page = @agent.get(WIKI_PAGE)
      parse_table(page)
      puts "\n#{@count} entries added"
    end

    private

    def parse_table(page)
      tr = page.xpath('//*[@id="mw-content-text"]/div/table/tr')
      tr.shift # table header
      tr.each do |row|
        td = row.xpath('./td')
        name = td[3].xpath('.//a')
        note = td[4].text
        note.gsub!(/\[\d*?\]/, '')
        uri = "https://ru.wikipedia.org#{name.xpath('@href')}"
        @db.add(name.text, uri, note)
        @count += 1
      end
    end
  end
end
