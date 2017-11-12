require 'mechanize'
require 'json'
require_relative 'Parser'

class DailyNewsParser < Parser
  def parse_site(link, celeb)
    page = @agent.get(link)
    loop do
      name = page.search('#rgs-title').text.strip
      info = page.search('#rgs-caption').text.strip
      p name, info
      if celeb.key?(name) && celeb[name].size > 8
        celeb[name] += ".#{info}"
      else
        celeb[name] = info
      end
      next_page = page.links_with(id: 'rgs-next')[0]
      break if name == 'Evan Rachel Wood'
      page = next_page.click
    end
    celeb
  end
end
