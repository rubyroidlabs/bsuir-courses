require 'rubygems'
require 'mechanize'
class Names
  def load_names
    agent = Mechanize.new
    source = 'http://www.imdb.com/list/ls072706884/' 
    agent.get(source)
    faamous = agent.page.css('b').to_s.gsub(/<[^<^>]+>/) { '_' }
    faamous = faamous.gsub(/^_+/) { '' }
    faamous = faamous.gsub(/_+$/) { '' }
    faamous = faamous.gsub(/_+/) { '|' }
    faamous = faamous.split('|')
    return faamous
  end
end
