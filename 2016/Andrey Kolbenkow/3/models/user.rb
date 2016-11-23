require 'active_record'
class User < ActiveRecord::Base
  has_many :phrase
  has_many :words
end
