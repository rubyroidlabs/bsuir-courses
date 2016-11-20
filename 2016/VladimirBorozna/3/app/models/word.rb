class Word < ActiveRecord::Base #:nodoc:
  belongs_to :phrase, inverse_of: :words
  belongs_to :user

  validates_presence_of :phrase
  validates_presence_of :content
  validates_length_of   :content, minimum: 3, maximum: 25
end
