#!/usr/bin/env ruby
require_relative 'src/name_gem.rb'
require_relative 'src/version_gem.rb'
require_relative 'src/filter_gem.rb'


object_name = Name_gem. new
object_name. get_name

object_version = Version_gem. new
object_version. get_version

object_filter = Filter_gem. new
object_filter. get_filter