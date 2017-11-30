class Poster < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, :description, :contacts, presence: true
end
