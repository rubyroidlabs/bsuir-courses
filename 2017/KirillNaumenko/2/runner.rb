
require_relative 'battles_parser.rb'
require_relative 'battle_info.rb'
require_relative 'battle_mc.rb'
require_relative 'pretty_printer.rb'

song_urls = []

agent = Mechanize.new

page_number = 1
loop do
  page = agent.get("https://genius.com/\
  api/artists/117146/songs?page=#{page_number}&sort=popularity").body
  page_json = JSON(page, symbolize_names: true)
  page_json[:response][:songs].each do |song|
    song_urls << song[:url]
  end
  page_number = page_json[:response][:next_page]
  break unless page_number
end

battle_parser = BattlesParser.new(agent, song_urls)
battles = battle_parser.parse_battles
PrettyPrinter.new.print_info(battles)
