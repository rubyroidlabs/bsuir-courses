require 'colored'
require 'optparse'
require_relative 'lib/gems_versions.rb'
require_relative 'lib/rubygems_parser.rb'

cmd_parser = OptionParser.new do|opts|
  opts.banner = 'Usage: ./gemfiler [gem_name] [ver_condition]'
end

cmd_parser.parse!
gem_name, first_condition, second_condition = ARGV

begin
  ruby_gems_parser = RubyGemsParser.new
  gems_array = ruby_gems_parser.get_gem_versions(gem_name)
  gems_vers = GemsVersions.new
  gems_vers.show_versions(gems_array, first_condition, second_condition)
rescue ArgumentError
  puts 'Error. Check command line arguments!'.red
rescue StandardError => e
  puts e.message.red
end
