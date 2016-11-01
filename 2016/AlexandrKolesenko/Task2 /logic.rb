#method returns how much time you have
def countdown(bgn_d, end_d)
  today = Date.today
  if end_d > today
    @eta = (end_d - today).to_i 
    @sum_of_days = (end_d - bgn_d).to_i
    true
  else
    false
  end
end

#method returns how much tasks you should accomplished already 
def taskcalc(tasks)
  days_per_task = @sum_of_days / tasks
  days_gone = @sum_of_days - @eta
  @accomplished = days_gone / days_per_task
end

#method checks input is date and if its valid in terms of calendar
def v_date?(date_string)
  x = Date.parse(date_string).to_s
  y, m, d = x.split "-"
  Date.valid_date? y.to_i, m.to_i, d.to_i
  return true
rescue
  return false
end
