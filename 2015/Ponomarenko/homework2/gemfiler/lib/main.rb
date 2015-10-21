#!/usr/bin/env ruby

class Gemfiler
  def execute
    gem_name = parse_arguments[:name]
    version_specs = parse_arguments[:versions]

    searcher = Searcher.new(gem_name)
    searcher.search

    filter = Filter.new(version_specs, searcher.versions)

    filter.match do |version, matches|
      puts matches ? version.colorize(:red) : version
    end
  end

  def parse_arguments
    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: gemfiler [options] <gemname> <version_spec>'
    end
    parser.parse!
    gem_name, *version_specs = ARGV
    { name: gem_name, versions: version_specs }
  end
end
