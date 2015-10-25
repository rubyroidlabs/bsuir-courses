require_relative './parameter_parser.rb'
require_relative './version.rb'
require_relative './print.rb'

parser = ParameterParser.new()
parser.parse

version = Version.new(parser.instance_variable_get(:@filter_data),
  parser.instance_variable_get(:@requirements))
version.find

print = Print.new(parser.instance_variable_get(:@filter_data),
  version.instance_variable_get(:@find_versions))
print.print_versions
