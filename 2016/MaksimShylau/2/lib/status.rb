# It can send messages
class Status < Command
  def initialize(bot, message)
    super(bot, message)
    @str = []
    @to_do = nil
  end

  def must_be_done(count, start, s_end)
    time_start = Time.new(start.year, start.month, start.day)
    time_end = Time.new(s_end.year, s_end.month, s_end.day)
    time_now = Time.new
    to_do = (((time_now - time_start).to_f) / (time_end - time_start).to_f * count.to_i).to_i + 1
    if to_do > count.to_i
      to_do = count.to_i
    elsif to_do.negative?
      to_do = 0
    end
    to_do
  end
  attr_accessor :str
  attr_accessor :hash
end
