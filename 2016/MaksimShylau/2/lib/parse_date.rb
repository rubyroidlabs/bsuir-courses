# Parses date and some data
class DateParser
  def time_array(date)
    ar = []
    0.upto(2) do |i|
      ar[i] = date[0..date.index(".").to_i - 1]
      date = date[(date.index(".").to_i + 1)..date.size]
    end
    ar
  end

  def initialize(date)
    ar = time_array(date)
    @day = ar[0].to_i
    @month = ar[1].to_i
    @year = ar[2].to_i
  end

  def self.month_difference(date_end, date_start)
    difference = date_end.month - date_start.month
    month_diff = if difference.negative?
                   difference + 12
                 else
                   difference
                 end
    month_diff -= 1 if (difference).negative?
    month_diff
  end

  def self.day_difference(date_end, date_start)
    if (date_end.day - date_start.day).negative?
      day_diff = date_end.day - date_start.day + 30
    else
      day_diff = date_end.day - date_start.day
    end
    day_diff
  end

  def self.month_str(month_diff)
    case month_diff
    when 1
      month_diff_str = "1 месяц"
    when 2..4
      month_diff_str = month_diff.to_s + " месяца"
    else
      month_diff_str = month_diff.to_s + " месяцев"
    end
    month_diff_str
  end

  def self.day_diff(day_diff)
    case day_diff
    when 1
      day_diff_str = "1 день"
    when 2..4
      day_diff_str = day_diff.to_s + " дня"
    else
      day_diff_str = day_diff.to_s + " дней"
    end
    day_diff_str
  end

  def self.difference(date_end, date_start)
    month_diff = month_difference(date_end, date_start)
    day_diff = day_difference(date_end, date_start)
    month_diff_str = month_str(month_diff)
    day_diff_str = day_diff(day_diff)
    if month_diff.zero?
      "На всё про всё у нас *#{day_diff_str}*"
    elsif day_diff.zero?
      "На всё про всё у нас *#{month_diff_str}*"
    else "На всё про всё у нас *#{month_diff_str}* и *#{day_diff_str}*"
    end
  end

  def get_time_ar(date)
    time_ar = []
    0.upto(2) do |i|
      time_ar[i] = date[0..date.index(".").to_i - 1]
      date = date[(date.index(".").to_i + 1)..date.size]
    end
    time_ar
  end

  def self.get_date(date)
    time_ar = get_time_ar(date)
    day = time_ar[0].to_i
    month = time_ar[1].to_i
    year = time_ar[2].to_i
    [day, month, year]
  end

  def self.correct?(date)
    day, month, year = get_date(date)
    check = day <= 0 || day > 31 || month <= 0 || month > 12 || (Time.now.year - year).abs > 1 || (date =~ /\d\d.\d\d.\d\d\d\d$/).nil? || date.index(".").nil?
    if check
      status = false
    else
      status = true
    end
    status
  end

  def self.correct_count?(labs_count)
    check = labs_count.to_i <= 0 || labs_count.to_i > 25
    if check
      status = false
    else
      status = true
    end
    status
  end
  attr_accessor :day
  attr_accessor :month
  attr_accessor :year
end
