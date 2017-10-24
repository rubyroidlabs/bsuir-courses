class Parse
  def self.get_battle_page(link)
    page = link.click
    page.links_with(text: /vs/)
  end

  def self.get_battles(pagination, ajax_list)
    battles = []
    battles << ajax_list.links_with(text: /vs/)
    Multithread.get_pagination_pages(pagination, battles)
    battles
  end

  def self.comparing_position(mc_title)
    position = if mc_title.first.size <= 2 || mc_title.last.size <= 2
                 2
               else
                 3
               end
    position
  end

  def self.results_calculating(battle_text, mc_title, regexp)
    position = comparing_position(mc_title)
    result = { mc_title.first.to_s => 0, mc_title.last.to_s => 0 }
    battle_text.each do |elem|
      if mc_title.first.include? elem.lstrip[0...position]
        result[mc_title.first.to_s] += elem.scan(regexp).size
      elsif mc_title.last.include? elem.lstrip[0...position]
        result[mc_title.last.to_s]  += elem.scan(regexp).size
      end
    end
    result
  end

  def self.get_result(link)
    battle_page = link.click
    mc_title    = get_title(battle_page)
    battle_text = get_text(battle_page)
    regexp = /[a-zA-Z]/
    unless ENV['CRITERIA'].nil?
      regexp = /#{ENV['CRITERIA']}|#{ENV['CRITERIA'].capitalize}/
    end
    result = results_calculating(battle_text, mc_title, regexp)
    result
  end

  def self.main_parse(home_page)
    ajax_list  = home_page.link_with(text: /Show all songs by/).click
    pagination = ajax_list.links_with(href: /pagination/, text: /\d/)
    get_battles(pagination, ajax_list).flatten
  end

  def self.get_title(battle_page)
    titles = battle_page.parser
    titles = titles.css('.header_with_cover_art-primary_info-title')
    titles = titles.text.split(/ vs | vs. /)
    titles[-1] = titles.last.gsub(/(\(Title Match\))|(\(\d\))/, '')
    titles
  end

  def self.get_text(battle_page)
    battle_text = battle_page.parser.css('.lyrics').text
    battle_text = battle_text.split(/Round \d:|Verse \d:|Round \d|ROUND \d|OT:/)
    battle_text[1..-1]
  end
end
