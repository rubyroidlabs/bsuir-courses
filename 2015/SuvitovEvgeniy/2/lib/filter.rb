require 'colorize'

class Filter
  def initialize(versions, options)
    @versions = versions
    @options = options
  end

  def print
    @versions.each do |x|
      if check_version?(x)
        puts x.red
      else
        puts x
      end
    end
  end

  def check_version?(x)
    if @options.has_key?(:equal) && (x != @options[:equal])
      return false
    end
    if @options.has_key?(:low) && (x >= @options[:low])
      return false
    end
    if @options.has_key?(:great) && (x <= @options[:great])
      return false
    end
    if @options.has_key?(:loworequal) && (x > @options[:loworequal])
      return false
    end
    if @options.has_key?(:greatorequal) && (x < @options[:greatorequal])
      return false
    end
    true
  end
end
