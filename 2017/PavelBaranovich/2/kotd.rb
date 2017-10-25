require_relative 'battle_parser'
require_relative 'text_handler'

parse_info = BattleParser.new
parse_info.parse

kotd = TextHandler.new(parse_info.battles_links,
                       parse_info.left_mc_name,
                       parse_info.right_mc_name)

kotd.name = ENV['NAME']
kotd.criteria = ENV['CRITERIA']

kotd.get_answer
