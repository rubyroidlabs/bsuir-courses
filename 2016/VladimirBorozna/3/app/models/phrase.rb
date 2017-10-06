class Phrase < ActiveRecord::Base #:nodoc:
  has_many :words, counter_cache: :words_count, inverse_of: :phrase

  before_create do
    next_id = Phrase.maximum(:phrase_id)&.next
    self.phrase_id = next_id || 1 if new_record?
  end

  accepts_nested_attributes_for :words
end
