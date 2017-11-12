require 'mechanize'
class Parser
  def initialize(name, orientation = 'heterosexual')
    @name = name
    @orientation = orientation
    @url = ''
    @info = ''
  end

  def search_in_imdb
    agent = Mechanize.new
    page = agent.get('http://www.imdb.com/list/ls072706884/')
    if page.link_with(text: @name)
      return true
    end
  end

  def search_in_gay_actors
    agent = Mechanize.new
    page = agent.get('https://en.wikipedia.org/wiki/Category:Gay_actors')
    array_name = @name.split
    link = page.link_with(text: array_name.last[0].upcase)
    page = link.click
    if page.link_with(text: @name)
      page = page.link_with(text: @name).click
      @url = page.uri
      @orientation = 'Gay'
      return true
    end
  end

  def search_in_bisexual_actors
    agent = Mechanize.new
    page = agent.get('https://en.wikipedia.org/wiki/Category:Bisexual_actresses')
    if page.link_with(text: @name)
      page = page.link_with(text: @name).click
      @url = page.uri
      @orientation = 'Bisexual'
      return true
    end
  end

  def search_in_lesbian_actors
    agent = Mechanize.new
    page = agent.get('https://en.wikipedia.org/wiki/Category:Lesbian_actresses')
    if page.link_with(text: @name)
      page = page.link_with(text: @name).click
      @url = page.uri
      @orientation = 'Lesbian'
      return true
    end
  end

  def print
    "Hmm. According to my information, #{@name} is #{@orientation}.\n
    Here is a link to the Wiki: #{@url}"
  end
end
