require 'colorize'

class Output

  attr_reader :name,
              :req_version,
              :gem_versions

  def initialize(req_version, gem_versions, name)
    @name = name
    @req_versions = req_version
    @gem_versions = gem_versions
  end

  def check_version(version)
    @req_versions.all? do |item|
      Gem::Dependency.new(@name, item).match?(@name,version)
    end
  rescue Gem::Requirement::BadRequirementError
    raise Exception.new('Version format is not correct.')
  end

  def print_result
    output_string = 'Gem name - ' + @name + "\nVersions: "
    right_versions = []
    wrong_versions = []

    @gem_versions.each do |version|
      check_version(version)  ? right_versions.push(version) : wrong_versions.push(version)
    end

    output_string = output_string + "\n right: " + right_versions.join(', ').red
    output_string = output_string + "\n wrong: " + wrong_versions.join(', ')

    puts output_string
  end
end