class CommentAnalisys
  attr_reader :frequent_words
  def initialize
    @frequent_words = Hash.new(0)
    agent = Mechanize.new
    tpage = agent.get('http://webtranslation.paralink.com/English-Spanish-Translation/')
  end

  def comment_translate(comment)
    tpage.forms[0] = 'comment'

  end

  def find_frequent_words(comments)
    comments = comments.join(' ')

    words = comments.downcase!.split(' ')
    words.each { |word| @frequent_words[word.downcase] += 1 }
    @frequent_words.delete_if { |k, _v| k.length < 3 }.sort_by { |_k, v| v }
  end
end

begin

end
