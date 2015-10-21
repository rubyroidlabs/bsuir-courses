require 'rubygems'
require 'gems'

class GemFinder
  attr_accessor :gem_versions

  def initialize(name)
    @name = name
  end

  def find
    begin
      information = Gems.versions(@name)

      if information.instance_of?(String)
        raise Exception.new('There is not such gem.')
      end
    rescue SocketError
      raise Exception.new('Network is disabled.')
    end

    @gem_versions = []

    information.each do |item|
      @gem_versions.push(item['number'])
    end
  end
end
