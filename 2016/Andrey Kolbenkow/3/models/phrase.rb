require 'active_record'
class Phrase < ActiveRecord::Base
  has_many :words
  belongs_to :user
end
