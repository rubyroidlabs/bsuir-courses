class Comment < ApplicationRecord
  belongs_to :advert
  default_scope -> { order('created_at DESC') }
  validates :content,   presence: true, length: { maximum: 200 }
  validates :user_id,   presence: true
  validates :advert_id, presence: true
end
