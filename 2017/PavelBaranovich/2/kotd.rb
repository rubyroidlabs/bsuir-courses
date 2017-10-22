require_relative 'battle_parser'
require_relative 'text_handler'

inf = BattleParser.new
inf.parse

kotd = TextHandler.new(inf.battles_links, inf.left_mc_name, inf.right_mc_name)
kotd.name = ENV['NAME']
kotd.criteria = ENV['CRITERIA']

kotd.get_answer