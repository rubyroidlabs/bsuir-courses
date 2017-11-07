require 'yandex-translator'

API_KEY = 'trnsl.1.1.20171106T230223Z.05c572ebbca2db51.1a7ca6877297b8f589850da'\
          '8bfe460ee70a82137'

class Translate
  attr_reader :translator

  def initialize
    @translator = Yandex::Translator.new(API_KEY)
  end

  def translate(text)
    translator.translate text, from: 'en'
  end

end