class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates_length_of :title, minimum: 7, maximum: 25
  validates_length_of :description, minimum: 10, maximum: 256
  validates_length_of :contacts, minimum: 10, maximum: 256
  validates_numericality_of :bonsticks, greater_than_or_equal_to: 1
  validates_numericality_of :bitcoins, greater_than: 0
end
