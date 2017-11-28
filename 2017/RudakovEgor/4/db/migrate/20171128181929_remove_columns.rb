class RemoveColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :finances, :created_at
    remove_column :finances, :updated_at
  end
end
