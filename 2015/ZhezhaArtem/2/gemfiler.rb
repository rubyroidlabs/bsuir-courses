#!/usr/bin/env ruby
require 'rubygems'
require 'gems'
require 'colorize'
require 'byebug'
Dir[File.expand_path('./../lib/*.rb', __FILE__)].each { |f| require(f) }
gem, version, version1 = ARGV
gemfiler = VersionFinder.new(gem)
ver = Filter.new(version, version1)
print_ver = Printer.new
ver.get_version(gemfiler.get_vers_from_serv)
print_ver.print(ver.get_filtred_versions)
