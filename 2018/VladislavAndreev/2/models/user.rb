# frozen_string_literal: true

require 'active_record'

class User < ActiveRecord::Base
  has_many :search_requests
end
