require 'mechanize'
require 'json'
require 'uri'
require 'pry'
require 'redis'

class WebParser
  IMDB_CUT_WORD = ' - mick96890'.freeze
  IMDB_NO_DETAILS = 'Sorry, I have no more details'.freeze

  def initialize
    @redis = Redis.new
    @agent = Mechanize.new
    @uri_imdb = URI 'http://www.imdb.com/list/ls072706884/'
    @uri_ranker = URI 'https://www.ranker.com/list/famous-gay-men-list-of-gay-men-throughout-history/famous-gay-and-lesbian'
    @uri_best_gay_checker = URI 'https://gay-cheker.herokuapp.com/gays.json'

    @name = []
    @status = []
    @details = []
    @database = {}
  end

  def parser_imdb
    page = @agent.get @uri_imdb
    page.css('.list_item').each do |x|
      @name << x.css('.info b a').text
      @status << x.css('.description > text()').text.gsub(IMDB_CUT_WORD, '')
      @details << x.css('.item_description').text
    end
    @details.map! { |el| el == '' ? IMDB_NO_DETAILS : el }
    @name.zip(@status.zip(@details)).to_h
  end

  def parser_ranker
    page = @agent.get @uri_ranker
    page.css('.listItem__title').each { |x| @name << x.css('> text()').text }
    page.css('.listItem__blather').each do |x|
      link = x.css('a').first.attr('href').gsub('//m.', 'https://www.')
      @details << (x.text + link)
      @status << 'Gay'
    end
    @name.zip(@status.zip(@details)).to_h
  end

  def parser_best_gay_checker
    page = @agent.get @uri_best_gay_checker
    gays = JSON.parse page.body
    gays.each_with_object({}) { |(k, v), h| h[k] = [v] }
  end

  def union_gays
    parser_ranker.merge(parser_imdb).merge(parser_best_gay_checker)
  end

  def save_to_redis(hash)
    hash.each do |k, v|
      @redis.set(k, v)
      @redis.set(k.split.last, k)
    end
  end
end
