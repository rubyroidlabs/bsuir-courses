#!/usr/bin/env ruby
require 'colored'
require 'json'
require 'pry'

Dir[File.expand_path('./../lib/*.rb', __FILE__)].each { |f| require(f) }

name = ARGV[0]
version = ARGV[1].to_s
oper = ARGV[2].to_s

res_fet = VersionFetcher.new(name).fetch
puts "\n"
res_fil = VersionFilter.new(res_fet).filter(version, oper)
Visualizer.new(res_fil).visual
