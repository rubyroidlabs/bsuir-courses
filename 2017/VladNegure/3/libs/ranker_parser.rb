require 'json'
require 'mechanize'
require_relative 'parser'

class RankerParser
  include Parser
  PAGE = 'https://cache-api.ranker.com/lists/1209725/items?limit=100&'.freeze

  private

  def page
    JSON.parse(Mechanize.new.get(PAGE).content)
  end

  def celebrities_list
    page['listItems']
  end

  def name(celebrity)
    celebrity['name']
  end

  def orientation(_celebrity)
    ''
  end

  def description(celebrity)
    celebrity['blather'].gsub(/<[^>]*>|&[^;]*;/, '')
  end
end
