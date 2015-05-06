#!/usr/bin/env ruby
require 'colorize'
require 'version_sorter'
require_relative '../lib/visualizer'

# Author::    Eugene Marchenko  (mailto:3.marchenko@gmail.com)
# Copyright:: Copyright (c) 2015 Standalone Programmer
# License::   Distributes under the same terms as Ruby

# This class holds the filter method takes two arguments
# Result: call Visualizer class to print output
class GemVersionFilter
  def filter(array, versions)
    v = Visualizer.new
    VersionSorter.sort(array).each do |i|
      if Gem::Dependency.new('', versions).match?('', i)
        v.visualize(i, :green)
      else
        v.visualize(i, :red)
      end
    end
  end
end
