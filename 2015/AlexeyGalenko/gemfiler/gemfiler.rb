#!/usr/bin/env ruby
Dir['./lib/*.rb'].each {|f| require_relative(f)}

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

def check_parameters(n)
  rname = /\w+/
  rver_from = /(>\d+.\d+.\d+|>=\d+.\d+.\d+|~>\d+.\d+.\d+.|>\d+.\d+|>=\d+.\d+|~>\d+.\d+|)/
  rver_to = /(<\d+.\d+.\d+|<=\d+.\d+.\d+|<\d+.\d+|<=\d+.\d+|)/
  b = lambda {|name, num| name.match(ARGV[num]).to_s == ARGV[num]}
  if n == 3
    b.call(rname, 0) && b.call(rver_from, 1) && b.call(rver_to, 2)
  elsif n == 2
    b.call(rname, 0) && b.call(rver_from, 1)
  else
    false
  end
end
gi
if check_parameters(ARGV.length)
  g = Gemfiler.new(*ARGV)
else
  usage("Wrong number parameters or wrong parameters itself")
end

f = Fetcher.new(g.name)
versions_string = f.fetch
if versions_string
  versions = f.parse(versions_string)
  after_filter = Filter.new(versions, g.version_from, g.version_to).filter
  Shower.new(versions, after_filter).show if after_filter
end
