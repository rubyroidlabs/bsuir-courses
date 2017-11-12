def initialization
  @begin = begin_sem
  @end = end_sem
  @num = num
end

def lab_num(num)
  all = (end_sem - begin_sem)
  @lab = (all - @today) / (num / all)
end
