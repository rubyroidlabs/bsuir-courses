require 'mechanize'
require 'json'
require_relative 'Parser'

class ImdbParser < Parser
  def parse_site(link, celeb)
    page = @agent.get(link)
    items = page.css('.list_item')
    items.each do |i|
      name = i.search('.info b a').text
      info = i.search('.description').text.scan(/“+.+”/).join.slice(2...-2)
      puts name, info
      if celeb.key?(name)
        celeb[name] += ".#{info}"
      else
        celeb[name] = info
      end
    end
    celeb
  end
end
