require 'nokogiri'
require 'open-uri'

class Page
  def initialize(url)
    @page = Nokogiri::HTML(open(url))
  end

  def get_versions(str)
    @page.css(str)
  end
end
