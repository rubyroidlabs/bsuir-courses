class RubyGrep::FileTask
  def initialize(path)
    @path = path
  end

  def each_file
    File.open(@path) do |file|
      yield file
    end
  end
end

class RubyGrep::GZipTask
  def initialize(path)
    @path = path
  end

  def each_file
    Zlib::GzipReader.open(@path) do |file|
      yield file
    end
  end
end

class RubyGrep::RecursiveTask
  def initialize(path)
    @path = path
  end

  def each_file
    Dir.glob("#{@path}/**/*") do |subpath|
      next unless File.file?(subpath)

      File.open(subpath) do |file|
        yield file
      end
    end
  end
end

class RubyGrep::StdinTask
  def each_file
    yield STDIN
  end
end
