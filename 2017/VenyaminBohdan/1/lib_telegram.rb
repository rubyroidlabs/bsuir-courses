require 'telegram/bot'
require_relative 'lib_file.rb'
require_relative 'lib_upload.rb'

class Telgrm
  @@txt = File_actors.new('actors.txt')
  @@arr_stars = @@txt.file_read
  @@token = '445668065:AAF6QEKpDBcHC54b_brJH9VaMCy8SRLWgcI'

  def notification(text_notification)
    Telegram::Bot::Client.run(@@token) do |bot|
      bot.listen do |message|
        if message.text == '/start'
          bot.api.sendMessage(chat_id: message.chat.id, text: text_notification)
        end
      end
    end
  end

  def dialog
    Telegram::Bot::Client.run(@@token) do |bot|
      bot.listen do |message|
        if message.text == 'upload'
          charge  = Upload.new
          note = charge.surfing
          @@arr_stars = @@txt.file_read
          next
        end
        no_gays_count = 0
        @@arr_stars.each do |i|
          name = i.chop
          if message.text == name
            bot.api.sendMessage(chat_id: message.chat.id, text: "This is gay")
            next
          else
            no_gays_count += 1
          end
        end
        if no_gays_count == @@arr_stars.size
          bot.api.sendMessage(chat_id: message.chat.id, text: "Nono not he")
        end
      end
    end
  end
end

