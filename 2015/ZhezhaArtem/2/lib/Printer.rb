class Printer
  def print(filter_versions)
    filter_versions.each do |filtr|
      if filtr[1]
        puts filtr[0].colorize(:red)
      else
        puts filtr[0]
      end
    end
  end
end

