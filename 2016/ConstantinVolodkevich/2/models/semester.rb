require 'date'
class Semester
  attr_accessor :ending_date
  def initialize
    @ending_date = ''
  end
  def time_left(ending_date)
    curr_time = Time.new
    curr_date = Date.parse curr_time.inspect
    ending_date = ending_date
    days = ( ending_date - curr_date).to_i
    month = 0
    while days > 30 do
      days -= 30
      month += 1
    end
    "Got it! You got #{month} months and #{days} days left!"
  end
end
