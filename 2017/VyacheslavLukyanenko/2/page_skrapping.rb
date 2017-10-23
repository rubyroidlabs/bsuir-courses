require 'mechanize'
require 'date'
require 'json'
require_relative 'text_parsing'

class RapPlayground
  def initialize; end

  def load_battles_links(criteria, name)
    a = Mechanize.new { |agent| agent.user_agent_alias = 'Linux Firefox' }
    page = a.get('https://genius.com/artists/King-of-the-dot')
    text = 'Show all albums by King of the Dot'
    albums_page = a.click(page.link_with(text: /#{text}/))
    link_albums = '/albums/King-of-the-dot/'
    albums_page.links_with(href: /#{link_albums}/).each do |page_album|
      page_battles = a.get(page_album.href)
      link_bat = '/King-of-the-dot-'
      page_battles.links_with(href: /#{link_bat}/).each do |page_battle|
        new_battle(a.get(page_battle.href), criteria, name)
      end
    end
  end

  def new_battle(link_for_battle, criteria, name)
    text_parser = Text_parserr.new(link_for_battle)
    text_parser.parse_n_choose(criteria, name)
  end
end
