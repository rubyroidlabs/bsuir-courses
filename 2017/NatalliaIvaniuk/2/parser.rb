require 'mechanize'

class Parser
  def receive_links
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot')
    href_reg_exp = %r{https://genius.com/King-of-the-dot-.+-lyrics}
    page.links_with(href: /#{href_reg_exp}/)
  end

  def receive_text
    links = receive_links
    songs = []
    links.each do |link|
      song = link.click
      href = link.href
      title = song.search('.header_with_cover_art-primary_info-title').text
      text = song.search('.lyrics').text
      songs << { href: href, title: title, text: text }
    end
    songs
  end
end
