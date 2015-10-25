#!/usr/bin/env ruby
Dir[File.expand_path('./../lib/*.rb', __FILE__)].each { |f| require(f) }

class GemFiler
  pcl = ParsingCommandLine.new
  if pcl.get_count_arguments < 2
    raise ArgumentError.new('Incorrect number of arguments')
  end
  hash_with_conditions = pcl.get_conditions
  versions_gems = ParsingPage.new(pcl.get_name).parsing_page
  SearchAndColoring.new(versions_gems, hash_with_conditions).search_and_coloring
end
