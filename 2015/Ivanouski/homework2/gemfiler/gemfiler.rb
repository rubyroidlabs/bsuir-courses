#!/usr/bin/env ruby

# gemfiler
# @version 0.3.5
# @author S. Ivanouski

require 'rubygems'
require 'gems'
require 'docopt'
require 'colorize'
require './lib/gemfilter.rb'
require './lib/helper.rb'

class GemFiler
  def initialize(gemname, option, option2 = nil)
    @gemname = gemname
    @option = option[/>=?|~>?|>?|<?/]
    @version = option[/\d.+/]
    @option2 = option2
  end

  def new_serch
    (Gems.versions @gemname).reverse
  end

  def printout(hash)
    if @option2
      GemFilter.filter2(hash,
                        @option,
                        @version,
                        @option2[/<?/],
                        @option2[/\d.+/])
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

if arguments["<'option version'>"] =~ />=|~>|>|</ ||
   (arguments["<'option version'>"] =~ />=|~>|>|</ &&
   arguments["<'option2 version2'>"] =~ /</)
  gemfiler = GemFiler.new(arguments['<gemname>'],
                          arguments["<'option version'>"],
                          arguments["<'option2 version2'>"],)
else
  Helper.input_error('Wrong option!')
end

begin
  get_hash = gemfiler.new_serch
rescue SocketError => err
  Helper.connection_error(err)
end
begin
  gemfiler.printout(get_hash)
rescue NoMethodError, ArgumentError => err
  Helper.input_error(err)
end

exit 0
