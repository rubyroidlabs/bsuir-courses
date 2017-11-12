require 'mechanize'
require 'json'
class Parser
  def initialize(base = nil)
    @sourse = { url1: 'http://www.imdb.com/list/ls072706884/',
                url2: 'http://www.newnownext.com/gay-celebrities-comi'\
                'ng-out-2017/10/2017/',
                url3: 'https://mic.com/articles/105180/25-courageous-'\
                      'lgbt-celebrities-who-came-out-of-the-closet-in'\
                      '-2014#.gACSz4U8G' }
    @arr_name = []
    @arr_desc = []
    @base = base
    @celebrity = {}
    @agent = Mechanize.new
  end

  def parser(url, pattern_name, pattern_descr)
    page = @agent.get(url)
    names_stars = page.search(pattern_name)
    names_stars.each { |item| @arr_name.push(item.text) }
    descr_stars = page.search(pattern_descr)
    descr_stars.each { |item| @arr_desc.push(item.text) }
  end

  def run_parser
    parser(@sourse[:url1], '.list_item .info b a', '.item_description')
    parser(@sourse[:url2], '.heading', '.description-container p:first-child')
    parser(@sourse[:url3], '.article-page-body h3', '.article-page-body p')
    create_hash
    write_to_hash
  end

  def write_to_hash
    File.open(@base, 'w+') do |f|
      f.puts(@celebrity)
    end
  end

  def create_hash
    @arr_name.each_index do |i|
      unless @celebrity.key?(@arr_name[i])
        @celebrity[@arr_name[i]] = @arr_desc[i]
      end
    end
    @celebrity = @celebrity.to_json
  end
end
