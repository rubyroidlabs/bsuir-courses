#!/usr/bin/env ruby
require 'colored'
require 'json'
name = ARGV[0]
version = ARGV[1].to_s
oper = ARGV[2].to_s
class VersionFetcher
  def initialize(name)
    @name = name
  end

  def fetch
    json = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    result = []
    begin
      JSON.parse(json).each do |entry|
        result << entry.fetch('number')
      end
      puts result
    rescue JSON::ParserError
      puts 'Error. Check the way of writing gem name'.red
    end
    result
  end
end

class VersionFilter
  def initialize(result)
    @version = result.map { |version| Gem::Version.new(version) }
  end

  def filter(specifier, operator)
    needed_version = Gem::Version.new(specifier)
    results = []

    case operator
    when '~>'
      results = @version.select do |version|
        needed_version <= version && version < needed_version.bump
      end
      results = results.map &:to_s
    when '<'
      results = @version.select do |version|
        needed_version > version
      end
      results = results.map &:to_s
    when '>'
      results = @version.select do |version|
        needed_version < version
      end
      results = results.map &:to_s
    end
    results
  end
end

class Visualizer
  def initialize(result)
    @result = result
  end

  def visual
    @result.each { |v| puts (@result.include?(v) ? v.red : v) }
  end
end
res_fet = VersionFetcher.new(name).fetch
puts "\n"
res_fil = VersionFilter.new(res_fet).filter(version, oper)
Visualizer.new(res_fil).visual
