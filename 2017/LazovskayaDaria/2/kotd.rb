require 'pry'
require 'mechanize'
require 'json'
require_relative 'battles.rb'

class Site_parsing


  def get_data(name = nil, criteria = nil)

    agent = Mechanize.new
    next_page = 1
    battles = Battles.new(name)
    
      request = 'https://genius.com/api/artists/117146/'
      request += if name
                   "songs/search?page=#{next_page}&q=#{name}&sort=title"
                 else
                   "songs?page=#{next_page}&sort=title"
                 end
      respond = agent.get(request).content 
      respond = JSON.parse(respond)
      song_list = respond['response']['songs'].uniq
      song_list.each do |song|
        song_page = agent.get(song['url'])
        song_text = song_page.search('.lyrics p').text


    rap_content = {}
        rap_content[:title] = song['title']
        rap_content[:link] = song['url']
        rap_content[:full_text] = song_text
        rap_content[:criteria] = criteria
    battles.process(rap_content)
      end



      next_page = respond['response']['next_page']
   
    
    battles.result if name
  end
end
name = ENV['NAME']
criteria = ENV['CRITERIA']
Site_parsing.new.get_data(name, criteria)
