load 'wik.rb'
ENV['NAME'] = '' if ENV['NAME'].nil?
Task.new.parse(ENV['NAME'])
