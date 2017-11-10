require 'translit'

class Main
  CONST = 0.82 # const of coincidence

  def initialize(bot, message, data)
    @bot = bot
    @message = message
    @data = data
    @res = ''
    @cond = false
  end

  def make_mess
    @data.each do |hash|
      @cond = true if hash['actors'] == @message.text

      convert = Translit.convert(@message.text, :english)

      input = convert.downcase.split('')
      actor = hash['actors'].downcase.split('')

      good_letters = actor & input

      cond = good_letters.size / actor.uniq.size.to_f >= CONST

      if cond
        @res = hash
        break
      else
        @res = 'Не найдено данных, повторите ввод'
      end
    end
    @res
  end

  def send_mess(res)
    if res == 'Не найдено данных, повторите ввод'
      @bot.api.send_message(
        chat_id: @message.chat.id,
        text: 'Не найдено данных, повторите ввод'
      )
    elsif @cond
      @bot.api.send_message(
        chat_id: @message.chat.id,
        text: res['info']
      )
    else
      @bot.api.send_message(
        chat_id: @message.chat.id,
        text: "Возможно, вы имели в виду #{res['actors']}?"
      )
    end
  end
end
