class Advert < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :title,   presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
end
