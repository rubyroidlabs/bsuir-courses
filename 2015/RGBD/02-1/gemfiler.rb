#!/usr/bin/env ruby

require "net/http"
require "json"

require "rubygems"
require "bundler/setup"

require "colorize"

# Searches packages meeting version specifications.
module GemFiler
  API_SERVER = "rubygems.org"
  API_REQUEST = "/api/v1/versions/"
  PREFIX = {
    false => "\e[0m",
    true => "\e[1;31m"
  }
  MESSAGES = {
    usage: "Uasge: gemfier.rb GEM_NAME [GEMFILE SPECIFIERS...]",
    not_found: "Gem not found: ",
    found_versions: "Versions: "
  }

  def parse(argv)
    if (gem_name = argv.shift).nil?
      puts MESSAGES[:usage]
      return
    end
    requirements = argv
    find(gem_name, requirements)
  end

  def find(gem_name, requirements)
    versions = get_versions(gem_name)
    if versions.size == 0
      puts MESSAGES[:not_found] + gem_name
      return
    end
    requirement = Gem::Requirement.new(*requirements)
    matches = versions.map { |v| requirement.satisfied_by?(v) }
    print_matches(versions, matches)
  end

  def get_versions(gem_name)
    response = Net::HTTP.get_response(API_SERVER,
                                      API_REQUEST + gem_name + ".json")
    return nil unless response.is_a? Net::HTTPOK
    JSON.parse(response.body).map { |entry| Gem::Version.new(entry["number"]) }
  end

  def print_matches(versions, matches)
    versions.size.times.chunk { |i| matches[i] }.each do |match, indicies|
      print PREFIX[match]
      indicies.each { |i| puts versions[i] }
    end
    print "\e[0m"
  end
end

if $PROGRAM_NAME == __FILE__
  include GemFiler
  GemFiler.parse(ARGV)
end
