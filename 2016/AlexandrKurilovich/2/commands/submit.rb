class Submit < Command #:nodoc:
  def message
    reset_status
    @data["submit"] = 1
    @redis.set(@message.chat.id.to_s, @data.to_json)
    subjects_names = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @subjects.keys, one_time_keyboard: true)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Выбирай предмет", reply_markup: subjects_names)
  end

  def handler
    unless @data.nil?
      case @data["submit"]
      when 1
        message_get_lab
      when 2
        message_end_of_input
      end
    end
  end

  private

  def message_get_lab
    return unless data_valid?(@message.text)
    @data["last_submit_subject"] = @message.text
    @data["submit"] = 2
    @redis.set(@message.chat.id.to_s, @data.to_json)
    subjects_labs = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: @subjects[@message.text].map { |x| x.to_s }, one_time_keyboard: true)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Какую лабу сдал?", reply_markup: subjects_labs)
  end

  def message_end_of_input
    return unless number?(@message.text)
    return unless invalid_lab(@message.text)
    @data["submit"] = 0
    @subjects[@data["last_submit_subject"]].delete(@message.text.to_i)
    @data["submit"] = @subjects
    @redis.set(@message.chat.id.to_s, @data.to_json)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Красава! Поздравляю!", reply_markup: hide_clav)
  end

  def data_valid?(data)
    if @subjects[data].nil?
      @bot.api.sendMessage(chat_id: @message.chat.id, text: "Нет такого предмета")
      false
    else
      true
    end
  end

  def number?(data)
    if (data =~ /^\d+$/).nil?
      @bot.api.sendMessage(chat_id: @message.chat.id, text: "Лабы надо вводить циферками")
      false
    else
      true
    end
  end

  def invalid_lab(data)
    unless @subjects[@data["last_submit_subject"]].include?(data.to_i)
      @bot.api.sendMessage(chat_id: @message.chat.id, text: "Нет такой лабы")
      false
    else
      true
    end
  end
end
