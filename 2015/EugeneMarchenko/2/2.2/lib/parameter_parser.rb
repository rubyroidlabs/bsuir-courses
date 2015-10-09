#!/usr/bin/env ruby
require 'optparse'
require 'ostruct'

# Author::    Eugene Marchenko  (mailto:3.marchenko@gmail.com)
# Copyright:: Copyright (c) 2015 Standalone Programmer
# License::   Distributes under the same terms as Ruby

# This class holds the parse method takes one arguments
# Result: parsing available arguments for program to run
class ParameterParser
  def self.parse(args)
    options = OpenStruct.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: grepkiller.rb [options] PATTERN FILE_NAME'

      opts.separator ''

      # Cast 'around' argument to a Integer.
      # opts.on('-A NUMBER', '--around=NUMBER', Integer, 'Search around PATTERN') do |around|
      #   options.around = around
      # end

      opts.on('-e PATTERN', '--regexp=PATTERN', 'use PATTERN for matching') do |regexp|
        options.regexp = regexp
      end

      # Boolean switch.
      # opts.on('-z', '--zipped', 'Unzip before search PATTERN') do |z|
      #   options.zip = z
      # end

      opts.on('-R', '--recursive', 'Recursive search PATTERN in all files in specific directory') do |r|
        options.recursive = r
      end

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(args)
    options
  end
end