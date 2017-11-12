require 'mechanize'
require_relative 'pars'

class NewNowNextParser < Pars
  URI = 'http://www.newnownext.com/gay-celebrities-coming-out-2016/10/2016/'.freeze

  def parse(redis)
    page = @agent.get URI
    index = 0
    loop do
      name = page.search('.heading')[index].text
      status = page.search('.description-container')[index]
      break if status.nil? || name == ''
      redis.set(name, status.text)
      index += 1
    end
  end
end
