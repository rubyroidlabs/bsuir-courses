def initialization
  @begin = begin_sem
  @end = end_sem
  @num = num
  all = (end_sem - begin_sem)
end

def lab_num (num)
  @lab = (all - @today) / (num / all) 
end
