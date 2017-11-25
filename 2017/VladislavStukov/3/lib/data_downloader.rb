require 'mechanize'
require 'uri'

class DataDownloader
  IMDB_URL = 'http://www.imdb.com/list/ls072706884/'.freeze
  NEWNOWNEXT_URL = 'http://www.newnownext.com/gay-celebrities-coming-out-2016/10/2016/'.freeze
  PRIDE_URL = 'https://www.pride.com/comingout/2017/10/29/35-notable-people-who-came-out-2017-so-far#slide-1'.freeze

  def initialize
    @agent = Mechanize.new
  end

  def download
    # start all parse methods
    result = {}
    result = merge_result(result, parse_site_imdb)
    result = merge_result(result, parse_site_NewNowNext)
    result = merge_result(result, parse_site_pride)
  end

  private

  def merge_result(result, list)
    result.merge(list) do |_key, old, new|
      old.empty? ? new : old
    end
  end


  def parse_site_imdb
    page = @agent.get(IMDB_URL).search('div.list.detail')
    person_blocks = page.search('div.info')
    result = {}
    person_blocks.each do |block|
      name = block.search('b > a').text
      comment = block.search('div.item_description').text
      result[name] = comment
    end
    result
  end

  def parse_site_NewNowNext
    page = @agent.get(NEWNOWNEXT_URL)
    person_blocks = page.search('//*[@id="post-470013"]/div/section/ol/li').to_ary
    result = {}
    person_blocks[0..-2].each do |block|
      name = block.search('div > h3').text
      comment = block.search('div > p').text
      result[name] = comment
    end
    result
  end

  def parse_site_pride
    page = @agent.get(PRIDE_URL)
    names = page.search('span.introText')[1..-2]
    comments = page.search('div.readmore')[1..-2]
    result = {}
    names.each_with_index do |name, i|
      result[name.text.strip] = comments[i].text.strip
    end
    result
  end
end

