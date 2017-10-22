require 'rubygems'
require 'mechanize'
class parse 
  def site (name=nil )
    agent=Mechanize.new
    page=1
    loop do
      if name 
        source="https://genius.com/api/artists/117146/songs/search?page=#{page}&q=#{name}&sort=popularity"    
      else         
        source="https://genius.com/api/artists/117146/songs?page=#{page}&sort=popularity"
      end
      site=agent.source.link_with(:text =>  
    end 
  end     
