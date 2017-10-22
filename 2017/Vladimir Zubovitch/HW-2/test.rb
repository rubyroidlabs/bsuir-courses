require 'rubygems'
require 'mechanize'

class Obhod 
def initialize 
  @page = 1
end 
def reload 
  agent = Mechanize.new
  @page_text=[]
  source = "https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=#{@page}&pagination=true"
  agent.get(source)
  page = agent.page.links_with(:dom_class => 'song_name work_in_progress   song_link') 
  page.each do |link|
    @page_text << link.click.css('p').to_s.gsub(/<[^<^>]{0,}>/){''}
  end 
  @page+=1
  return @page_text
end
end 
