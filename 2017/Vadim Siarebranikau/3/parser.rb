require 'mechanize'
class Parser
  def initialize
    @coming = Array.new
  end

def get_out
  agent = Mechanize.new
  url = 'http://www.imdb.com/list/ls072706884/?start=1&view=detail&sort=lis'\
         'torian:asc&scb=0.9953551686721389'
  pars(agent.get(url))
  @coming
end

def pars (page)
  page.css('.info b a').each do |x|
    @coming << x.text
  end
end

def search (a)
  get_out
  if @coming.include?(a) == true
    'Да'
  else
    'Нет информации'
  end
end
end
