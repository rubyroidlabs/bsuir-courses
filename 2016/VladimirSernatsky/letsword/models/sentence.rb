class Sentence < ActiveRecord::Base
  validates :text, presence: true

  has_many :commits

  def self.word(s)
    s.strip.split(" ")[0]
  end

  def self.is_mark?(s)
    %w(, : ! ? ;).include? s
  end

  def add_word(w)
    if Sentence.is_mark?(w)
      self.text += w
    else
      self.text += " #{w}"
    end
  end
end
