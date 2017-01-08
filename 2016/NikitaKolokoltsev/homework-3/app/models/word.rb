# Word
class Word < ActiveRecord::Base
  belongs_to :quote
  belongs_to :user
end
