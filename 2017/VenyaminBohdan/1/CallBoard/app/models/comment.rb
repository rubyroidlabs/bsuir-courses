class Comment < ApplicationRecord
  belongs_to :ad
  belongs_to :user
end
