require 'mechanize'
require 'json'

require './song'

class KODTScraper
  KODT_URI = 'https://genius.com/artists/King-of-the-dot'.freeze
  SONGS_URI = '/artists/songs?for_artist_page=117146&id=King-of-the-dot'.freeze

  def self.scrape_songs
    page = all_songs_page
    href_reg_exp = %r{https://genius.com/King-of-the-dot-.+-lyrics}
    songs_links = page.links_with(href: href_reg_exp)
    songs_links.each do |link|
      yield scrape_song link.click
    end
  end

  def self.scrape_songs_api(name)
    agent = Mechanize.new
    page_number = 1
    until page_number.nil?
      json_response = agent.get api_url page_number
      response = JSON.parse(json_response.body)['response']
      response['songs'].each do |song|
        if name
          yield scrape_song agent.get song['url'] if song['title'].include? name
        else
          yield scrape_song agent.get song['url']
        end
      end
      page_number = response['next_page']
    end
  end

  private_class_method

  def self.api_url(page_number)
    "https://genius.com/api/artists/117146/songs?page=#{page_number}&sort"
  end

  def self.all_songs_page
    agent = Mechanize.new
    page = agent.get KODT_URI
    all_songs_link = page.links_with(href: SONGS_URI)[0]
    all_songs_link.click
  end

  def self.process_lyrics(song)
    song.gsub(/<.+>/, '')
  end

  def self.process_name(name)
    name[0..-7]
  end

  def self.scrape_song(page)
    song_name = process_name page.at('h2.text_label').text
    song_name.gsub! '(Title Match)', ''
    lyrics = process_lyrics page.at('.lyrics p').text
    Song.new(song_name.gsub(/[[:space:]]+$/, ''), page.uri, lyrics)
  end
end
