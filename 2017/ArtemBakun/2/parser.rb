require 'mechanize'

class Parser
  attr_reader :b_links, :mc_left, :mc_right

  def initialize
    @b_links = []
    @mc_left = []
    @mc_right = []
  end

  def get_link(page)
    page.links.each do |link|
      l = link.href
      next unless l =~ /lyrics$/
      next if l =~ /kotd/
      @b_links.push(l)
    end
  end

  def parser
    agent = Mechanize.new
    threads = []
    12.times do |i|
      threads << Thread.new(i) do |j|
        page = agent.get('https://genius.com/artists/songs?for_artist_page=' \
          "117146&id=King-of-the-dot&page=#{j + 1}&pagination=true")
        get_link(page)
      end
    end
    threads.each(&:join)

    get_name_battle
  end

  def get_name_battle
    agent = Mechanize.new
    @b_links.count.times do |i|
      page = agent.get(b_links[i])
      class_css = '.header_with_cover_art-primary_info-title'
      name_of_battle = page.search(class_css).text
      i = if name_of_battle.include?('(')
            name_of_battle.index('(') - 1
          else
            name_of_battle.length - 1
          end
      get_name(name_of_battle[0..i])
    end
  end

  def get_name(name_of_battle)
    names = name_of_battle.split(/ [Vv]s.? /)
    @mc_right.push(names[1])
    @mc_left.push(names[0])
  end
end
