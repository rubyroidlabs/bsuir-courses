# amount of labs that has to be done
def donelabs(tasks)
  days_per_task = @timeall / tasks
  days_gone = @timeall - @time
  @done = days_gone / days_per_task
end
