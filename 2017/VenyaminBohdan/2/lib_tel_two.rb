require 'telegram/bot'
require_relative 'lib_file_two.rb'
require_relative 'lib_upload_two.rb'

class Telgrm
  @@txt = File_actors.new('data.txt')
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
        puts message.text
        if message.text == 'upload'
          charge  = Upload.new
          charge.surfing
          charge.data
          @@arr_stars = @@txt.file_read
          next
        end
        no_gays_count = 0
        name_count = 0
        @@arr_stars.each do |i|
          name_count += 1
          name = i.chop
          puts i.length
          puts i
          if message.text.include? name
            bot.api.sendMessage(chat_id: message.chat.id, text: "This is gay \n#{@@arr_stars[name_count]}")
            break
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
