require 'colorize'
Dir['../lib/*.rb'].each { |file| require_relative(file) }

class Gemfiler
  attr_accessor :gem_name, :gem_version

  def initialize(gem_name, gem_version)
    @gem_version = gem_version
    @gem_name = gem_name
  end
end

begin
  entered_gem = Gemfiler.new(*ARGV)
  all_vers = VersionParser.new(entered_gem.gem_name).fetch
  if all_vers
    filtr_vers = VersionFilter.new(all_vers, entered_gem.gem_version.dup).filter
    ColoredOutput.new(all_vers, filtr_vers).output if filtr_vers
  end
rescue ArgumentError
  puts 'Argument Error. Input gem name and version'.green
end
