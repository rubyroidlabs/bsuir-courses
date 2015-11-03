require 'mechanize'
require 'nokogiri'
require 'open-uri'

class Downloader

  attr_reader :page

  def initialize
    @agent = Mechanize.new
  end

  def get_page url
    @agent.get(url)
    @page = @agent.current_page
  end

  def get_page_nokogiri url
    @page = Nokogiri::HTML(open(url))
  end
end
