#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require "thor"

class Grep < Thor
  package_name "grep"
  default_task :search

  desc "search [OPTIONS] PATTERN [FILE...]", "Search PATTERN in FILE(s)"
  method_option :context, {
    :type => :numeric,
    default: 0,
    :aliases => "-A",
    :desc => "Print NUM lines surrounding pattern"
  }
  method_option :regex, {
    type: :boolean,
    default: false,
    aliases: "-e",
    desc: "Treat PATTERN as regex"
  }
  method_option :recursive, {
    type: :boolean,
    default:false,
    aliases: "-R",
    desc: "Search recursively in all subdirs"
  }
  method_option :archive, {
    type: :boolean,
    default: false,
    aliases: "-z",
    desc: "Unpack archives before search (zip only)"
  }
  def search(pattern, *files)
    puts "options: #{options}"
    puts "pattern: #{pattern}"
    puts "files: #{files}"
    require_relative './grep_backend.rb'
    GrepBackend.new.search(options, pattern, files)
  end
end

Grep.start
