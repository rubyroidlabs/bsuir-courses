require 'nokogiri'
require 'curb'
require 'pry'
require 'rubocop'
require 'csv'
require_relative './data/constants.rb'
require_relative './lib/parse.rb'
require_relative './lib/output.rb'

class Crawler
  attr_accessor :info

  def initialize(filename)
    @source = filename
  end

  def start
    parser = Parse.new
    parser.get_page_doc(@info[0])
    list = parser.get_list(@info[1], @info[2])
    file = Output.new("data/#{@source}")
    file.save_data(list)
  end
end

crawler = Crawler.new('imdb_no_desc')
crawler.info = [IMDB_URL1, IMDB_NAME, IMDB_DESC]
crawler.start

crawler = Crawler.new('imdb')
crawler.info = [IMDB_URL2, IMDB_NAME, IMDB_DESC]
crawler.start

crawler = Crawler.new('nnn2016')
crawler.info = [NNN2016_URL, NNN_NAME, NNN_DESC]
crawler.start

crawler = Crawler.new('nnn2017')
crawler.info = [NNN2017_URL, NNN_NAME, NNN_DESC]
crawler.start

crawler1 = Crawler.new('mic')
crawler1.info = [MIC_URL, MIC_NAME, MIC_DESC]
crawler1.start

`
cd data
cat imdb nnn2016 nnn2017 mic imdb_no_desc > source
`
