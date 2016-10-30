class DateParser
	def initialize(date)
		timeAr = []
		0.upto(2) do |i|
		  timeAr[i] = date[0..date.index(".").to_i-1]
		  date = date[(date.index(".").to_i+1)..date.size]
	  end
	  @day = timeAr[0].to_i
	  @month = timeAr[1].to_i
	  @year = timeAr[2].to_i
	end

	def self.difference(date_end, date_start)
		year_diff = date_end.year - date_start.year
		if date_end.month - date_start.month < 0
			year_diff-=1
			month_diff = date_end.month - date_start.month + 12
	  else 
	  	month_diff = date_end.month - date_start.month
	  end
	  if date_end.day - date_start.day < 0
			month_diff-=1
			day_diff = date_end.day - date_start.day + 30
	  else 
	  	day_diff = date_end.day - date_start.day
	  end
	  case month_diff
	  when 1
	    month_diff_str = "1 месяц"
	  when 2..4
	    month_diff_str = month_diff.to_s + " месяца"
	  else
	    month_diff_str = month_diff.to_s + " месяцев"
	  end
	  case day_diff
	  when 1
	  	day_diff_str = "1 день"
	  when 2..4
	  	day_diff_str = day_diff.to_s + " дня"
	  else
	  	day_diff_str = day_diff.to_s + " дней"
	  end
	  if month_diff.zero?
	    "На всё про всё у нас *#{day_diff_str}*"
	  elsif day_diff.zero?
	  	"На всё про всё у нас *#{month_diff_str}*"
	  else "На всё про всё у нас *#{month_diff_str}* и *#{day_diff_str}*"
	  end
	end

	def self.is_correct?(date)
    if (date =~ /\d\d.\d\d.\d\d\d\d$/).nil? then return false end
    timeAr = []
    if date.index(".").nil? then return false end
    0.upto(2) do |i|
		  timeAr[i] = date[0..date.index(".").to_i-1]
		  date = date[(date.index(".").to_i+1)..date.size]
	  end
	  day = timeAr[0].to_i
	  month = timeAr[1].to_i
	  year = timeAr[2].to_i
	  if day <= 0 || day > 31 || month <= 0 || month > 12 || (Time.now.year - year).abs > 1 then return false end
	  return true
  end

  	def self.is_correct_count?(labs_count)
	  if labs_count.to_i <= 0 || labs_count.to_i > 25 then return false end
	  return true
  end

	attr_accessor :day
	attr_accessor :month
	attr_accessor :year
end
