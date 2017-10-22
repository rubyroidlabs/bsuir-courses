require 'mechanize'

# class-parser for get information from web-site
class Parser
  def initialize
    @agent = Mechanize.new
    @main_page = @agent.get('https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot')
  end

  def search_battle_links
    links = []
    link_number = 2
    loop do
      lien = @main_page.link_with(text: link_number.to_s)
      link_number += 1
      if ENV['NAME'].nil?
        links += @agent.page.links_with(href: /lyrics/)
      else
        links += @agent.page.links_with(text: /#{ENV['NAME']}/)
      end
      break unless lien
      @main_page = lien.click
    end
      links
  end

  def get_battle_data
    battle_data = []
    battle_links = search_battle_links
    battle_links.each do |link|
      page_of_battle = link.click
      name_of_battle = link.text.split('(')[0].to_s.strip
      href = link.href
      text_of_battle = page_of_battle.search('.lyrics').text
      data = { name: name_of_battle, url: href, text: text_of_battle }
      battle_data << data
    end
    battle_data
  end
end
