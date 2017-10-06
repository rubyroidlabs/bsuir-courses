# Add Ban To Users
class AddBanToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ban, :boolean, default: false
  end
end
