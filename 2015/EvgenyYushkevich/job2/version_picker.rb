require "./version.rb"

class VersionPicker
  def initialize(name, versions, bound1, bound2)
    @versions = versions
    @bound1 = bound1
    @bound2 = bound2
    @name = name
    @vers_obj_arr = []
  end

  def matches(vers)
    if Gem::Dependency.new('', @bound1).match?('', vers) && Gem::Dependency.new('', @bound2).match?('', vers)
      true
    else
      false
    end
  rescue Gem::Requirement::BadRequirementError
    # raise Exception.new('Incorrect versions format.')
    puts 'Incorrect versions format.'.blue
    exit
  end

  def check_all
    @versions.each do |elem|
      if matches(elem)
        @vers_obj_arr.push(Version.new(elem, true))
      else
        @vers_obj_arr.push(Version.new(elem, false))
      end
    end
  end

  def print_all
    check_all
    @vers_obj_arr.each &:print_version
  end
end
