require 'thor'
require_relative 'gem_versions_getter.rb'
require_relative 'versions_printer.rb'

class Gemfiler < Thor
  desc "get name 'condition1' 'condition2'", "output versions"
  def get( gemname, condition1 = nil, condition2 = nil)
    gem_versions_getter = GemVersionsGetter.new
    versions_array = gem_versions_getter.get_versions(gemname)
    VersionsPrinter.
      output_with_condition(versions_array, condition1, condition2)
  rescue StandardError => e
    puts e.message.red
  end
end

Gemfiler.start(ARGV)
