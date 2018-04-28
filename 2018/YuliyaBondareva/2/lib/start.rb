require_relative 'base'
class Start < Base
	def send_messages
		telegram_send_message('Hello! Have a nice day! if you don\'t know what to do enter /help' )
	end
end
