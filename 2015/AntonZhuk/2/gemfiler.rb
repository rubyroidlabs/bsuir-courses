require_relative('parse.rb')
require_relative('filter.rb')
require_relative('print.rb')
require_relative('console_parser')

# Осторожно! Может пойти кровь из глаз! Мне рально стыдно
str = ConsoleParser.new
str.parse_options
name, limitation1, limitation2 = str.cli_arguments

_version = limitation1.to_s.split.last
param = limitation1.to_s.split.first
_version2 = limitation2.to_s.split.last
param2 = limitation2.to_s.split.first
puts name, param, _version, param2, _version2
parse = Parse.new(name)
parse.connect

filter = Filter.new(parse.get_versions)

Print.new(filter.filter_data(param, _version, param2, _version2),
          parse.get_versions)
