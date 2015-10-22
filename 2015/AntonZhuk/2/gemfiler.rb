require_relative('parse.rb')
require_relative('filter.rb')
require_relative('print.rb')
require_relative('console_parser')

#Осторожно! Может пойти кровь из глаз! Мне рально стыдно
str = ConsoleParser.new
str.parse_options
name, param, version, param2, version2 = str.cli_arguments
version = param.to_s.split.last
param = param.to_s.split.first
version2 = param2.to_s.split.last
param2 = param2.to_s.split.first

parse = Parse.new(name)
parse.connect

filter = Filter.new(parse.get_versions)

Print.new(filter.filter_data(param, version, param2, version2),
          parse.get_versions)
