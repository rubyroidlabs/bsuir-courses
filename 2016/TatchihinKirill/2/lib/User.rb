require_relative 'MainCommand.rb'
class User
	require 'date'
	attr_accessor :action, :name, :start_semester, :end_semester, :subjects
	def initialize(action = '/start', name = 'Man', start_semester = '2016-09-01', end_semester = '2016-12-25', subjects = {})
		@action = action
		@name = name
		@subjects = subjects
		@start_semester = start_semester
		@end_semester = end_semester
	end
	def calculate_semester_for_first_or_second_course(semester)
		if semester.mon >= 9
			@start_semester = '2016-09-01'
			@end_semester = '2016-12-25'
		else
			@start_semester = '2017-02-07'
			@end_semester = '2017-05-31'
		end
	end
	def calculate_semester_for_third_or_greater_course(semester)
		if semester.mon >= 9
			@start_semester = Date.new(2016,9,1)
			@end_semester = Date.new(2016,12,10)
		else
			@start_semester = Date.new(2017, 1, 17)
			@end_semester = Date.new(2017, 5, 10)
		end
end
	def semester_calculate(bot, message, text, command)
		semester = Date.today
		check = true
		case text
		when /1/, /2/
			calculate_semester_for_first_or_second_course(semester)
			check = false
		when /3/, /4/, /5/
			calculate_semester_for_third_or_greater_course(semester)
			check = false
		else
				bot.api.send_message(chat_id: message.chat.id, text: "Слушай, введи свой курс цифрой, пожалуйста, ну введи, не страдай ерундой, тебе же уже за 18")
				command = 'semester'
		end
		check
	end

	def load_object(id)
		temp = 0
		if File.exist?("./users/#{id}")
			file_to_upload = IO.readlines("./users/#{id}")
			subject = ""
			file_to_upload = MainCommand.delete_special_chars(file_to_upload, "\n")
			file_to_upload.each do |line|
				if line.include?("Subject:")
					subject = line.delete!("Subject:")
				end
			 if line.include?("Count of labs:")
				 @subjects[subject.to_sym] = line.delete!("Count of labs:")
				end
			end
		end
	end
end
