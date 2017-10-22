#!/usr/bin/env ruby

require_relative '../lib/referee'

params = Parser.new(ARGV).parse
gp = GeniusParser.new
gp.referee(params[:name], params[:criteria])
