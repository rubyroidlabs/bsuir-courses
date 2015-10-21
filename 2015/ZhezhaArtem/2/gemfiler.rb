#!/usr/bin/env ruby
require 'rubygems'
require 'gems'
require 'colorize'
require 'byebug'
Dir[File.expand_path('./../lib/*.rb', __FILE__)].each do |f| 
	require(f)
end
begin
  if ARGV.length < 2 || ARGV.length > 3
    raise ArgumentError, 'Ibcorrect number of arguments.'
    exit
  end
gem, version, version1 = ARGV
gemfiler = VersionFinder.new(gem)
ver = Filter.new(version, version1)
print_ver = Printer.new
ver.get_version(gemfiler.get_vers_from_serv)
print_ver.print(ver.get_filtred_versions)

