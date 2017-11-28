require 'mechanize'

class DataDownloader
  IMDB_URL = 'http://www.imdb.com/list/ls072706884/'.freeze

  def download
    # start all parse methods
    result = {}
    result.merge!(parse_site_imdb) do |_key, old_val, new_val|
      old_val.empty? ? new_val : old_val
    end
    result
  end

  def parse_site_imdb
    agent = Mechanize.new
    page = agent.get(IMDB_URL).search('div.list.detail')
    person_blocks = page.search('div.info')
    result = {}
    person_blocks.each do |block|
      name = block.search('b > a').text
      comment = block.search('div.item_description').text
      result[name] = comment
    end
    result
  end
end
