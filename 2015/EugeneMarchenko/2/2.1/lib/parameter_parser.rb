#!/usr/bin/env ruby
require 'optparse'

<<<<<<< HEAD
=======
# Author::    Eugene Marchenko  (mailto:3.marchenko@gmail.com)
# Copyright:: Copyright (c) 2015 Standalone Programmer
# License::   Distributes under the same terms as Ruby

# This class holds the parse method takes one arguments
# Result: parsing available arguments for program to run
>>>>>>> 14a84c876475a9609099f3daa249a8c74bd9dfb4
class ParameterParser
  def self.parse(args)
    options = OpenStruct.new
    options.library = []
    opt_parser = OptionParser.new do |opts|
<<<<<<< HEAD
      opts.banner = "Usage: gemfiler [options]"

      opts.on("-n GEM_NAME", "--name=GEM_NAME", "Gem name to find") do |n|
        options.name = n
      end

      opts.on("-v VERSION1,VERSION2", "--version=VERSION1,VERSION2", Array, "Versions to find") do |list|
        options.list = list
        if list.size > 2
          raise ArgumentError
        end
      end

      opts.on("-h", "--help", "Prints this help") do
=======
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
>>>>>>> 14a84c876475a9609099f3daa249a8c74bd9dfb4
        puts opts
        exit
      end
    end
<<<<<<< HEAD

    opt_parser.parse!(args)
    return options
  end
end
=======
    opt_parser.parse!(args)
    options
  end
end
>>>>>>> 14a84c876475a9609099f3daa249a8c74bd9dfb4
