# phrase
class Phrase < ActiveRecord::Base
  has_many :words

  def full_phrase
    words.map { |v| v.data + " " }.inject("+")
  end

  def color(current_id)
    return "green" if current_id != last_user
    "red"
  end

  def can_add?(current_id)
    return true if current_id != last_user
    false
  end
end
