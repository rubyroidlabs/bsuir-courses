require 'rubygems'
require 'json'
require 'mechanize'
require 'pry'
require 'colorize'

# Battle text for duelers
class BattlesParser
  FLANKS = %w[left right]

  attr_reader :song_urls, :agent, :left_mc, :right_mc

  def initialize(agent, song_urls)
    @agent = agent
    @song_urls = song_urls
    @left_mc = BattleMc.new
    @right_mc = BattleMc.new
  end

  def parse_battles
    battles = []
    song_urls.each do |link|
      page_save = agent.get(link)
      title = page_save.search('//div//h1//text()').to_html
      result_text = page_save.search("//div[@class='lyrics']//p//text()")
                             .to_html.split(/\[.*\]/).drop(1)
      FLANKS.each { |flank| create_battle_mc(flank, result_text, title) }
      battles << BattleInfo.new(left_mc, right_mc, title, link)
    end
    battles
  end

  def create_battle_mc(flank, result_text, title)
    case flank
    when 'left'
      left_mc.flank = 'left'
      left_mc.name = title.split(/\svs\.?\s/i).first
      left_mc.text = result_text.select.with_index { |_val, index| index.even? }
    when 'right'
      right_mc.flank = 'right'
      right_mc.name = title.split(/\svs\.?\s/i).last
      right_mc.text = result_text.select.with_index { |_val, index| index.odd? }
    end
  end
end
