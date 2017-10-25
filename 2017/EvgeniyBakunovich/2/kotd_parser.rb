require 'mechanize'
require_relative 'checker'
class KotDparser
  attr_accessor :link

  def initialize(link)
    @link = link
  end

  def parse_links
    agent = Mechanize.new
    page = agent.get(@link)
    links = {}
    loop do
      page.links_with(href: /-vs-/).each do |link|
        temp_page = agent.get(link.href)
        str_title = temp_page.title
        str_title.slice!(0...18)
        str_title = str_title.slice!(0...str_title.size - 23)
        links.store(str_title, link.href)
      end
      break if page.link_with(text: /Next/).class == nil.class
      page_link = page.link_with(text: /Next/)
      page = page_link.click
    end
    links
  end

  def show
    links = parse_links
    links.each do |key, value|
      battler = Checker.new(key, value)
      battler.get_winner
    end
  end
end
object = KotDparser.new('https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot')
object.show
