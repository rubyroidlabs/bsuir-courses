require 'colored'
require_relative 'lib/GemsVersions.rb'
require_relative 'lib/RubyGemsParser.rb'

begin
  if ARGV.size < 2
    fail 'Too few arguments'
  end
  ruby_gems_parser = RubyGemsParser.new
  gems_array = ruby_gems_parser.get_gem_versions(ARGV[0])
  gems_vers = GemsVersions.new
  gems_vers.show_versions(gems_array, ARGV[1], ARGV[2])
rescue StandardError => e
  puts e.message.red
end
