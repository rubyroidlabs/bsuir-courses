require 'open-uri/cached'
class ParsingPage
  def initialize(name_gem)
    @p_name_gem = name_gem
  end
  def parsing_page
    source_text = open("https://rubygems.org/gems/#{@p_name_gem}/versions").read
    selection = source_text.scan(/versions\/\w.+"/)
    selection.size.times do |i|
      selection[i] = Gem::Version.new(selection[i][/\d[\d.\w]*/])
    end
    return selection
  end
end
