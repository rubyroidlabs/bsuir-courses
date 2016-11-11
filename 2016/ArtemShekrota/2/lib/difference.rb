# length of semester and left time
def diff(date1, date2)
  today = Date.today
  if date2 > today
    @time = (date2 - today).to_i
    @timeall = (date2 - date1).to_i
    true
  else
    false
  end
end
