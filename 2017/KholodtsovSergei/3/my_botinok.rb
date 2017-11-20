require 'telegram/bot'
require 'translit'
require 'fuzzy_match'
require_relative 'celebrity'
TOKEN = '456850888:AAEaIee4C1OEb0zG6N7fSK2D1U6igx_r9yo'.freeze

class Mybotinok
  attr_accessor :message, :bot, :answer, :list_celebrity, :name_list

  def initialize(list_celebrity)
    @list_celebrity = list_celebrity
    @name_list = []
    @name_list = get_names
  end

  def run_bot
    Telegram::Bot::Client.run(TOKEN) do |bot|
      @bot = bot
      @bot.listen do |message|
        @message = message
        message_handler
      end
    end
  end

  def message_handler
    case @message.text
    when '/start'
      bot.api.sendMessage(chat_id: @message.chat.id, text: 'Hello, '\
      "#{@message.from.first_name}")
    when 'y'
      out_information(@name)
      @name_list = get_names
      bot.api.sendMessage(chat_id: @message.chat.id, text: @answer)
    when 'n'
      @name_list.delete(@name)
      match_search
      bot.api.sendMessage(chat_id: @message.chat.id, text: @answer)
    else
      match_search
      bot.api.sendMessage(chat_id: @message.chat.id, text: @answer)
    end
  end

  def match_search
    if @message.text.scan(/[А-Яа-я]/).any?
      english_message = Translit.convert(@message.text)
      name = FuzzyMatch.new(@name_list).find(english_message)
      create_answer(name)
    elsif @name_list.include? @message.text
      out_information(@message.text)
    else
      name = FuzzyMatch.new(@name_list).find(@message.text)
      create_answer(name)
    end
  end

  def create_answer(name)
    @answer = "Возможно вы имели в виду #{name} ? (y/n)"
    @name = name
  end

  def out_information(name)
    @list_celebrity.each do |item|
      if item.celebrity['name'] == name
        @answer = item.celebrity['orientation'] + item.celebrity['info']
      end
    end
  end

  def get_names
    @list_celebrity.each do |item|
      @name_list << item.celebrity['name']
    end
    @name_list
  end
end
