class Article < ApplicationRecord
  default_scope -> { order('updated_at') }
  paginates_per 8
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { in: 3..20 }
  validates :text, presence: true, length: { in: 2..100 }
end
