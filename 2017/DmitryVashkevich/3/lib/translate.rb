require 'yandex-translator'

class Translate
  attr_reader :translator

  def initialize
    apy_key = 'trnsl.1.1.20171106T230223Z.05c572ebbca2db51.1a7ca6877297b8f5898'\
              '50da8bfe460ee70a82137'
    @translator = Yandex::Translator.new(apy_key)
  end

  def translate(text)
    translator.translate text, from: 'en'
  end
end
