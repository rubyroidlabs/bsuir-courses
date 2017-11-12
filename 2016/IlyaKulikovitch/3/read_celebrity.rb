class ReadCelebrity
  attr_reader :celebrity

  def initialize(base = nil)
    @base = base
    @celebrity = {}
  end

  def write_to_base
    if exist_base
      file = File.read(@base)
      @celebrity = JSON.parse(file)
    end
    @celebrity
  end

  def exist_base
    if File.exist?(@base)
      true
    else false
    end
  end
end
