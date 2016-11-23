# class Update
class Update < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :users
end
