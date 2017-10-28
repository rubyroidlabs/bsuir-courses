require_relative('fight.rb')

name = ENV['NAME']
criteria = ENV['CRITERIA']

# name = 'lyrics' unless name
Fight.new.start(name, criteria)

# if name.nil?
#   name = 'lyrics'
#   Fight.new.start_fights(name, criteria)
# else
#   Fight.new.start_fight(name, criteria)
# end
