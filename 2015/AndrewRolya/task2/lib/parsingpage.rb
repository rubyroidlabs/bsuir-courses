require 'open-uri/cached'
class ParsingPage
  def initialize(name_gem)
    @name_gem = name_gem
  end

  def parsing_page
    begin
      source_text = open("https://rubygems.org/gems/#{@name_gem}/versions").read
    rescue OpenURI::HTTPError 
      puts 'Invalid name of gem (Error)'
      exit
    end
    selection = source_text.scan(/versions\/\w.+"/)
    selection.size.times do |i|
      selection[i] = Gem::Version.new(selection[i][/\d[\d.\w]*/])
    end
    selection
  end
end
