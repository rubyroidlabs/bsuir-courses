require 'colorize'

class Outprinter
  def initialize(versions, filtred_versions)
    @versions = versions
    @filtred_versions = filtred_versions
  end

  def print
    @versions.each { |v| puts @filtred_versions.include?(v) ? v.red : v }
  end
end
