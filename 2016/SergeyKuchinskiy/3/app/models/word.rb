# word
class Word < ActiveRecord::Base
  belongs_to :user
  belongs_to :phrase
end
