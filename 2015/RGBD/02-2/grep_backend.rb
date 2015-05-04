require "rubygems"
require "bundler/setup"

require "optparse"
require "zipruby"

# Modify existing module
module Zip
  # Add enumerator for reading entire lines
  class File
    EACH_LINE_BUF_SIZE = 65_536

    # Returns whether the end of file was reached
    def read_till_newline
      loop do
        chunk = read(EACH_LINE_BUF_SIZE)
        return true if chunk.nil?
        @buffer << chunk
        return false if chunk.include? "\n"
      end
      false
    end

    def each_line
      @buffer = ""
      Enumerator.new do |y|
        until read_till_newline
          @buffer = @buffer.split("\n")
          (@buffer.size - 1).times { y << @buffer.shift }
          @buffer = @buffer[0]
        end
        y << @buffer
      end
    end
  end
end

# Ruby grep implementation.
class GrepBackend
  DEFAULT_OPTIONS = {
    help: false,
    context: 0,
    regex: false,
    archive: false,
    pattern: "",
    files: []
  }

  def expand_options(options)
    @context = options[:context]
    @archive = options[:archive]
  end

  def expand_files(options, files)
    @files =
      if options[:recursive]
        Dir["**/*"].reject { |file| File.directory?(file) }
      else
        files
      end
  end

  def expand_pattern(options, pattern)
    @pattern =
      if options[:regex]
        Regexp.new(pattern)
        proc { |s| r =~ s }
      else
        proc { |s| s.include? pattern }
      end
  end

  def search(options, pattern, files)
    expand_options(options)
    expand_files(options, files)
    expand_pattern(options, pattern)
    @files.each { |filename| search_in_file(filename) }
  end

  def search_in_file(filename)
    if @archive && filename.end_with?(".zip")
      search_in_archive(filename)
    else
      File.open(filename) { |file| search_in_lines(file.each_line, filename) }
    end
  end

  def search_in_archive(filename)
    # TODO: nested archives
    archive = Zip::Archive.open(filename)
    archive.each do |file|
      next if file.directory?
      search_in_lines(file.each_line, filename + ":" + file.name)
    end
    archive.close
  end

  def search_in_lines(lines, filename)
    return search_in_lines_no_context(lines, filename) unless @context > 0
    last_found = -(@context + 1)
    last_print = -1
    chunk_prev = [nil, 0] * @context # never accessed
    lines.each_with_index.each_slice(@context) do |chunk|
      index_from_end = chunk.reverse_each.find_index { |l, i| @pattern.call(l) }
      last_found = @context - 1 - index_from_end if index_from_end
      first_print = [last_print + 1, last_found - @context].max
      last_print = [last_found + @context, @context - 1].min
      (first_print..last_print).to_a.each do |i|
        render_line(*(i < 0 ? chunk_prev[i] : chunk[i]), filename)
      end
      last_found -= @context
      last_print -= @context
      chunk_prev = chunk
    end
  end

  def search_in_lines_no_context(lines, filename)
    lines.each_with_index do |line, index|
      render_line(line, index, filename) if @pattern.call(line)
    end
  end

  def render_line(line = nil, number = 0, filename)
    puts "#{filename}:#{(number + 1).to_s.rjust(4, '0')}: #{line}" if line
  end
end
