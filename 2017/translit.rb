require 'translit'
# class for soft comparison of 2 words in different languages
class TranslitSoft
  attr_accessor :original
  attr_accessor :transliteration
  attr_accessor :coefficient
  def initialize
    @coefficient = 0.6
  end

  def transliterate(original_string)
    @original = original_string
    @transliteration = Translit.convert(@original)
  end

  def soft_comparison(eng_str, rus_str)
    transliterate(rus_str)
    rus_str = @transliteration
    min_word_length = [eng_str.length, rus_str.length].min
    coincidence_counter = 0
    i = 0
    while i < min_word_length
      coincidence_counter += 1 if eng_str[i] == rus_str[i]
      i += 1
    end
    coincidence_counter >= min_word_length * @coefficient
  end
end
