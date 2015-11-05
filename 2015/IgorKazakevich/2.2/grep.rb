require 'slop'
require 'zip'

require_relative './explorer_route.rb'
require_relative './parser.rb'

parser = Parser.new
parser.parse

explorer = ExplorerRoute.new(parser.opt_a, parser.opt_e,
  parser.array, parser.find_text)
puts explorer.find
