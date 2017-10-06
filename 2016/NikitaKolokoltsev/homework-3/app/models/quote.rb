# Quote
class Quote < ActiveRecord::Base
  belongs_to :user
  has_many :words
end
