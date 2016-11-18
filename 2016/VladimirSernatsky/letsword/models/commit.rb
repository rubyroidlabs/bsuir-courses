class Commit < ActiveRecord::Base
  validates :word, presence: true

  belongs_to :sentence
  belongs_to :user
end
