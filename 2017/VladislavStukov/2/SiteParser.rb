require 'mechanize'
require 'json'
require_relative 'RapParser'

class SiteParser
  def start(name = nil, criteria = nil)
    agent = Mechanize.new
    next_page = 1
    rap_parser = RapParser.new(name)
    loop do
      request = 'https://genius.com/api/artists/117146/'
      request += if name
                   "songs/search?page=#{next_page}&q=#{name}&sort=title"
                 else
                   "songs?page=#{next_page}&sort=title"
                 end
      respond = agent.get(request).content # download json and convert to string
      respond = JSON.parse(respond)
      song_list = respond['response']['songs'].uniq
      song_list.each do |song|
        song_page = agent.get(song['url'])
        song_text = song_page.search('.lyrics p').text
        rap_params = {}
        rap_params[:title] = song['title']
        rap_params[:link] = song['url']
        rap_params[:full_text] = song_text
        rap_params[:criteria] = criteria
        rap_parser.process(rap_params)
      end
      next_page = respond['response']['next_page']
      break unless next_page # check last page
    end
    rap_parser.print_statistic
  end
end