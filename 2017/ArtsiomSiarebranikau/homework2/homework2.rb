load 'battle.rb'

ENV['NAME'] = '' if ENV['NAME'].nil?
ENV['CRITERIA'] = '' if ENV['CRITERIA'].nil?+
Battle.new.parse(ENV['NAME'], ENV['CRITERIA'])