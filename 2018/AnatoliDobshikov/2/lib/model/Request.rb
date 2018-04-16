require 'pg'
require 'active_record'

class Request < ActiveRecord::Base
  # owner of the requests history
  belongs_to :user
end
