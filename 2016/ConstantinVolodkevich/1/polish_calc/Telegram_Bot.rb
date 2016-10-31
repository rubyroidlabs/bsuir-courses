require 'telegram/bot'
require './rpn_calc'
require "open-uri"
require 'logger'
require './parser'


token = '278148159:AAFq22aoGX0_rdCqQxQ9W2SfAcOs3oj4A0A'

File.open('photo.jpg', 'wb') do |fo|
  fo.write open("https://pp.vk.me/c638721/v638721520/63f1/RjDz_QIwe84.jpg").read
end

logger = Logger.new('logfile.log')

AUTHOR_TEXT = "The author of this amazing bot is Constantin Volodkevich, inspired by Alexander Adamenko from Vienna - WHO LET THE BOTS OUT?"
HELP = "Domo arigato mister roboto! I'm your personal polish notation calculator. Feel free to ask whatever you want!
Here is some sample commands to run:
/author
/start
To use polish calculator functions just type in equation in proper polish notation, where numbers are separated by whitespaces."

Telegram::Bot::Client.run(token) do |bot|

  calculator = RPN_calc.new
  parser = Parser.new


  bot.listen do |message|

    logger.info(message.from.first_name.to_s + " " + message.from.last_name.to_s + ": " + message.text.to_s)

    p message.text

    case message.text

      when nil

      when "/author"

        bot.api.sendMessage(chat_id: message.chat.id, text: AUTHOR_TEXT)
        begin
        bot.api.send_photo(chat_id: message.chat.id, photo: Faraday::UploadIO.new("./photo.jpg", 'image/jpeg'))
        rescue => e
          puts "Rescue : #{e}"
        rescue Timeout::Error => te
          puts "Rescued from timeout : #{te}"
        end
      when "/start"

        bot.api.sendMessage(chat_id: message.chat.id, text: HELP)

      else

        result = calculator.calc(message.text)
        bot.api.sendMessage(chat_id: message.chat.id, text: "So, your task was #{parser.initial_equation(message.text)} and the result is... #{result}")

    end

  end

end