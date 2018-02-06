require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'pry'
require 'date'
require 'json'

class KODT

  def initialize
    @a = Mechanize.new { |agent1| agent1.user_agent_alias = 'Mac Safari' }
    @main_link_list = 'https://genius.com/artists/songs'
    @author_link = 'https://genius.com/King-of-the-dot-'
    @author_full_link = String
    @battle_page = ''
    @text = ''
    @list_of_songs = []
    @page_number = 0
    @battle_number = 0
  end

  def pages
    for i in 1..12 do
      @page_number +=1
        @a.get("https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=#{@page_number}&pagination=true") do |page|
        review_links = page.css('div#container.mecha--deprecated div#main ul li a.song_name.work_in_progress.song_link span.title_with_artists span.song_title').each do |link|
          @list_of_songs << link.text
        end
        @list_of_songs.each do |link|
          @battle_number +=1
          @author_full_link = @author_link + link.gsub!(' ','-') +'-lyrics'
          @battle_page = @a.get(@author_full_link).content
          temp = @battle_page.text
          binding.pry
        end
      end
    end
  end
end

start = KODT.new.pages

