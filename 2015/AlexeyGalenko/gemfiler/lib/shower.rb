require 'colorize'
class Shower

  def initialize(versions, after_filter)
    @versions = versions
    @after_filter = after_filter
  end

  def show
    @versions.each {|v| puts (@after_filter.include?(v) ? v.red : v)}
  end
end
