class Visualizer

  def self.print all, matching, flag
    all -= matching
    if !flag
      all.each { |version| puts version }
    end
    matching.each { |version| puts version.red }
  end

end
