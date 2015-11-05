require 'colorize'
require 'zlib'
require 'pry'

module Grep
  class Searcher
    def initialize(conditions)
      @conditions = conditions
    end

    def search_pattern
      @find_content = []
      unless @conditions[:zname].nil?
        content = unzname_file(@conditions[:zname])
        verification_pattern(content, @conditions[:zname])
      end
      unless @conditions[:fnames].nil?
        @conditions[:fnames].each do |fname|
          content = open_file(fname)
          verification_pattern(content, fname)
        end
      end
      @find_content
    end

    def verification_pattern(content, fname, pattern = @conditions[:pattern])
      scope = []
      unless content.nil?
        content.each_with_index do |line, index|
          scope << analize_scope(content, index) if /#{pattern}/ =~ line
        end
      end
      @find_content << { fname: fname, content: scope } unless scope.empty?
    rescue
      puts "File #{fname} have unreadable format\n".red
    end

    def analize_scope(content, index)
      amount = @conditions[:amount]
      if (index - amount) < 0
        scope = (content[0..index + amount].join).green
      else
        scope = (content[index - amount..index + amount].join).green
      end
      scope
    end

    def open_file(fname)
      content = []
      File.open(fname).each { |line| content << line }
      content
    rescue
      puts "File: #{fname} cant be open.\n".red
    end

    def unzname_file(zname)
      content = []
      Zlib::GzipReader.open(zname).each { |line| content << line }
      content
    rescue
      puts "GZip file: #{zname} cant be open\n".red
    end

    def to_s
      search_pattern
      find_content = ''
      @find_content.each do |parse|
        find_content << ("\n" + parse[:fname] + ":\n").blue
        parse[:content].each { |content| find_content << content }
      end
      find_content
    end
  end
end
