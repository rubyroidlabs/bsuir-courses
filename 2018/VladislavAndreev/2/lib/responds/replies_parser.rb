# frozen_string_literal: true

require_relative 'help'
require_relative 'history'
require_relative 'search'
require_relative 'set_repo'
require_relative 'show_repo'
require_relative 'message_sender'

class RepliesParser
  attr_reader :bot, :message

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
  end

  def parse
    options = { bot: bot, message: message }

    case message.text
    when %r{\/set_repo\ https:\/\/github.com\/[\d\w\-._]+\/[\d\w\-._]+}i
      SetRepoResponder.new(options).respond

    when %r{^\/show_repo}
      ShowRepoResponder.new(options).respond

    when %r{^\/search?\ .+}
      SearchResponder.new(options).respond

    when %r{^\/history}
      HistoryResponder.new(options).respond

    when %r{^\/help}
      HelpResponder.new(options).respond

    else
      MessageSender.new(bot: bot, chat: message.chat,
                        text: 'Я не знаю такой команды. Может /help?').send
    end
  end
end
