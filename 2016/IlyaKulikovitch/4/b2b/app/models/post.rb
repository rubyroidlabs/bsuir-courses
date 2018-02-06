class Post < ApplicationRecord
  validates :title, :body, :cotacts, presence: true
  has_many :comments
end
