# Main class for all telegram method
class Base
  attr_accessor :bot, :user_id, :messages_array, :last_message

  def initialize(bot, message_chat_id)
    @bot = bot
    @user_id = message_chat_id

    @redis = Redis.new

    @last_message = @bot.api.getUpdates["result"].last["message"]["text"]
    @messages_array = []
    @messages_array << @last_message
  end

  def update_last
    @last_message = @bot.api.getUpdates["result"].last["message"]["text"]
  end

  def take_new_answer
    Timeout.timeout(30) do
      while @messages_array.last == @last_message
        @messages_array << @bot.api.getUpdates["result"].last["message"]["text"]
        @messages_array.uniq!
      end
      update_last
    end
  rescue then telegram_send_message('Слишком долго отвечаешь ...')
  end

  def num_to_sequence(seq)
    num = seq.length
    arr = []
    slice_size = num >= 3 ? num / 3 : 1
    seq.each_slice(slice_size) { |a| arr << a.map(&:to_s) }
    arr
  end

  def num_to_str_sequence(num)
    num = num.to_i if num.is_a?(String)
    (1..num).to_a
  end

  def telegram_send_message(text, answers = nil)
    if answers.nil?
      @bot.api.send_message(chat_id: @user_id, text: text)
    else
      @bot.api.send_message(chat_id: @user_id, text: text, reply_markup: answers)
    end
  end
end
