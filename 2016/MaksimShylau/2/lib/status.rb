class Status < Command
	def initialize(bot, message)
		super(bot, message)
		@str = []
		@to_do = nil
	end

  def must_be_done(labs_count, sem_start, sem_end)
    time_start = Time.new(sem_start.year, sem_start.month, sem_start.day)
		time_end = Time.new(sem_end.year, sem_end.month, sem_end.day)
		time_now = Time.new
		k = ((time_now - time_start).to_f) / (time_end-time_start).to_f
		to_do = k * labs_count.to_i
		to_do = to_do.to_i + 1
		if to_do > labs_count.to_i
			to_do = labs_count.to_i
		elsif to_do < 0
			to_do = 0
		end
    return to_do
	end
	attr_accessor :str
  attr_accessor :hash
end
