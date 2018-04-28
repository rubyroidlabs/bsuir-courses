# frozen_string_literal: true

require_relative 'message_sender'
require_relative '../../models/user'
require_relative '../../models/search_request'

class MessageResponder
  attr_reader :message, :bot, :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id.to_s)
  end

  def respond; end

  private

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
