#!/usr/bin/env ruby

require 'colorize'
require 'thor'
Dir['../sourcelib/*.rb'].each { |f| require_relative(f) } #include all libraries

class FindGem
  attr_accessor :name, :key

  def initialize(name, key)
    @name = name
    @key = key
  end
end

firstgem = FindGem.new(ARGV[0], ARGV[1])
versions = FindVersion.new(firstgem.name).find
if versions
  filter_versions = FiltreVersion.new(versions, firstgem.key.dup).filter
  if filter_versions
    PrintVersion.new(versions, filter_versions).write
  end
end
