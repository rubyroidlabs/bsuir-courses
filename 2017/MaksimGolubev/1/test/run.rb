#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)) + '/../lib')

require_relative '../lib/gardener'

Gardener::Worker.new(Gardener::Parser.new(ARGV).parse).work
