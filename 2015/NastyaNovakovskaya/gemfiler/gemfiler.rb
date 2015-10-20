#!/usr/local/bin/ruby

Dir[File.expand_path('./lib/*.rb')].each {|f|  require(f)}
class Gemfiler

  def start
    parser = Parser.new
    parser.parse

    finder = GemFinder.new(parser.name)
    finder.find

    output = Output.new(parser.version, finder.gem_versions, parser.name)
    output.print_result
  end
end

Gemfiler.new.start
