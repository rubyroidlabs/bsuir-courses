require 'telegram/bot'
require_relative 'config.rb'
require 'yaml'
require_relative '../console.rb'

class Command
  def initialize(message, user)
    @console = Console.new
    @user = user
    @token = YAML.load_file('../token.yml')['TOKEN']
    @message = message
    @api = Telegram::Bot::Api.new(@token)
  end

  def send_message(text, chat_id, shit = nil)
    @api.call('sendMessage', chat_id: chat_id.to_s, text: text.to_s, reply_markup: shit)
  end

  def edit_message_text(text, message)
    @api.call('editMessageText', text: text.to_s, chat_id: message.from.id.to_s, message_id: message.message.message_id.to_s, disable_web_page_preview: true)
  end

  def inline_query(buttons)
    kb = []
    buttons.each do |i|
      kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: i.to_s, callback_data: i.to_s)
    end
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, one_time_keyboard: true)
    send_message('Выбирай', @message.from.id, markup)
  end

  def hide_year_keyboard
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: YEAR_KB, one_time_keyboard: true, resize_keyboard: true)
  end

  def hide_month_keyboard
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: MONTHS_KB, one_time_keyboard: true, resize_keyboard: true)
  end

  def hide_day_keyboard
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: DAYS_KB, one_time_keyboard: true, resize_keyboard: true)
  end

  def side_yes_no_keyboard
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: YES_NO_KB, one_time_keyboard: true, resize_keyboard: true)
  end

  def side_command_keyboard
  end
end
