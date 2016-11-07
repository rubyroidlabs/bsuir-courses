#class Date
#	attr_accessor :end_sem

	def initislization
		@end_sem = end_sem
	end

	def sem_date (begin_sem, end_sem)
		a = Date.today
		@today = (end_sem - a).to_i
		true
	end

	def valid?(date_string)
		x = Date.parse(date_string).to_s
		y, m, d = x.split "-"
		Date.valid_date? y.to_i, m.to_i, d.to_i
			return true
		rescue
			return false
	end

#end