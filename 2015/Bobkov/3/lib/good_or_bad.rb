require 'unicode_utils'

class GoodOrBad
  attr_reader :how

  def initialize
    @yml = YAML::load(File.open('keywords.yml'))
    @how
  end

  def know(text)
    text = UnicodeUtils.downcase(text)
    i = 0
    @yml['negative'].each do |n|
      if text.include?(n)
        i -= 1
      end
    end
    @yml['positive'].each do |p|
      if text.include?(p)
        i += 1
      end
    end
    if i > 0
      @how = 'positive'
    elsif i < 0
      @how = 'negative'
    else
      @how = 'nil'
    end
  end
end
