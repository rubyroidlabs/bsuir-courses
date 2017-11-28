class Comment < ApplicationRecord
  belongs_to :post

  validates_presence_of :text
  validates_length_of :text, minimum: 5, maximum: 60
end
