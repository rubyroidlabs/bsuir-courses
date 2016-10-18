#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)) + '/../lib')

require_relative '../lib/grep'

puts Grep::Searcher.new(Grep::Args.new(ARGV).parse_argv).to_s
