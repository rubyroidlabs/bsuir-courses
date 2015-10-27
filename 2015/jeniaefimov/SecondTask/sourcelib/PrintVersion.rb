require 'colorize'
class PrintVersion
  def initialize(versions, filter_versions)
    @versions = versions
    @filter_versions = filter_versions
  end

  def write
    @versions.each { |v| puts(@filter_versions.include?(v) ? v.red : v) }
  end
end
