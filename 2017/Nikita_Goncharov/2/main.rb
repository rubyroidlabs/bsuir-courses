require 'mechanize'
require_relative 'parser'
parser = Parser.new
begin
  parser.run
rescue Interrupt
  puts 'Early termination of work'
end
