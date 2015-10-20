require 'colored'
require_relative 'lib/GemsVersions.rb'
require_relative 'lib/RubyGemsParser.rb'

begin
  if ARGV.size < 2
    fail "Too few arguments"
  end
  rubyGemsParser = RubyGemsParser.new
  gemsArray = rubyGemsParser.getGemVersions(ARGV[0])
  gemsVers = GemsVersions.new
  gemsVers.showVersions(gemsArray, ARGV[1], ARGV[2])
rescue StandardError => e
  puts e.message.red
end
