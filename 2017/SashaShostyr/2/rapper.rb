class Rapper
  attr_accessor :nickname, :text

  def initialize(nickname, text)
    @nickname = nickname
    @text = text
  end

  def get_count
    count = 0
    if ENV['CRITERIA'].nil?
      @text.each { |el| count += el.scan(/\w/).size }
    else
      @text.each { |el| count += el.scan(/#{ENV['CRITERIA']}/).size }
    end
    count
  end
end
