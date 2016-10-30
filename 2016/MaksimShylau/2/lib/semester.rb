# It can send messages
class Semester < Command
	def initialize(bot, message)
		super(bot, message)
		sem_start = nil
		sem_end = nil
	end
	attr_accessor :sem_start
	attr_accessor :sem_end
end
