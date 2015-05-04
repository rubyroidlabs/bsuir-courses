#!/usr/bin/env ruby

require "net/http"
require "json"

require "rubygems"
require "bundler/setup"

require "colorize"

# add method number?
class String
  def number?
    true if Float(self) rescue false
  end
end

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
    specifiers = argv
    find(gem_name, specifiers)
  end

  def find(gem_name, specifiers)
    versions = request_versions(gem_name).sort_by { |v| version_split(v) }
    if versions.size == 0
      puts MESSAGES[:not_found] + gem_name
      return
    end
    matches = filter_versions(versions, specifiers)
    print_with_matches(versions, matches)
  end

  def request_versions(gem_name)
    response = Net::HTTP.get_response(API_SERVER,
                                      API_REQUEST + gem_name + ".json")
    return [] unless response.is_a? Net::HTTPOK
    JSON.parse(response.body).map { |entry| entry["number"] }
  end

  def version_split(version)
    version.split(".").map { |v| v.number? ? v.to_i : v }
  end

  def specifier_to_filter(specifier)
    operator = /[^\d\s]+/.match(specifier).to_s
    target = version_split(/\d.*/.match(specifier).to_s)
    return nil unless target
    get_filter(operator, target)
  end

  def pessimistic_greater(target)
    proc do |vs|
      minor = target.size - 1
      vs.drop_while { |v| (v <=> target) < 0 }.take_while do |v|
        v[0...minor] == target[0...minor] && v[minor] >= target[minor]
      end
    end
  end

  def get_filter(operator, target)
    case operator
    when "!=" then proc { |vs| vs.find_all { |v| v != target } }
    when "", "=" then proc { |vs| vs.find_all { |v| v == target } }
    when "<" then proc { |vs| vs.take_while { |v| (v <=> target) < 0 } }
    when ">=" then proc { |vs| vs.drop_while { |v| (v <=> target) < 0 } }
    when ">" then proc { |vs| vs.drop_while { |v| (v <=> target) <= 0 } }
    when "<=" then proc { |vs| vs.take_while { |v| (v <=> target) <= 0 } }
    when "~>" then pessimistic_greater(target)
    end
  end

  def filter_versions(versions, specifiers)
    possible = versions.map { |v| version_split(v) }
    specifiers.map! { |s| specifier_to_filter(s) }
    specifiers.each { |s| possible = s.call(possible) }
    matches = [false] * versions.size
    possible.each { |v| matches[versions.index(v.join("."))] = true }
    matches.to_a
  end

  def print_with_matches(versions, matches)
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
