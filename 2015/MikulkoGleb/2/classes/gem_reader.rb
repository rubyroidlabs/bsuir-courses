require 'open-uri'
require 'yaml'

class Gem_reader
  def initialize(gem_name)

    conf = YAML::load_file(File.expand_path('../../conf/gem.conf', __FILE__))
    @source = conf['source'] + gem_name + '.' + conf['format']
  end

  def get_gems
    response = open(@source).read
    versions = response.scan(/"number":"[^,]+"/).map {|string| string.gsub(/"number":/, '')}
    versions.map {|str| str.gsub("\"", '')}
  rescue => e
    abort(e.inspect)
  end
end
