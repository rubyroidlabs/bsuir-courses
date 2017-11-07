require 'mechanize'
require_relative 'parser'

class IMDBParser
  include Parser
  PAGE = 'http://www.imdb.com/list/ls072706884/'.freeze

  private

  def page
    Mechanize.new.get(PAGE)
  end

  def celebrities_list
    page.search('.list_item')
  end

  def name(celebrity)
    celebrity.search('b').text
  end

  def orientation(celebrity)
    celebrity.search('.description').text.scan(/\w+/)[0]
  end

  def description(_celebrity)
    ''
  end
end
