#!/usr/bin/env ruby
require 'optparse'

class ParameterParser
  def self.parse(args)
    options = OpenStruct.new
    options.library = []
    opt_parser = OptionParser.new do |opts|
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
        puts opts
        exit
      end
    end

    opt_parser.parse!(args)
    return options
  end
end