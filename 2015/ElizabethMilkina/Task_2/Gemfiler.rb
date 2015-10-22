#!/usr/bin/env ruby
require_relative 'src/name_gem.rb'
require_relative 'src/version_gem.rb'
require_relative 'src/output_gem.rb'
require 'slop'

opts = Slop.parse do |option|
  option.string '-n', '--name', 'gem name'
  option.string '-c', '--command', 'how to check version and version'
end

object_name = NameGem.new
object_version = VersionGem.new
filtered_versions, not_matched_versions = object_version.\
get_version(object_name.get_name(opts[:name]), opts[:command])
object_filter = OutputGem.new
object_filter.output(filtered_versions, not_matched_versions)
