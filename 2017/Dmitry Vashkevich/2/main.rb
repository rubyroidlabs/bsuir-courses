require_relative 'kotd'

name = ENV['NAME']
criterion = ENV['CRITERIA']

kotd = Kotd.new
kotd.loading_battles(criterion)
kotd.show_battles(name)
# end
