class AddContactDataToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :contact_data, :string
  end
end
