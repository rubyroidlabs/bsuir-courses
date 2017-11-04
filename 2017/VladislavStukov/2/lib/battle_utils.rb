require 'mechanize'
require 'json'
require_relative 'battle'
require 'uri'

class BattleUtils
  HOST = 'www.genius.com'.freeze
  DEF_PATH = '/api/artists/117146/songs'.freeze
  def self.get_battle_by(name = nil)
    agent = Mechanize.new
    next_page = 1
    loop do
      query = if name
                path = URI.join(DEF_PATH, '/search')
                { page: next_page, q: name, sort: 'title' }
              else
                path = DEF_PATH
                { page: next_page, sort: 'title' }
              end
      request = { host: HOST, path: path, query: URI.encode_www_form(query) }
      request = URI::HTTPS.build(request)
      respond = agent.get(request).content # download json and convert to string
      respond = JSON.parse(respond)
      battle_list = respond['response']['songs'].uniq
      battle_list.each do |battle|
        title = battle['title'] # creating battle object for yield
        url = battle['url']
        page = agent.get(url)
        text = page.search('.lyrics p').text
        yield Battle.new(title, url, text)
      end
      next_page = respond['response']['next_page']
      break unless next_page
    end
  end
end
