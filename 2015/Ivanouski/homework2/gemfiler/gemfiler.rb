#!/usr/bin/env ruby

# gemfiler
# @version 0.2.1
# @author S. Ivanouski

require 'rubygems'
require 'gems'
require 'thor'
require 'colorize'
require './lib/gemfilter.rb'

class GemFiler < Thor
  desc "search GEM_NAME 'option' version",
  "Will search for gem versions. Optional: 'second_option' other_version"
  long_desc(File.read('README.md'))
  def search(gemname, option, version, option2 = nil, version2 = nil)
    begin
      hash = Gems.versions gemname
    rescue SocketError => err
      print "CONNECTION ERROR!\n#{err}\n"
      exit 1
    end
    if option2 && version2
      GemFilter.filter_long(hash.reverse, option, version, option2, version2)
    else
      GemFilter.filter(hash.reverse, option, version)
    end
  end
end

GemFiler.start

exit 0
