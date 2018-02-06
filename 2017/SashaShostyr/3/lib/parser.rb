require 'rubygems'
require 'mechanize'
require 'json'
require_relative 'database'

class Parser
  LINK_IMDB_LIST = 'http://www.imdb.com/list/ls072706884/'.freeze

  def initialize
    @db = Database.new
  end

  def set_data
    hash = {}
    agent = Mechanize.new
    page = agent.get(LINK_IMDB_LIST)
    list_items = page.search('.list_item')
    list_items.each do |el|
      name = el.search('.info b').text
      uri = page.link_with(text: /#{name}/).resolved_uri.to_s
      orientation = el.search('.description').text.split('-')[0]
      hash[name.upcase] = { uri: uri, orientation: orientation }
    end
    @db.set_hash(hash)
  end

  def get_data
    @db.get_hash
  end
end
