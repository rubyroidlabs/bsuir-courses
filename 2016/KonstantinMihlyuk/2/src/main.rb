require "telegram/bot"
require "redis"

require_relative "./commands/start.rb"
require_relative "./commands/semester.rb"
require_relative "./commands/subject.rb"
require_relative "./commands/status.rb"
require_relative "./commands/submit.rb"
require_relative "./commands/reset.rb"
require_relative "./commands/subject_remove.rb"
require_relative "./commands/remind.rb"
require_relative "./database.rb"
require_relative "constants/constants.rb"

database = Redis.new
database.set("token", TOKEN)

waiting_commands = {}

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    user_id = message.from.id
    db = Database.new
    user = db.user(user_id) ? db.user(user_id) : db.create_user(user_id)

    default_command = DEFAULT_COMMANDS.find { |command| "/#{command.to_s.downcase}" == message.text }
    command = default_command ? default_command.new(user) : waiting_commands[user_id]

    if command
      waiting_commands.delete(user_id)
      answer = command.say(message.text)

      if command.dialog_ended
        db.update(command.to_hash, user_id)
      else
        waiting_commands[user_id] = command
      end

      bot.api.send_message(chat_id: user_id, text: answer) if answer
    end
  end
end
