class User
  include Mongoid::Document
  store_in collection: 'users'

  validates :username, :uniqueness => true

  field :username, type: String
  field :password, type: String

end
