require 'telegram/bot'
require_relative 'lib/start'
require_relative 'lib/base'
require_relative 'lib/help'
require_relative 'lib/set_repo'
require_relative 'lib/show_repo'
require_relative 'lib/search'
require_relative 'lib/history'

token = '581093532:AAFnA2apTDoU2WwtL9feOskYXIqA1UCOClk'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    Thread.start(message) do |message|
      chat_id = message.chat.id

      begin
        case message.text
        when "/start"
          bot.api.send_message(chat_id: chat_id, text: 'Use /help what see all command')
        when /^\/set_repo http(s)?:\/\/github.com(.)*$/i
          set_repo = SetRepo.new(bot, chat_id)
          repository = message.text.gsub("/set_repo ", '')
          set_repo.save_repo(repository)
        when "/show_repo"
          show_repo = ShowRepo.new(bot, chat_id)
          show_repo.get_repo
        when "/reset"
          set_repo = SetRepo.new(bot, chat_id)
          set_repo.save_repo('')
        when /^\/search (.)+/
          search = Search.new(bot, chat_id)
          query = message.text.gsub("/search ", '')
          if query.empty?
            bot.api.send_message(chat_id: chat_id, text: 'You don\'t input search query')
          else
            search.commits(query)
          end
        when "/history"
          History.new(bot, chat_id).send_messages
        when "/help"
          help = Help.new(bot, chat_id)
          help.send_messages
        else
          bot.api.send_message(chat_id: chat_id, text: 'I don\'t understand you :(')
        end
      rescue Exception => e
        bot.api.send_message(chat_id: chat_id, text: "Something doing wrong!!! #{e.message}")
        puts e.backtrace.inspect
      end

    end
  end
end