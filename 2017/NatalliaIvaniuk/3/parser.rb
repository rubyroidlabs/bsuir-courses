require 'mechanize'

class Parser
  def receive_data
    agent = Mechanize.new
    page = agent.get('http://www.imdb.com/list/ls072706884/')
    actors = []
    page.search('.info b').each do |link|
      actor = link.text
      actors << actor
    end
    actors
  end
end
