require 'mechanize'
require 'json'

# Parser
class Parser
  def initialize
    @coming_out = {}
  end

  def info
    agent = Mechanize.new
    url1 = 'http://www.imdb.com/list/ls072706884'
    url2 = 'http://www.newnownext.com/gay-celebrities-coming-out-2016/10/2016/'
    url3 = 'http://www.newnownext.com/gay-celebrities-coming-out-2017/10/2017/'
    parser_first(agent.get(url1))
    parser_second(agent.get(url2))
    parser_second(agent.get(url3))
    save_info('list.json')
  end

  def save_info(fname)
    File.open(fname, 'w') do |file|
      file.write @coming_out.to_json
    end
  end

  def parser_first(page)
    review_links = page.search('.list')
    review_links.each do |l|
      actors = l.search('.list_item')
      actors.each do |link|
        actor_info = link.search('.info')
        actor_name = actor_info.search('b')
        description = link.search('.description')
        orientation = description.text.split(' ').first.delete!('“ ')
        orientation.delete(' ”')
        @coming_out[actor_name.text.upcase!] = orientation
      end
    end
  end

  def parser_second(page)
    review_links = page.search('.listicle-container')
    review_links.each do |l|
      p = l.search('li')
      p.each do |link|
        actors = link.search('.heading-container')
        info = link.search('.description-container')
        actor_name = actors.text.delete! "\n\t\t\t\t\t", "\n\t\t\t\t"
        actor_name.upcase!
        actor_info = info.text.delete! "\n\t\t\t\t\t", "\n\t\t\t\t"
        @coming_out[actor_name] = actor_info
      end
    end
  end
end
