class BeautySend
  attr_reader :bot
  attr_reader :message

  h = 'http://www.theclever.com/15-celebs-you-didnt-know-were-gay-or'
  CLEVER_ACTORS = h + '-bisexual/'.freeze

  IMDB_ACTORS = 'http://www.imdb.com/list/ls072706884/'.freeze

  h = 'http://www.newnownext.com/gay-celebrities-comi'
  NEWNOW_ACTORS = h + 'ng-out-2017/10/2017/'.freeze

  def initialize(message, bot, first_info, second_info, third_info)
    @message = message
    @bot = bot
    @first_info = first_info
    @second_info = second_info
    @third_info = third_info
  end

  def send
    speak_about_first_info
    speak_about_second_info
    speak_about_third_info
  end

  def speak_about_first_info
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "Первый источник это #{IMDB_ACTORS}"
    )

    if @first_info.nil?
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'К сожалению, информации об этом человеке тут нет.'
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Информация такая: #{@first_info[:actor]} #{@first_info[:info]}"
      )
    end
  end

  def speak_about_second_info
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "Второй источник это #{NEWNOW_ACTORS}"
    )

    if @second_info.nil?
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'К сожалению, информации об этом человеке тут нет.'
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Информация такая: #{@second_info[:actor]} #{@second_info[:info]}"
      )
    end
  end

  def speak_about_third_info
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "Третий источник это #{CLEVER_ACTORS}"
    )

    if @third_info.nil?
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'К сожалению, информации об этом человеке тут нет.'
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Информация такая: #{@third_info[:actor]} #{@third_info[:info]}"
      )
    end
  end
end
