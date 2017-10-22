# Taking all links to hash
class Linker
  def initialize
    @test = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @page = ''
    @hsh_links = {}
  end

  def page_get
    @page = @test.get('https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot')
  end

  def arr_links
    first_page_links = @page.links_with(class: /song_name/)
    page_links = @page.links_with(href: /page=117146&id=King-of-the-dot&page=/)
    page_links.pop
    hsh_first_page(first_page_links)
    hsh_other_page(page_links)
  end

  def hsh_first_page(arr_first)
    arr_first.each do |link|
      @hsh_links[link.text.strip.gsub(/ \(+.+/, '')] = link.href
    end
  end

  def hsh_other_page(arr_other)
    arr_other.map do |link|
      page = link.click
      links = page.links_with(class: /song_name/)
      links.each do |link_info|
        @hsh_links[link_info.text.strip.gsub(/ \(+.+/, '')] = link_info.href
      end
    end
    @hsh_links
  end
end
