require_relative('fight.rb')

name = ENV['NAME']
criteria = ENV['CRITERIA']

Fight.new.start(name, criteria)
