# migration
class ChangeUpdates < ActiveRecord::Migration[5.0]
  def up
    add_column :updates, :prev_phrase, :string
  end

  def down
    remove_column :updates, :prev_phrase
  end
end
