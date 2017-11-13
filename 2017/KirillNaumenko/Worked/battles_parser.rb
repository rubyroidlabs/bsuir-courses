require 'rubygems'
require 'json'
require 'mechanize'
require 'pry'

class BattlesParser
  FLANKS = %w[left right].freeze

  attr_reader :song_urls, :agent
  attr_accessor :left_mc, :right_mc

  def initialize(agent, song_urls)
    @agent = agent
    @song_urls = song_urls
  end

  def parse_battles
    battles = []
    song_urls.each do |link|
      page_save = agent.get(link)
      title = page_save.search('//div//h1//text()').to_html
      result_text = page_save.search("//div[@class='lyrics']//p//text()")
                             .to_html.split(/\[.*\]/).drop(1)
      FLANKS.each { |flank| create_battle_mc(title, result_text, flank) }
      battles << BattleInfo.new(left_mc, right_mc, title, link)
    end
    battles
  end

  def create_battle_mc(title, result_text, flank)
    case flank
    when 'left'
      @left_mc = BattleMc.new.left_mc(title, result_text, flank)
    when 'right'
      @right_mc = BattleMc.new.right_mc(title, result_text, flank)
    end
  end
end
