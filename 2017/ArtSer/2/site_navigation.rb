require_relative 'battler'
class SiteNavigation
  START_PAGE = 'https://genius.com/artists/King-of-the-dot'.freeze
  FULL_BATTLES_LIST_BUTTON = 'full_width_button'.freeze
  NEXT_PAGE_BUTTON = 'next_page'.freeze
  BATTLE_IDENTIFIER = 'song_name work_in_progress   song_link'.freeze

  def initialize
    asd = Mechanize.new
    @base_page = asd.get START_PAGE
  end

  def battles_search(battle_parser, text_criteria, required_battler)
    current_page = @base_page.link_with(class: FULL_BATTLES_LIST_BUTTON).click

    loop do
      links_to_battles = current_page.links_with(class: BATTLE_IDENTIFIER)
      battle_parser.parser links_to_battles, text_criteria, required_battler
      current_page = current_page.link_with(class: NEXT_PAGE_BUTTON)
      if current_page
        current_page = current_page.click
      else
        break
      end
    end
    unless required_battler.name.empty?
      battler_statistics required_battler
    end
  end

  def battler_statistics(required_battler)
    puts '===STATISTICS==='
    puts "Name: #{required_battler.name}"
    puts "Wins: #{required_battler.count_of_wins}\n"
    puts "Defeats: #{required_battler.count_of_defeat}"
    true
  end
end
