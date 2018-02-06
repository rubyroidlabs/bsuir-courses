require 'telegram/bot'
require 'pry'
require 'json'
require 'translit'
require 'fuzzy_match'
require_relative 'get_came_out.rb'
require_relative 'user.rb'

class Bot
  def initialize(token)
    @token = token
    ParseLgbt.new.go_and_find
    my_hash = File.read('selebrities_hash.txt')
    @base_hash = JSON.parse(my_hash)
  end

  def work
    Telegram::Bot::Client.run(@token) do |bot|
      puts 'Bot started!'
      bot.listen do |message|
        user = User.new(message.from.first_name,
                        message.from.last_name,
                        message.chat.id)
        case message.text
        when '/start'
          bot.api.send_message(chat_id: user.getid, text:
            "Hey, #{user.getname}!")
        when '/stop'
          bot.api.send_message(chat_id: user.getid, text:
            "Bye, #{user.getsurname} :C")
        when message.text
          handle_request(bot, user, message.text.downcase)
        end
      end
    end
  end

  def handle_request(bot, user, text)
    if text.scan(/[а-яА-Я]/).length.zero?
      message_in_english(bot, user, text)
    else
      message_in_russian(bot, user, text)
    end
  end

  def message_in_russian(bot, user, text)
    translited = Translit.convert(text, :english)
    names = @base_hash.keys
    finded = FuzzyMatch.new(names).find(translited.downcase)
    if finded.nil?
      bot.api.send_message(chat_id: user.getid, text:
        "Did you mean '#{translited}'?")
      conclusion(bot, user, translited)
    else
      bot.api.send_message(chat_id: user.getid, text:
        "Did you mean '#{finded}'?")
      conclusion(bot, user, finded)
    end
  end

  def message_in_english(bot, user, text)
    names = @base_hash.keys
    finded = FuzzyMatch.new(names).find(text)
    if finded == text
      find_in_base(bot, user, finded)
    else
      bot.api.send_message(chat_id: user.getid, text:
        "Did you mean '#{finded}'?")
      conclusion(bot, user, finded)
    end
  end

  def conclusion(bot, user, text)
    bot.listen do |message|
      case message.text.downcase
      when 'да', 'da', 'yes', 'Да', 'Da', 'Yes'
        bot.api.send_message(chat_id: user.getid, text: "Okay, let's watch")
        find_in_base(bot, user, text)
        return true
      else
        bot.api.send_message(chat_id: user.getid, text:
          "Then, you'd better check the name you've entered")
        return false
      end
    end
  end

  def find_in_base(bot, user, text)
    if @base_hash[text].nil?
      bot.api.send_message(chat_id: user.getid, text: "I don't know such" \
        + ' person, may be he/she is not gay or he/she will' \
        + ' be added in database later')
    else
      answer = "#{text} - #{@base_hash[text].downcase}"
      bot.api.send_message(chat_id: user.getid, text: answer)
    end
  end
end
