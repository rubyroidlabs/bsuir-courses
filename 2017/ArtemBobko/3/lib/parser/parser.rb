require 'mechanize'
require 'uri'

module Parser
  LIST_URL = 'http://www.imdb.com/list/ls059403065'.freeze
  FILE_NAME = 'database.txt'.freeze

  def self.clear_database
    File.open(FILE_NAME, 'w') { |file| file.truncate(0) }
  end

  def self.get_celebrities_to_file(next_page = '')
    agent = Mechanize.new
    request = URI(LIST_URL) + next_page
    page = agent.get(request)
    list = page.search('#main .list.detail>div')
    File.open(FILE_NAME, 'a') do |file|
      list.each do |el|
        file.puts(el.search('.info>b').text)
        # el.search('.description').text
      end
    end
    next_page = page.search('#main .see-more .pagination>a').first.values.first
    is_next = page.search('#main .see-more .pagination>a').text
    get_celebrities_to_file(next_page) if is_next.scan(/next/i).first
  end
end
