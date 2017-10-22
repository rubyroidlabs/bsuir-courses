require 'mechanize'

class BattleParser
  attr_reader :battles_links, :left_mc_name, :right_mc_name

  def initialize
    @battles_links = []
    @left_mc_name = []
    @right_mc_name = []
  end

  def get_links(page_link)
    agent = Mechanize.new
    page = agent.get(page_link)

    page.links.each do |link|
      link = link.href.to_s
      next unless link =~ /lyrics$/

      next if link =~ /kotd/

      @battles_links.push(link)
    end
  end

  def get_names
    agent = Mechanize.new

    threads = []
    @battles_links.count.times do |i|
      threads << Thread.new(i) do |j|
        battle_title = agent.get(battles_links[j]).search('h1.header' \
                              '_with_cover_art-primary_info-title').text

        pos = battle_title.index('(')
        battle_title = battle_title[0, pos - 1] unless pos.nil?

        names = battle_title.split(/ [Vv]s.? /)
        @left_mc_name[j] = names[0]
        @right_mc_name[j] = names[1]
      end
    end
    threads.each(&:join)
  end

  def parse
    threads = []
    12.times do |i|
      threads << Thread.new(i) do |j|
        page_link = 'https://genius.com/artists/songs?for_artist_page=' \
            "117146&id=King-of-the-dot&page=#{j + 1}&pagination=true"
        get_links(page_link)
      end
    end
    threads.each(&:join)

    get_names
  end
end
