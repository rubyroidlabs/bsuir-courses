require "telegram/bot"
require "date"
require "require_all"
require_all "lib"

token = "242688245:AAFKh_rAnQMSaLOyk2dVB52sgSSQjt6z2y4"
@month_hash = { "September" => 30, "October" => 31, "November" => 30, "December" => 31, "January" => 31, "February" => 28, "March" => 31, "April" => 30, "May" => 31 }
@hash = {}

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when "/start"
      bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}! I'm gonna help you to pass labs. Here's my commands:\n/start - greeting and help\n/semester - remembers dates of beginning and end of current semester\n/subject - adds subject and amount of labs\n/status - shows list of labs you're going to pass\n/reset - remove user's data")
    when "/semester"
      question_month = "Enter month"
      question_year = "Enter year"
      question_day = "Enter day"
      bot.api.sendMessage(chat_id: message.chat.id, text: "When semester starts?")

      answers_one = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @month_hash.keys.each_slice(3).to_a, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question_month, reply_markup: answers_one)
      bot.listen do |answer|
        @month = answer.text
        break
      end

      answers_two = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: (1..@month_hash[@month.to_s]).to_a.map(&:to_s).each_slice(8).to_a, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question_day, reply_markup: answers_two)
      bot.listen do |answer|
        @day = answer.text
        break
      end

      answers_three = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(2016), %w(2017)], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question_year, reply_markup: answers_three)
      bot.listen do |answer|
        @year = answer.text
        break
      end

      @date1 = Date.parse(@month + " " + @day + " " + @year)
      bot.api.sendMessage(chat_id: message.chat.id, text: "Starts: #{@date1}")

      bot.api.sendMessage(chat_id: message.chat.id, text: "When semester ends?")
      bot.api.send_message(chat_id: message.chat.id, text: question_month, reply_markup: answers_one)
      bot.listen do |answer|
        @month = answer.text
        break
      end

      answers_new = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: (1..@month_hash[@month.to_s]).to_a.map(&:to_s).each_slice(8).to_a, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question_day, reply_markup: answers_new)
      bot.listen do |answer|
        @day = answer.text
        break
      end
      bot.api.send_message(chat_id: message.chat.id, text: question_year, reply_markup: answers_three)
      bot.listen do |answer|
        @year = answer.text
        break
      end

      @date2 = Date.parse(@month + " " + @day + " " + @year)
      bot.api.sendMessage(chat_id: message.chat.id, text: "Ends: #{@date2}")
      if diff(@date1, @date2) == true
        bot.api.sendMessage(chat_id: message.chat.id, text: "There's still #{@time} day(s) left")
      else
        bot.api.sendMessage(chat_id: message.chat.id, text: "Time is up!")
      end

    when "/subject"
      bot.api.sendMessage(chat_id: message.chat.id, text: "Enter subject's name:")
      bot.listen do |answer|
        @subject = answer.text
        break
      end
      bot.api.sendMessage(chat_id: message.chat.id, text: "Enter amount of labs you have to pass:")
      bot.listen do |answer|
        if !/\A[+-]?\d+(\.\d+)?([eE]\d+)?\Z/.match(answer.text) == true
          bot.api.sendMessage(chat_id: message.chat.id, text: "Wrong data! Once again:")
        else
          @labs = answer.text
          bot.api.sendMessage(chat_id: message.chat.id, text: "Got it!")
          break
        end
      end
      @hash = @hash.merge(Hash[@subject, @labs])

    when "/status"
      if @time.nil?
        bot.api.sendMessage(chat_id: message.chat.id, text: "You haven't enter semester information.")
      else
        bot.api.sendMessage(chat_id: message.chat.id, text: "There's still #{@time} day(s) left")
        @hash.each do |key, value|
          donelabs(value.to_i)
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{key} - #{@done} of #{value} labs have to be passed for today")
        end
      end
    when "/reset"
      @hash = {}
      @time = nil
      @timeall = nil
      bot.api.sendMessage(chat_id: message.chat.id, text: "All data was removed.")
    end
  end
end
