class Parse

  def self.get_battle_page(link)
    page = link.click
    page.links_with(:text => /vs/)
  end

  def self.get_battles(pagination, ajax_list)
    battles = []
    battles << ajax_list.links_with(:text => /vs/)
    Multithread.get_pagination_pages(pagination, battles)
    battles
  end

  def self.get_result(link)
    battle_page = link.click
    mc_title    = get_title(battle_page)
    battle_text = get_text(battle_page)
    result = {"#{mc_title.first}" => 0, "#{mc_title.last}" => 0}
    regexp = /[a-zA-Z]/
    if !ENV["CRITERIA"].nil?
      regexp = /#{ENV['CRITERIA']}|#{ENV['CRITERIA'].capitalize}/
    end
    battle_text.each_with_index do |elem, i|
      if mc_title.first.include? elem.lstrip[0..1]
        result["#{mc_title.first}"] += elem.scan(regexp).size
      elsif mc_title.last.include? elem.lstrip[0..1]
        result["#{mc_title.last}"]  += elem.scan(regexp).size
      end
    end
    result
  end

  def self.main_parse(home_page)
    ajax_list  = home_page.link_with(:text => /Show all songs by/).click
    pagination = ajax_list.links_with(:href => /pagination/, :text => /\d/)
    get_battles(pagination, ajax_list).flatten
  end

  private

    def self.get_title(battle_page)
      titles = battle_page.parser.css('.header_with_cover_art-primary_info-title').text.split(/ vs | vs. /)
      titles[-1] = titles.last.gsub(/(\(Title Match\))|(\(\d\))/, "")
      titles
    end

    def self.get_text(battle_page)
      battle_text = battle_page.parser.css('.lyrics').text.split(/Round \d:|Verse \d:|Round \d|ROUND \d/)
      battle_text[1..-1]
    end
end
