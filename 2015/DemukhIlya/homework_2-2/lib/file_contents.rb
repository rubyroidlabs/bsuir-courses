class FileContents
  attr_reader :filename, :lines

  def initialize(file)
    @filename = file
    @lines = File.readlines(file).map!(&:chomp)
  end
end
