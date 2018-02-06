require 'rubygems'
require 'mechanize'
require 'pry'

class Parser
  LINK_MAIN = 'https://genius.com/artists/King-of-the-dot'.freeze
  LINK_ALL_SONGS = 'Show all songs by King of the Dot'.freeze
  LINK_BATTLE = 'https:\/\/genius\.com\/King-of-the-dot'.freeze
  LINK_SONGS = '\/artists\/songs\?for_artist_page=117146&'.freeze
  LINK_PAGES = 'id=King-of-the-dot&page=\d+&pagination=true'.freeze
  CLASS_CSS = '.header_with_cover_art-primary_info-title'.freeze

  def get_links
    agent = Mechanize.new
    page = agent.get(LINK_MAIN)
    f_page = page.link_with(text: /#{LINK_ALL_SONGS}/).click
    links = f_page.links_with(href: /#{LINK_BATTLE}/)
    pages = f_page.links_with(href: /#{LINK_SONGS}#{LINK_PAGES}/)
    pages.pop
    pages.each do |n|
      n.click.links_with(href: /#{LINK_BATTLE}/).each { |p| links << p }
    end
    links
  end

  def get_data
    links = get_links
    data = []
    links.each do |l|
      page_of_battle = l.click
      name_of_battle = page_of_battle.search(CLASS_CSS).text
      href = l.href
      text_of_battle = page_of_battle.search('.lyrics').text
      battle_data = { name: name_of_battle, href: href, text: text_of_battle }
      data << battle_data
    end
    data
  end
end
