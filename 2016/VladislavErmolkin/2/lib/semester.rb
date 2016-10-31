require_relative 'action'
require_relative 'user'
require 'json'
require 'time_difference'

class Semester < Action
	attr_reader :user

	def initialize(id, text)
		super()
		@id = id
		@text = text
		@user = parse_user
	end

	def parse_user
		path = "../users/user_#{@id}.txt"
		file = File.exist?(path) ? File.open(path, 'r+') : File.new(path, 'w')
		user =  File.zero?(path) ? User.new({}) : User.new(JSON.parse file.read)
		file.close
		user
	end

	def save_user
		path = "../users/user_#{@id}.txt"
		file = File.open(path, 'w')
		file.print JSON.generate @user.to_hash
		file.close
	end

	def run
		result = case @user.sem_phase
		when 0
			@user.sem_phase += 1
			'Когда начинаем учиться?'
		when 1
			@user.sem_start = @text.gsub("\n", "")
			@user.sem_phase += 1
			'Когда надо сдать все лабы?'
		when 2
			@user.sem_end = @text.gsub("\n", "")
			@user.sem_phase = 0
			native_difference generate_difference @user.sem_start, @user.sem_end
		end
		save_user
		result
	end

	def generate_difference(first_date, second_date)
		TimeDifference.between(Time.parse(first_date), Time.parse(second_date)).in_general
	end

	def native_difference(diff)
		month = case diff[:months]
		when 1 then 'месяц'
		when 2..4 then 'месяца'
		else 'месяцев'
		end
		week = case diff[:weeks]
		when 1 then 'неделя'
		when 2..4 then 'недели'
		else 'недель'
		end
		day = case diff[:days]
		when 1 then 'день'
		when 2..4 then 'дня'
		else 'дней'
		end
		"Понял, на все про все у нас #{diff[:months]} #{month}, #{diff[:weeks]} #{week} и #{diff[:days]} #{day}."
	end
end


# text = gets
# sem = Semester.new 3, text
# p sem.run