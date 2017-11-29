class Post < ApplicationRecord
  has_many :comments
  validates :title, presence: true,
                      length: { minimum: 3}
  validates :kind, presence: true
  validates :item, presence: true
end
