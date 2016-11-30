class Start < Command #:nodoc:
  def message
    reset_status
    @bot.api.sendMessage(
      chat_id: @message.chat.id, text: "Привет, #{@message.from.first_name}. Я помогу тебе сдать все лабы, чтобы мамка не ругалась.
      \nСмотри что я умею:
      \n/semester - запоминает даты начала и конца семестра.
      \n/subject - добавляет предмет и количество лабораторных работ по нему.
      \n/status - выводит твой список лаб, которые тебе предстоит сдать.
      \n/submit - убирает сданную лабу из списка, можно написать просто \"я сдал\".
      \n/reset - сбрасывает для пользователя все данные.", reply_markup: hide_clav
    )
  end
end
