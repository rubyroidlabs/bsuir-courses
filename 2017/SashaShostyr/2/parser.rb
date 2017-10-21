require 'rubygems'
require 'mechanize'
require 'pry'

class Parser
  def get_links
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/King-of-the-dot')
    first_page = page.link_with(text: "\n              Show all songs by King of the Dot\n            ").click
    links = first_page.links_with(href: %r{https:\/\/genius\.com\/King-of-the-dot})
    all_pages = first_page.links_with(href: %r{\/artists\/songs\?for_artist_page=117146&id=King-of-the-dot&page=\d+&pagination=true})
    all_pages.pop
    all_pages.each do |next_page|
      next_page.click.links_with(href: %r{https:\/\/genius\.com\/King-of-the-dot}).each { |p| links << p }
    end
    links
  end

  def get_data
    links = get_links
    data = []
    links.each do |l|
      page_of_battle = l.click
      name_of_battle = page_of_battle.search('.header_with_cover_art-primary_info-title').text
      href = l.href
      text_of_battle = page_of_battle.search('.lyrics').text
      battle_data = { name: name_of_battle, href: href, text: text_of_battle }
      data << battle_data
    end
    data
  end
end
