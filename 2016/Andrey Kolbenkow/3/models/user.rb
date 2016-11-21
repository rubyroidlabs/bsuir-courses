require 'active_record'
class User < ActiveRecord::Base
  has_one :phrase
  has_many :words
end
