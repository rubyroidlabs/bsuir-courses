# Article model
class Article < ApplicationRecord
  paginates_per 8
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 2 }
end
