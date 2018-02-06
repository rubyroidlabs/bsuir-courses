class AddContactsToPosters < ActiveRecord::Migration[5.1]
  def change
    add_column :posters, :contacts, :string
  end
end
