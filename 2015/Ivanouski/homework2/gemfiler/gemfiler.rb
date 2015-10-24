#!/usr/bin/env ruby

# gemfiler
# @version 0.3.3
# @author S. Ivanouski

require 'rubygems'
require 'gems'
require 'docopt'
require 'colorize'
require './lib/gemfilter.rb'

class GemFiler
  def initialize(gemname, option, option2 = nil)
    @gemname = gemname
    @option = option[0..1]
    @version = option[3..8]
    @option2 = option2
  end

  def new_serch
    (Gems.versions @gemname).reverse
  end

  def printout(hash)
    if @option2
      GemFilter.filter2(hash, @option, @version, @option2[0], @option2[2..7])
    else
      GemFilter.filter(hash, @option, @version)
    end
  end
end

doc = <<EOF
Usage:
  #{__FILE__} <gemname> <'option version'>
  #{__FILE__} <gemname> <'option version'> <'option2 version2'>

  Option:
  -h         Show this help
EOF

begin
  arguments = Docopt::docopt(doc)
rescue Docopt::Exit => e
  puts e.message
  exit
end

gemfiler = GemFiler.new(arguments['<gemname>'],
                        arguments["<'option version'>"],
                        arguments["<'option2 version2'>"],)

begin
  get_hash = gemfiler.new_serch
rescue SocketError => err
  print "CONNECTION ERROR!\n#{err}\n"
  exit 1
end
begin
  gemfiler.printout(get_hash)
rescue NoMethodError => err
  print "ERROR: This rubygem could not be found.\n#{err}\n"
  exit 1
end

exit 0
