class Rapper
  attr_accessor :nick, :text

  def initialize(nick, text)
    @nick = nick
    @text = text
    @wins = 0
    @loses = 0
  end

  def count_letters
    count = 0
    if ENV['CRITERIA'].empty?
      @text.each { |text| count += text.scan(/\w/).size }
    else
      @text.each { |text| count += text.scan(/#{ENV['CRITERIA']}/).size }
    end
    count
  end
end
