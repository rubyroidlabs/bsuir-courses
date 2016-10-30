class Semester < Command
	def initialize(bot, message)
		super(bot, message)
		sem_start = nil
		sem_end = nil
	end

	def get_date(bot)
		date = nil
		bot.listen do |get_date|
          date = get_date.text
          break if get_date.text != nil
        end
        return date
    end
	attr_accessor :sem_start
	attr_accessor :sem_end
end