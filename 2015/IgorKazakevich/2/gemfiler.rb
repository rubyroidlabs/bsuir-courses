require_relative './parameter_parser.rb'
require_relative './version.rb'
require_relative './print.rb'

parser = ParameterParser.new
parser.parse
filter_data = parser.instance_variable_get(:@filter_data)
requirements = parser.instance_variable_get(:@requirements)

version = Version.new(filter_data, requirements)
version.find

print = Print.new(filter_data, version.instance_variable_get(:@find_versions))
print.print_versions
