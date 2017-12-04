class Comment < ApplicationRecord
  belongs_to :post

  validates_length_of :text, minimum: 5, maximum: 60
end
