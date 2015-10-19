require_relative './Parameter.rb'
require_relative './Connection.rb'
require_relative './Filter.rb'
require_relative './Version.rb'
require_relative './Print.rb'

parameter = Parameter.new(ARGV)
parameter_search = parameter.getParameter
version_search = parameter.getGemVersion

connection = Connection.new(parameter.getAddress)

filter = Filter.new(connection.getData, parameter.getGemVersion)
filter.parseData

version = Version.new(filter.getFilterData, version_search, parameter_search)
version.find

print = Print.new(filter.getFilterData, version.getFindVersions)
print.printVersions
