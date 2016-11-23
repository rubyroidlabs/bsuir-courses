# migration
class AddingTimestamps < ActiveRecord::Migration[5.0]
  def up
    change_table(:updates).map(&:timestamps)
    remove_column :updates, :update_time
  end

  def down
    remove_column :updates, :created_at
    remove_column :updates, :updated_at
  end
end
