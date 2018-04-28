require 'pg'
require 'active_record'

class User < ActiveRecord::Base
  # requests history
  has_many :requests, dependent: :destroy
end
