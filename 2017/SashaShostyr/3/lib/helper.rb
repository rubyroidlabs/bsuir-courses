require 'fuzzy_match'
require 'translit'

class Helper
  def self.translit(name)
    Translit.convert(name, :english)
  end

  def self.find(name)
    data = Parser.new.get_data
    list_names = data.keys
    FuzzyMatch.new(list_names).find(translit(name))
  end
end
