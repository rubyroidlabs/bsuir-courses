class ReplyMarkupFormatter
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def getmarkup
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [array], one_time_keyboard: true)
  end
end
