# migration
class AddingListOfUpdatesInPhrases < ActiveRecord::Migration[5.0]
  def up
    remove_columns :phrases, :last_user_id
    create_table :updates do |t|
      t.datetime :update_time
      t.string :word
    end
  end

  def down
    add_column :phrases, :last_user_id, :integer
    drop_table :updates
  end
end
