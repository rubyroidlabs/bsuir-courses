# It can send messages
class Status < Command
  def initialize(bot, message)
    super(bot, message)
    @str = []
    @to_do = nil
  end

  def how_much?(time_now, time_end, time_start, count)
    @to_do = (((time_now - time_start).to_f) / (time_end - time_start).to_f * count.to_i).to_i + 1
    if @to_do > count.to_i
      @to_do = count.to_i
    elsif @to_do.negative?
      @to_do = 0
    end
    @to_do
  end

  def must_be_done(count, sem_start, sem_end)
    time_start = Time.new(sem_start.year, sem_start.month, sem_start.day)
    time_end = Time.new(sem_end.year, sem_end.month, sem_end.day)
    time_now = Time.new
    how_much?(time_now, time_end, time_start, count)
  end
  attr_accessor :str
  attr_accessor :hash
end
