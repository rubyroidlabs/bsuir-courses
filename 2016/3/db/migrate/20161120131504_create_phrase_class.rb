# migration
class CreatePhraseClass < ActiveRecord::Migration[5.0]
  def up
    create_table :phrases do |t|
      t.string :body
      t.integer :last_user_id
    end
  end

  def down
    drop_table :phrases
  end
end
