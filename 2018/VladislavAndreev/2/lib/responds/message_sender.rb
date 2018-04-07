# frozen_string_literal: true

class MessageSender
  attr_reader :bot
  attr_reader :text
  attr_reader :chat

  def initialize(options)
    @bot = options[:bot]
    @text = options[:text]
    @chat = options[:chat]
  end

  def send
    bot.api.send_message(chat_id: chat.id, text: text, parse_mode: 'Markdown')
  end
end
