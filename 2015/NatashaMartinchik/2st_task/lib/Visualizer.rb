class Visualizer
  def initialize(result)
    @result = result
  end

  def visual
    @result.each { |v| puts (@result.include?(v) ? v.red : v) }
  end
end