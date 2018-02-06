require 'mechanize'
require_relative 'battles_parser'
require_relative 'site_navigation'

battler_name = ENV['NAME']
text_criteria = ENV['CRITERIA']

site = SiteNavigation.new
battle_parser = BattlesParser.new
required_battler = Battler.new

if battler_name
  required_battler.name = battler_name.tr('_', ' ')
end

site.battles_search battle_parser, text_criteria, required_battler