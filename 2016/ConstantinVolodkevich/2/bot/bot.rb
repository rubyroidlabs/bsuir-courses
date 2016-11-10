require 'telegram/bot'
require "open-uri"
require 'logger'
require '../controllers/user_manager'


token = '294495126:AAEah6QjTeD7fbrkXMsoFCw0sKWngSVn0Yg'

logger = Logger.new('logfile.log')

user_manager = User_Manager.new
$thread = {}

Telegram::Bot::Client.run(token) do |bot|

  bot.listen do |message|

    user_manager.check_user(message.from.first_name, message.from.last_name, message.from.id)

    #p message
    case message

      when Telegram::Bot::Types::CallbackQuery

        if user_manager.get_user(message.from.id).user_status.steps_submit['submit_lab']
          bot.api.sendMessage(chat_id:message.from.id, text:user_manager.submit_lab(message.from.id, message.data))
        end

        if user_manager.get_user(message.from.id).user_status.steps_submit['check_subject']
          keybutt = user_manager.make_labs_list(message.from.id, message.data)
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keybutt)
          bot.api.send_message(chat_id: message.from.id, text: 'Which lab?', reply_markup: markup)
        end

        if user_manager.get_user(message.from.id).user_status.steps_reminder['user_wanna_remind'] && !user_manager.get_user(message.from.id).user_status.steps_reminder['remind_on']
          if message.data == 'no'
            user_manager.save_reminders_step(message.from.id)
          else
            user_manager.save_reminders_step(message.from.id)
            timers = Timers::Group.new

            $thread[message.from.id] = Thread.new do
              e = timers.every(message.data.to_i) do
                bot.api.sendMessage(chat_id: message.from.id, text:user_manager.execute_status(message.from.id))
              end
              loop {timers.wait}
            end
          end
          bot.api.sendMessage(chat_id: message.from.id, text:'OK')
        end

      when Telegram::Bot::Types::Message
        logger.info([message.from.first_name, message.from.last_name, message.text.to_s].reject(&:nil?).join(' '))
        unless message.text.nil?
          if message.text[0] == '/'

            user_manager.update_steps(message.from.id)

            case message.text

              when nil

              when "/start"

                bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.execute_start)

              when "/semester"

                bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.execute_semester(message.from.id))

              when "/reset_semester"

                bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.execute_reset_semester(message.from.id))

              when "/subject"

                bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.execute_subject(message.from.id))

              when "/submit"
                keybutt = user_manager.execute_submit(message.from.id)
                markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keybutt)
                bot.api.send_message(chat_id: message.chat.id, text: 'What subject?', reply_markup: markup)

              when "/status"

                bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.execute_status(message.from.id))

              when "/reset"

                bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.execute_reset(message.from.id))

              when "/reminder"
                keybutt = user_manager.execute_reminder(message.from.id)
                markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keybutt)
                bot.api.send_message(chat_id: message.chat.id, text: 'When should I remind your status?', reply_markup: markup)

              else

                bot.api.sendMessage(chat_id: message.chat.id, text: "Invalid command")

            end
          end

          if message.text[0] != '/' && user_manager.get_user(message.from.id).user_status.steps_semester['set_ending_date']
            bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.save_ending_date(message.from.id, message.text))
          end

          if message.text[0] != '/' && user_manager.get_user(message.from.id).user_status.steps_subject['save_labs']
            bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.save_labs(message.from.id, message.text))
          end

          if message.text[0] != '/' && user_manager.get_user(message.from.id).user_status.steps_subject['save_subject']
            bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.save_subject(message.from.id, message.text))
          end

          if message.text[0] != '/' && user_manager.get_user(message.from.id).user_status.steps_reset['user_is_sure']
            bot.api.sendMessage(chat_id: message.chat.id, text:user_manager.reset_user(message.from.first_name, message.from.last_name, message.from.id, message.text))
          end
        end
    end
  end
end

