class User < ActiveRecord::Base #:nodoc:
  attr_accessor :remember_token

  has_secure_password

  validates_presence_of     :name,     on: :create
  validates_presence_of     :password, on: :create
  validates_confirmation_of :password, on: :create

  validates_length_of :name,     minimum: 1, maximum: 25, allow_nil: true
  validates_length_of :password, minimum: 4, maximum: 15, allow_nil: true

  has_secure_password

  validates_uniqueness_of :name, case_sensitive: false

  has_many :words

  before_create do
    next_id = User.maximum(:user_id)&.next
    self.user_id = next_id || 1 if new_record?
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def remembered?(token)
    return if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
