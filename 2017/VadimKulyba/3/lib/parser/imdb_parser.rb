require 'mechanize'
require_relative 'pars'

class IMDBParser < Pars
  URI = 'http://www.imdb.com/list/ls072706884/'.freeze

  def parse(redis)
    page = @agent.get URI
    index = 0
    loop do
      name = page.search('b')[index].text
      status = page.search('.description')[index + 1]
      break if status.nil? || name.nil?
      redis.set(name, status.text.split('-').first)
      index += 1
    end
  end
end
