require 'rubygems'
require 'mechanize'
require 'pry'

class Parser
  def get_links
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/King-of-the-dot')
    f_page = page.link_with(text: /Show all songs by King of the Dot/).click
    links = f_page.links_with(href: %r{https:\/\/genius\.com\/King-of-the-dot})
    link_songs = "\/artists\/songs\?for_artist_page=117146&"
    link_battle = "id=King-of-the-dot&page=\d+&pagination=true"
    pages = f_page.links_with(href: /#{link_songs}#{link_battle}/)
    pages.pop
    link_song = "https:\/\/genius\.com\/King-of-the-dot"
    pages.each do |n|
      n.click.links_with(href: /#{link_song}/).each { |p| links << p }
    end
    links
  end

  def get_data
    links = get_links
    data = []
    links.each do |l|
      page_of_battle = l.click
      class_css = '.header_with_cover_art-primary_info-title'
      name_of_battle = page_of_battle.search(class_css).text
      href = l.href
      text_of_battle = page_of_battle.search('.lyrics').text
      battle_data = { name: name_of_battle, href: href, text: text_of_battle }
      data << battle_data
    end
    data
  end
end
