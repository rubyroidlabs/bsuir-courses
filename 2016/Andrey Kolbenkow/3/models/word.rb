require 'active_record'
class Word < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :user
end
