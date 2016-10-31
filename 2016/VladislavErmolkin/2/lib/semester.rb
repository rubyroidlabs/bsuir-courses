require_relative 'action'
require_relative 'user'
require 'json'
require 'time_difference'

DATE_REGEX = /^\d{2,4}-\d{1,2}-\d{1,2}$/

class Semester < Action
	attr_reader :user

	def initialize(user, text)
		puts 'IN SEM INITIALIZE.'
		super()
		@text = text
		@user = user
	end

	def text_validation
		case @user.sem_phase
		when 0
			if @text.gsub("\n", "") == '/semester'
				return true
			end
		when 1..2
			if is_date? @text.gsub("\n", "")
				return true
			end
		end
		false
	end

	def run
		puts 'IN RUN'
		puts "text_validation returns #{text_validation}."
		if !text_validation
			@user.sem_phase = 0
			@user.sem_process_now = false
			@user.save
			return nil
		end
		case @user.sem_phase
		when 0
			@user.sem_phase += 1
			@user.sem_process_now = true
			result = 'Когда начинаем учиться?'
		when 1
			@user.sem_start = @text.gsub("\n", "")
			@user.sem_phase += 1
			result = 'Когда надо сдать все лабы?'
		when 2
			@user.sem_end = @text.gsub("\n", "")
			@user.sem_phase = 0
			@user.sem_process_now = false
			result = native_difference generate_difference @user.sem_start, @user.sem_end
		end
		puts "In run sem_phase = #{@user.sem_phase}."
		@user.save
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

	def is_date?(string)
	    if string.match(DATE_REGEX) then true
	    else false
    end
  end
end


# text = gets
# sem = Semester.new 12, '/semester'
# p sem.run

