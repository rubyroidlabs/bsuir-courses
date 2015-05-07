class GrepKiller

  def initialize(options, pattern, files)
    @options = options
    @pattern = pattern
    @files = []
    @a = options[:a] || 0
    @reg = Regexp.new pattern if @options[:regexp]
    @found_anything = false

    if @options[:recursively]
      files.each do |file|
        @files += Dir["#{file}/**/*"]
        @files += [file]
      end
    else
      @files = files
    end
  end

  def match?(line)
    return @reg.match(line) if @reg
    return line.include? @pattern
  end

  # Print line. According to the flag that is true if the line contains match
  # different formats are used. If only one file is searched the filename
  # is not printed.
  def print_match(line, filename, flag)
    if @files.size == 1 && !@options[:recursively]
      print line
      return
    end

    if flag
      print filename, ":", line
    else
      print filename, "-", line
    end
  end

  def grep_file(filename)
    leading = []
    no_match = -1
    file = nil

    # Grep gzip files if the option if passed.
    if File.extname(filename) == ".gz"
      if @options[:decompress]
        file = Zlib::GzipReader.open(filename)
      end
    else
      file = File.open(filename)
    end

    return unless file
    file.each do |line|
      # Keep leading size equal to @a + 1
      leading << line
      leading.shift if leading.size > @a + 1

      # If the line matches then output leading lines with the line that
      # mathces. If it doesn't then count lines untill the "-A"-option
      # condition is reached.
      if match?(line)
        #p line
        if no_match < 0
          # Separate results with "==" if more than one are found.
          puts "==" if @found_anything
          @found_anything = true
          leading.each_with_index do |l, i|
            print_match l, filename, i + 1 == leading.size
          end
          no_match = 0
        elsif no_match == 0
          print_match line, filename, true
        end
      else
        no_match += 1
        if no_match <= @a && no_match > 0
          print_match line, filename, false
          no_match = -1 if no_match == @a
        else
          no_match = -1
        end
      end
    end
    file.close
  end

  def make_grep
    @files.each do |file|
      if File.file? file
        grep_file file
      end
    end
  end
end
