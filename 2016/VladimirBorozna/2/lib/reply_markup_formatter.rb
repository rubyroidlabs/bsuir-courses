# Class is required to generate required keyboard markup
class ReplyMarkupFormatter
  def self.markup(array, slice_size = 1)
    markup = array.each_slice(slice_size).to_a
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(
      keyboard: markup,
      one_time_keyboard: true,
      resize_keyboard: true
    )
  end
end
