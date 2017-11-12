require 'mechanize'
require 'json'
require_relative 'Parser'

class NNNParser < Parser
  def parse_site(link, celeb)
    page = @agent.get(link)
    list = page.css('ol')
    items = list.css('li')
    items.each do |i|
      name = i.css('.heading').text
      info = i.css('p')[0].text
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
