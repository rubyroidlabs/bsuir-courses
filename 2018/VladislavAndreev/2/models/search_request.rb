# frozen_string_literal: true

require 'active_record'

class SearchRequest < ActiveRecord::Base
  belongs_to :user
end
