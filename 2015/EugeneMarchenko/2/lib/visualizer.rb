#!/usr/bin/env ruby
require 'colorize'

# Author::    Eugene Marchenko  (mailto:3.marchenko@gmail.com)
# Copyright:: Copyright (c) 2015 Standalone Programmer
# License::   Distributes under the same terms as Ruby

# This class holds the visualize method takes two arguments
# Result: call Visualizer class with visualize method to
# output the result of program
class Visualizer
  def visualize(element, color)
    puts "#{element}".colorize(color)
  end
end
