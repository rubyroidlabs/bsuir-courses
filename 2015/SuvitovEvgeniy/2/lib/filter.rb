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
    return false unless check_for_great?(x)
    return false unless check_for_equal?(x) && check_for_low?(x)
    return false unless check_for_loworequal?(x) && check_for_greatorequal?(x)
    true
  end

  def check_for_equal?(x)
    if @options.has_key?(:equal) && x != @options[:equal]
      false
    else
      true
    end
  end

  def check_for_low?(x)
    if @options.has_key?(:low) && x >= @options[:low]
      false
    else
      true
    end
  end

  def check_for_great?(x)
    if @options.has_key?(:great) && x <= @options[:great]
      false
    else
      true
    end
  end

  def check_for_loworequal?(x)
    if @options.has_key?(:loworequal) && x > @options[:loworequal]
      false
    else
      true
    end
  end

  def check_for_greatorequal?(x)
    if @options.has_key?(:greatorequal) && x < @options[:greatorequal]
      false
    else
      true
    end
  end
end
