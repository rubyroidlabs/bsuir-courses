require 'rubygems'
require 'telegram/bot'
require_relative 'data_creator.rb'
include Base

creation
token = '483045194:AAFCJTWGRniQ4Wkmjst_TE7Hdr9rS_miaSI'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    names = reading
    if names.include?(message.text)
      bot.api.sendMessage(chat_id: message.chat.id, text: 'Did coming out')
    else
      bot.api.sendMessage(chat_id: message.chat.id, text: 'Info not found')
    end
  end
end
