#!/usr/bin/env ruby
require 'slop'

Dir['./lib/*.rb'].each { |f| require_relative(f) }

class Gemfiler
  attr_reader :name, :version_from, :version_to

  def initialize(name, version_from, version_to = '<1000.0.0')
    @name = name
    @version_from = version_from
    @version_to = version_to
  end
end

def usage(s)
  $stderr.puts(s)
  $stderr.puts("Usage example: ./gemfiler gem_name '>= 3.1' '<4.0'")
  exit(2)
end

opts = Slop.parse do |o|
  o.string '...'
end
p = opts.arguments

def check_parameters(p)
  n = p.size
  rname = /\w+/
  r = /(<|<=|>=|>|~>)(\d+.\d+.\d+|\d+.\d+)/
  b = lambda { |name, num| name.match(p[num]).to_s == p[num] }
  if n == 3
    b.call(rname, 0) && b.call(r, 1) && b.call(r, 2)
  elsif n == 2
    b.call(rname, 0) && b.call(r, 1)
  else
    false
  end
end

if check_parameters(p)
  g = Gemfiler.new(*p)
else
  usage('Wrong number parameters or wrong parameters itself')
end

f = Fetcher.new(g.name)
versions_string = f.fetch
if versions_string
  versions = f.parse(versions_string)
  after_filter = Filter.new(versions, g.version_from, g.version_to).filter
  Show.new(versions, after_filter).show if after_filter
end
