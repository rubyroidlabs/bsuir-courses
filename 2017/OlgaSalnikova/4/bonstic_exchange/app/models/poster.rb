class Poster < ApplicationRecord
  has_many :comments

  validates :title, presence: true,
                   length: {minimum: 10, maximum: 255}
  validates :contact, presence: true,
            length: {minimum: 13, maximum: 255}
end
