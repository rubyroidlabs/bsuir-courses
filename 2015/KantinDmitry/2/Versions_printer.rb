# throws Gem::Requirement::BadRequirementError
require 'colorize'

module VersionsPrinter
  module_function

  def output_with_condition(versions_array, condition1, condition2 = '')
    versions_array.each do |version|
      if ver_check(condition1, version) && ver_check(condition2, version)
        puts version.red
      else
        puts version
      end
    end
  end

  private

  module_function

  def ver_check(condition, version)
    Gem::Dependency.new('', condition).
      match?('', version.gsub(/[.][a-z]+\d*/,''))
  end
end
