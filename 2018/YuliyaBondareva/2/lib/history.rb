require_relative 'base'

class History < Base
	def send_messages
		lines = IO.readlines("./chat_ids/#{@user_id}_history")
		last = lines.last(10)
		telegram_send_message(last.join(''))
	end
end