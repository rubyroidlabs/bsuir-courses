require "active_record"

class User < ActiveRecord::Base
  validates :name, :password, presence: true
  validates :name, uniqueness: true

  has_many :commits
  has_many :sentences, through: :commits
end
