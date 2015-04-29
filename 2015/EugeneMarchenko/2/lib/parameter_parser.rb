#!/usr/bin/env ruby
require 'optparse'

# Author::    Eugene Marchenko  (mailto:3.marchenko@gmail.com)
# Copyright:: Copyright (c) 2015 Standalone Programmer
# License::   Distributes under the same terms as Ruby

# This class holds the parse method takes one arguments
# Result: parsing available arguments for program to run
class ParameterParser
  def self.parse(args)
    options = OpenStruct.new
    options.library = []
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: gemfiler [options]'

      opts.on('-n GEM_NAME', '--name=GEM_NAME', 'Gem name to find') do |n|
        options.name = n
      end

      opts.on('-v VERSION1,VERSION2', '--version=VERSION1,VERSION2',
              Array, 'Versions to find') do |list|
        options.list = list
        fail ArgumentError if list.size > 2
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end
    opt_parser.parse!(args)
    options
  end
end
