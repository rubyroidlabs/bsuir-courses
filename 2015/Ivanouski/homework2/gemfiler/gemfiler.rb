#!/usr/bin/env ruby

# gemfiler
# @version 0.1.8
# @author S. Ivanouski

require 'gems'
require 'colorize'
require './lib/gemfilter.rb'
require './lib/helpprinter.rb'
require './lib/versionprinter.rb'

$ver_array = []

new_search = Gems.new
filtration = GemFilter.new
helper = HelpPrinter.new
drawer = VersionPrinter.new

gem_name = ARGV[0]
operator1 = ARGV[1]
version1 = ARGV[2]
operator2 = ARGV[3]
version2 = ARGV[4]

begin
  @versions = new_search.versions gem_name
rescue SocketError => e
  helper.connection_error(e)
end

begin
  case ARGV.size
  when 1
    drawer.print_all(@versions, gem_name)
  when 3
    filtration.filter(@versions, operator1, version1)
  when 5
    filtration.filter_long(@versions, operator1, version1, operator2, version2)
  else
    helper.print_help
  end
rescue
  helper.name_error
end

drawer.print_versions($ver_array, ARGV[0])

exit 0
