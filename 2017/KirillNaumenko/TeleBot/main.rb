require 'telegram/bot'
require_relative 'is_non_format'

YES = 'Yes'.freeze
NO = 'No'.freeze

class Bot
  def initialize(token)
    @token = token
  end

  def check_name(bot, message)
    true_name = SearchByName.full_name_by_part(message.text)
    if true_name.nil?
      nil
    else
      bot.api.sendMessage(chat_id: message.chat.id, text: "#{true_name}?")
      name_right(bot, true_name)
    end
  end

  def name_right(bot, true_name)
    bot.listen do |message|
      if message.text == YES
        return SearchByName.orient_by_name(true_name)
      elsif message.text == NO
        bot.api
           .sendMessage(chat_id: message.chat.id, text: "Maybe #{true_name}?")
        SearchByName.full_name_by_part(true_name)
      end
    end
  end

  def launch
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        orient = if message.text.split.size == (1 || 0)
                   check_name(bot, message)
                 elsif SearchByName.orient_by_name(message.text)
                 end
        if orient.nil?
          bot.api.sendMessage(chat_id: message.chat.id, text: 'No data')
        else
          bot.api.sendMessage(chat_id: message.chat.id, text: orient)
        end
      end
    end
  end
end

mono_bot = Bot.new('428735309:AAGuPbFwJp5xmN1oaZTl7vcfOBgP44QiqyY')
mono_bot.launch
