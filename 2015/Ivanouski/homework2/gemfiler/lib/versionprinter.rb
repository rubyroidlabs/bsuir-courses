class VersionPrinter
  def print_versions(version, name)
    @version = version.reverse
    @name = name.blue
    @version.each do |version|
      print "#{@name} #{version} \n"
    end
  end

  def print_all(versions, name)
    @name = name.blue
    versions.each do |i|
      print "#{@name} #{i["number"]} \n"
    end
  end
end
