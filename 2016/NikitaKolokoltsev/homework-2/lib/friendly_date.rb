# Date processing
class FriendlyDate
  attr_accessor :day, :month, :year

  def initialize(date_str)
    if date_str.split(".").size == 3
      divide_symbol = "."
    elsif date_str.split("/").size == 3
      divide_symbol = "/"
    elsif date_str.split("-").size == 3
      divide_symbol = "-"
    end
    convert(date_str, divide_symbol)
    raise DateFormatError unless Date.valid_date?(@year, @month, @day)
  end

  def convert(date_str, divide_symbol)
    @day = date_str.split(divide_symbol)[0].to_i
    @month = date_str.split(divide_symbol)[1].to_i
    @year = date_str.split(divide_symbol)[2].to_i
  end

  def bigger_than?(date)
    DateTime.parse(to_s).mjd - DateTime.parse(date.to_s).mjd > 0
  end

  def -(other)
    date_start = DateTime.parse(other.to_s)
    date_end = DateTime.parse(to_s)
    time_left = Time.diff(date_start, date_end)
    days_left = time_left[:day] + time_left[:week] * 7
    months_left = time_left[:month]
    years_left = time_left[:year]
    correct(days_left, months_left, years_left)
  end

  def correct(days_left, months_left, years_left)
    years_left += 1 if months_left >= 12
    days_left = 0 if months_left >= 12
    months_left = 0 if months_left >= 12
    { days: days_left, months: months_left, years: years_left }
  end

  def days_left_until(date)
    date_start = DateTime.parse(to_s).mjd
    date_end = DateTime.parse(date.to_s).mjd
    date_end - date_start
  end

  def to_s
    DateTime.parse("#{year}.#{month}.#{day}").strftime("%d.%m.%Y")
  end
end
