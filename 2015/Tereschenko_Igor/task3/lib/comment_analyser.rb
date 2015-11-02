#work in progress
class CommentAnalisys
  attr_reader :frequent_words
  def initialize
    @frequent_words = Hash.new(0)
  end

  def find_frequent_words(comments)
    comments = comments.join(' ')

    words = comments.downcase!.split(' ')
    words.each { |word| @frequent_words[word.downcase] += 1 }
    @frequent_words.delete_if { |k, _v| k.length < 3 }
    return @frequent_words.sort_by { |_k, v| v }
  end
end
