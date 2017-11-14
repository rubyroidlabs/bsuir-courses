require 'rubygems'
require 'mechanize'
class Names
  def self.load_names
    agent = Mechanize.new
    source = 'http://www.imdb.com/list/ls072706884/' 
    agent.get(source)
    famous = agent.page.css('b').to_s.gsub(/<[^<^>]+>/) { '_' }
    famous = famous.gsub(/^_+/) { '' }
    famous = famous.gsub(/_+$/) { '' }
    famous = famous.gsub(/_+/) { '|' }
    famous = famous.split('|')
    return famous
  end
end
