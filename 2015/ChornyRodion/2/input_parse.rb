# Class for parsing input parameters
class InputParse
  def initialize(stream)
    @stream = stream
    @option_count = stream.size - 1
    @gem_name = stream[0]
  end

  attr_reader :gem_name
  attr_reader :option_count

  def filter_options
    @stream[1..@option_count]
  end
end
