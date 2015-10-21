#!/usr/bin/env ruby

require 'optparse'
require 'colorize'
require 'gems'

lib = File.expand_path('../lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'main'
require 'search&filter'

a = Gemfiler.new
a.execute