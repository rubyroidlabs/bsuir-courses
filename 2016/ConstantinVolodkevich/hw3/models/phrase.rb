class Phrase
  include Mongoid::Document
  store_in collection: 'phrases'

  field :user, type: String
  field :last_user, type: String
  field :words, type: Array
end
