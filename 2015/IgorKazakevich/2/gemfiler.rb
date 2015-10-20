require_relative './Parameter.rb'
require_relative './Connection.rb'
require_relative './Filter.rb'
require_relative './Version.rb'
require_relative './Print.rb'

parameter = Parameter.new(ARGV)
parameter_search = parameter.get_parameter
version_search = parameter.get_gem_version

connection = Connection.new(parameter.get_address)

filter = Filter.new(connection.get_data, version_search)
filter.parse_data

version = Version.new(filter.get_filter_data, version_search, parameter_search)
version.find

print = Print.new(filter.get_filter_data, version.get_find_versions)
print.print_versions
