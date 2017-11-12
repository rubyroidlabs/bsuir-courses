require 'yandex-translator'

# Translator
class Translate
  attr_reader :translator

  def initialize
    api_key = 'trnsl.1.1.20171112T161052Z.7fd0c221c844740d.'\
    'df72307a53165db5bebe7f8a82b7e0d71761e41b'
    @translator = Yandex::Translator.new(api_key)
  end

  def translate(text)
    translator.translate text, from: 'en'
  end
end
