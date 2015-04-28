#!/usr/bin/env ruby
require 'optparse'

Options = Struct.new(:name, :version)

class ParameterParser
  def self.parse(options)
    args = Options.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: gemfiler [options]"

      opts.on("-n GEM_NAME", "--name=GEM_NAME", "Gem name to find") do |n|
        args.name = n
      end

      opts.on("-v VERSION", "--version=VERSION", "Versions to find") do |n|
      	args.version = n
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end

 #%w[--help]
