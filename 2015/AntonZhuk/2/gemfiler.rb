require_relative('parser.rb')
require_relative('filter.rb')
require_relative('print.rb')

parser = Parser.new
parser.parse_options
gem_name, requirement1, requirement2 = parser.cli_arguments
parser.set_name(gem_name)

param1, version1 = Gem::Requirement:: parse(requirement1)
param2, version2 = Gem::Requirement:: parse(requirement2)

parser.connect

filter = Filter.new(parser.get_versions)

Print.new(filter.filter_data(param1, version1, param2, version2),
          parser.get_versions)
