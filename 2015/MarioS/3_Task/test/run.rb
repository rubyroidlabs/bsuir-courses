#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)) + '/../lib')

require_relative '../lib/lectors_prober'

num_group = LectorsProber::ParserArgv.new(ARGV).parse
lectors_info = LectorsProber::ParserSite.new(num_group).grab_lectors_info
puts LectorsProber::TonalityMessages.new(lectors_info).to_s
