
class Start < Bot1
	def start
		bot.api.sendMessage(chat_id: message.chat.id, text: HELP)
	end
end		