class ColoredOutput
  def initialize(all_vers, filtr_vers)
    @all_vers = all_vers
    @filtr_vers = filtr_vers
  end

  def output
    @all_vers.each { |ver| puts (@filtr_vers.include?(vers) ? ver.red : ver) }
  end
end
