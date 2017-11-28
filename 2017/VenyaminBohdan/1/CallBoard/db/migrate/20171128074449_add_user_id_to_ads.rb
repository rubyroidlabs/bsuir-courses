class AddUserIdToAds < ActiveRecord::Migration[5.1]
  def change
    add_column :ads, :user_id, :integer
  end
end
