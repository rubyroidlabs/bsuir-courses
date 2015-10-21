require_relative('parse.rb')
require_relative('filter.rb')
require_relative('print.rb')

name = ARGV[0].to_s
param = ARGV[1].to_s.split(' ').first
version = ARGV[1].to_s.split(' ').last
param2 = ARGV[2].to_s.split(' ').first
version2 = ARGV[2].to_s.split(' ').last

parse = Parse.new(name)
parse.connect

filter = Filter.new(parse.get_versions)

Print.new(filter.filter_data(param, version, param2, version2),
          parse.get_versions)
