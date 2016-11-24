class Word
  include Mongoid::Document

  field :text, type: String
  field :username, type: String
  field :time, type: String

end
