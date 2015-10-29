#!/usr/bin/env ruby

require_relative '../lib/gemfiler.rb'

param = Parser.new(ARGV).parse_param
Presentation.new(Checker.new(param).check_versions).show_versions
