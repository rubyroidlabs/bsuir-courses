require './lib/collecting_answer'
require './lib/sourse_collecting'
require './lib/beauty_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @ans_message = MakeAnswer.new(bot: bot, chat: message.chat)
  end

  def respond
    case message.text
    when '/start'
      answer_with_greeting_message
    when 'Спасибо!'
      answer_with_no_problem_message
    when '/stop'
      answer_with_farewell_message
    else
      make_sourse_collecting
    end
  end

  private

  def answer_with_no_problem_message
    bot.api.send_message(
      chat_id: message.chat.id,
      text:"No problem, #{message.from.first_name}"
    )
  end

  def answer_with_greeting_message
    bot.api.send_message(
      chat_id: message.chat.id,
      text:"Greetings, #{message.from.first_name}"
    )
  end

  def answer_with_farewell_message
    bot.api.send_message(
      chat_id: message.chat.id,
      text:"Chao, #{message.from.first_name}"
    )
  end

  def answer_with_message(text)
    @ans_message.send(text)
  end

  def make_sourse_collecting
    msg = CorrectInput.new(message, bot).what_language
    puts message.text
    puts msg.nil?
    if msg.nil? == false
      message.text = msg
    end
    sourse = SourceCollecting.new(message, bot)
    first_info = sourse.imdb_parse
    second_info = sourse.newnow_parse
    third_info = sourse.clever_parse
    BeautySend.new(message, bot, first_info, second_info, third_info).send
  end
end
