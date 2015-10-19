#!/usr/bin/env ruby
require_relative 'src/name_gem.rb'
require_relative 'src/version_gem.rb'
require_relative 'src/filter_gem.rb'

object_name = NameGem.new
object_name.get_name
object_version = VersionGem.new
object_version.get_version
object_filter = FilterGem.new
object_filter.get_filter
object_filter.get_not_matched
