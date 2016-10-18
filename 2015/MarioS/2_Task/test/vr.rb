#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)) + '/../lib')

require_relative '../lib/gemfiler'

puts Gemfiler::Versions.new(Gemfiler::Args.new(ARGV).parse).to_s
