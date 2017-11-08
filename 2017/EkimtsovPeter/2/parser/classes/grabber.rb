# Taking all links to hash
class Grabber
  BATTLES_PAGE_URL = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot'.freeze

  def initialize
    @test = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @page = @test.get(BATTLES_PAGE_URL)
    @links = {}
  end

  def grab
    first_page_links = @page.links_with(class: /song_name/)
    pages_links = @page.links_with(href: /page=117146&id=King-of-the-dot&page=/)
    pages_links.pop
    first_page_links_text(first_page_links)
    other_page_links_text(pages_links)
  end

  private

  def first_page_links_text(links)
    links.each do |link|
      @links[link.text.strip.gsub(/ \(+.+/, '')] = link.href
    end
  end

  def other_page_links_text(links)
    links.map do |link|
      page = link.click
      links = page.links_with(class: /song_name/)
      links.each do |link_info|
        @links[link_info.text.strip.gsub(/ \(+.+/, '')] = link_info.href
      end
    end
    @links
  end
end
