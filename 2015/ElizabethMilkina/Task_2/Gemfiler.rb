#!/usr/bin/env ruby
require_relative 'src/name_gem.rb'
require_relative 'src/version_gem.rb'
require_relative 'src/output_gem.rb'
require 'slop'

opts = Slop.parse

object_name = NameGem.new
object_version = VersionGem.new
filtered_versions, not_matched_versions = object_version.\
get_version(object_name.get_name(opts.arguments[0]), opts.arguments[1])
if opts.arguments.length == 3
  filtered_versions, not_matched_after_second = object_version.\
get_version(filtered_versions, opts.arguments[2])
  if not not_matched_after_second.empty?
    not_matched_versions += not_matched_after_second
  end
end
object_filter = OutputGem.new
object_filter.output(filtered_versions, not_matched_versions)
